#!/usr/bin/env pwsh
# Idempotently seed an Epic/Feature hierarchy from a backlog JSON file.
#   Import-AdoBacklog.ps1 -Config <org>-<project> -Backlog ./backlog.json [-WhatIf]
# Backlog schema: { "epics": [ { code,title,tags,description, features:[ {title,tags,description} ] } ] }
param(
    [Parameter(Mandatory)][string]$Config,
    [Parameter(Mandatory)][string]$Backlog,
    [switch]$WhatIf
)
. "$PSScriptRoot/Ado.Common.ps1"
$cfg = Get-AdoConfig -Key $Config
Assert-AdoLogin
$org  = $cfg.organizationUrl
$proj = $cfg.project

if (-not (Test-Path $Backlog)) { throw "Backlog file not found: $Backlog" }
$data = Get-Content $Backlog -Raw | ConvertFrom-Json

$have = @{}
foreach ($t in (Get-AdoTitles -Org $org -Project $proj)) { $have[$t] = $true }

$epicsNew = 0; $featNew = 0; $skipped = 0
foreach ($epic in $data.epics) {
    if ($have.ContainsKey($epic.title)) {
        $eid = Get-AdoIdByTitle -Org $org -Project $proj -Title $epic.title -Type 'Epic'
        Write-Host "= epic exists (#$eid): $($epic.title)"; $skipped++
    }
    elseif ($WhatIf) { Write-Host "+ (whatif) epic: $($epic.title)"; $eid = 0 }
    else {
        $eid = New-AdoItem -Org $org -Project $proj -Type 'Epic' `
                           -Title $epic.title -Description $epic.description -Tags $epic.tags
        Write-Host "+ epic #${eid}: $($epic.title)"; $epicsNew++
    }

    foreach ($f in $epic.features) {
        if ($have.ContainsKey($f.title)) { Write-Host "    = feature exists: $($f.title)"; $skipped++; continue }
        if ($WhatIf) { Write-Host "    + (whatif) feature: $($f.title)"; continue }
        $fid = New-AdoItem -Org $org -Project $proj -Type 'Feature' `
                           -Title $f.title -Description $f.description -Tags $f.tags -ParentId $eid
        Write-Host "    + feature #${fid} -> epic #${eid}: $($f.title)"; $featNew++
    }
}
Write-Host ""
Write-Host "Done. Created $epicsNew epics, $featNew features. Skipped $skipped existing."
