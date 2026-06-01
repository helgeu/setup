#!/usr/bin/env pwsh
# Pull the live board from ADO (the source of truth) into files:
#   - <JsonPath>  : machine-readable backlog (round-trips with Import-AdoBacklog)
#   - <MdPath>    : human-readable snapshot for the wiki
# ADO is master; these are GENERATED — never hand-edit them.
#   Export-AdoBacklog.ps1 -Config urholm-Devkunt -JsonPath ./backlog.json -MdPath ./Backlog.md
param(
    [Parameter(Mandatory)][string]$Config,
    [string]$JsonPath = "./backlog.json",
    [string]$MdPath   = "./Backlog.md"
)
. "$PSScriptRoot/Ado.Common.ps1"
$cfg = Get-AdoConfig -Key $Config
Assert-AdoLogin
$org = $cfg.organizationUrl; $proj = $cfg.project

$wiql = "SELECT [System.Id],[System.Title],[System.WorkItemType],[System.Tags],[System.State],[System.Parent],[System.Description],[Microsoft.VSTS.Common.StackRank] " +
        "FROM workitems WHERE [System.TeamProject]='$proj' AND [System.WorkItemType] IN ('Epic','Feature')"
$rows = az boards query --org $org --project $proj --wiql $wiql -o json | ConvertFrom-Json

function Rank($w) { $r = $w.fields.'Microsoft.VSTS.Common.StackRank'; if ($null -eq $r) { [double]::MaxValue } else { [double]$r } }
function Strip($h) {
    if ($null -eq $h) { return '' }
    ((($h -replace '<[^>]+>', '') -replace '&lt;', '<' -replace '&gt;', '>' -replace '&quot;', '"' -replace '&#39;', "'" -replace '&nbsp;', ' ') -replace '&amp;', '&').Trim()
}

$epics = $rows | Where-Object { $_.fields.'System.WorkItemType' -eq 'Epic' }    | Sort-Object { Rank $_ }
$feats = $rows | Where-Object { $_.fields.'System.WorkItemType' -eq 'Feature' }

$outEpics = @()
$md = @(
    "# Backlog — live snapshot from ADO",
    "",
    "> **Generated** from the **$proj** board by ``Export-AdoBacklog.ps1`` — do not hand-edit. ADO is the source of truth; the wiki holds the *why* (per ADR 0018).",
    ""
)
foreach ($e in $epics) {
    $ef = $feats | Where-Object { $_.fields.'System.Parent' -eq $e.id } | Sort-Object { Rank $_ }
    $outEpics += [ordered]@{
        id    = $e.id
        title = $e.fields.'System.Title'
        tags  = $e.fields.'System.Tags'
        state = $e.fields.'System.State'
        description = Strip $e.fields.'System.Description'
        features = @($ef | ForEach-Object {
            [ordered]@{ id = $_.id; title = $_.fields.'System.Title'; tags = $_.fields.'System.Tags'; state = $_.fields.'System.State'; description = Strip $_.fields.'System.Description' }
        })
    }
    $tag = if ($e.fields.'System.Tags') { "  `[$($e.fields.'System.Tags')`]" } else { "" }
    $md += "## $($e.fields.'System.Title')$tag"
    $edesc = Strip $e.fields.'System.Description'; if ($edesc) { $md += $edesc; $md += "" }
    if ($ef) {
        foreach ($f in $ef) {
            $ft = if ($f.fields.'System.Tags') { " _($($f.fields.'System.Tags'))_" } else { "" }
            $fd = Strip $f.fields.'System.Description'; if ($fd) { $fd = " — $fd" }
            $md += "- **$($f.fields.'System.Title')**$ft$fd"
        }
    } else { $md += "_(no features — see epic narrative in the wiki)_" }
    $md += ""
}

([ordered]@{ generatedFrom = "$org/$proj"; epics = $outEpics } | ConvertTo-Json -Depth 8) | Set-Content -Path $JsonPath -Encoding utf8
($md -join "`n") | Set-Content -Path $MdPath -Encoding utf8
Write-Host "Exported $($epics.Count) epics, $($feats.Count) features -> $JsonPath + $MdPath"
