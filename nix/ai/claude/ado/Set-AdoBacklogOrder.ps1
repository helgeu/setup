#!/usr/bin/env pwsh
# Set ADO backlog order (Microsoft.VSTS.Common.StackRank; lower = higher in the backlog).
# Epics are ranked in the order they appear in the backlog file (top of file = top of
# backlog); features follow their order within each epic. Curate the priority by
# arranging the backlog file itself.
#   Set-AdoBacklogOrder.ps1 -Config <org>-<project> -Backlog ./backlog.json
param(
    [Parameter(Mandatory)][string]$Config,
    [Parameter(Mandatory)][string]$Backlog
)
. "$PSScriptRoot/Ado.Common.ps1"
$cfg = Get-AdoConfig -Key $Config
Assert-AdoLogin
$org = $cfg.organizationUrl; $proj = $cfg.project

if (-not (Test-Path $Backlog)) { throw "Backlog not found: $Backlog" }
$data = Get-Content $Backlog -Raw | ConvertFrom-Json

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
foreach ($e in $data.epics) {
    $eid = $idOf["Epic|$($e.title)"]
    if ($eid) { Set-Rank $eid $rank; Write-Host ("{0,4}  Epic  {1}" -f $rank, $e.title) }
    else { Write-Host "!! epic not found in board: $($e.title)" }
    $rank += 10
}

$rank = 10
foreach ($e in $data.epics) {
    foreach ($f in $e.features) {
        $fid = $idOf["Feature|$($f.title)"]
        if ($fid) { Set-Rank $fid $rank }
        $rank += 10
    }
}
Write-Host "`nBacklog order applied."
