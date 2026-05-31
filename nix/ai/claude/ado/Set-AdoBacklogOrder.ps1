#!/usr/bin/env pwsh
# Set ADO backlog order (Microsoft.VSTS.Common.StackRank; lower = higher in the backlog).
# Epic priority is the $EpicOrder list below (dependency/MVP-driven); features follow
# their order within each epic in the backlog file, grouped by epic priority.
#   Set-AdoBacklogOrder.ps1 -Config urholm-Devkunt -Backlog ./devkunt-backlog.json
param(
    [Parameter(Mandatory)][string]$Config,
    [Parameter(Mandatory)][string]$Backlog
)
. "$PSScriptRoot/Ado.Common.ps1"
$cfg = Get-AdoConfig -Key $Config
Assert-AdoLogin
$org = $cfg.organizationUrl; $proj = $cfg.project

# Top of backlog first. Foundations -> identity -> compliance -> organiser -> handler
# -> payments -> execution -> resale -> admin; then deferred, then stubs.
$EpicOrder = @('E01','E14','E11','E12','E02','E13','E03','E04','E05',
               'E06','E07','E09','E08','E15','E10','E16','E17','E18','E19')

if (-not (Test-Path $Backlog)) { throw "Backlog not found: $Backlog" }
$data = Get-Content $Backlog -Raw | ConvertFrom-Json
$byCode = @{}; foreach ($e in $data.epics) { $byCode[$e.code] = $e }

# One query: title|type -> id
$rows = az boards query --org $org --project $proj `
    --wiql "SELECT [System.Id],[System.Title],[System.WorkItemType] FROM workitems WHERE [System.TeamProject]='$proj'" `
    --query '[].{id:id,title:fields."System.Title",type:fields."System.WorkItemType"}' -o json | ConvertFrom-Json
$idOf = @{}; foreach ($r in $rows) { $idOf["$($r.type)|$($r.title)"] = $r.id }

function Set-Rank([int]$id, [int]$rank) {
    az boards work-item update --org $org --id $id --fields "Microsoft.VSTS.Common.StackRank=$rank" -o none
    if ($LASTEXITCODE -ne 0) { throw "StackRank update failed for #$id" }
}

$rank = 10
foreach ($code in $EpicOrder) {
    $e = $byCode[$code]
    if (-not $e) { Write-Host "!! no epic $code in backlog"; continue }
    $eid = $idOf["Epic|$($e.title)"]
    if ($eid) { Set-Rank $eid $rank; Write-Host ("{0,4}  Epic  {1}" -f $rank, $e.title) }
    $rank += 10
}

$rank = 10
foreach ($code in $EpicOrder) {
    $e = $byCode[$code]
    if (-not $e) { continue }
    foreach ($f in $e.features) {
        $fid = $idOf["Feature|$($f.title)"]
        if ($fid) { Set-Rank $fid $rank }
        $rank += 10
    }
}
Write-Host "`nBacklog order applied."
