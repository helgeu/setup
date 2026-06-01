#!/usr/bin/env pwsh
# Create a single ADO work item (optionally parent-linked).
#   New-AdoWorkItem.ps1 -Config <org>-<project> -Type Feature -Title "..." -ParentId 12 -Tags MVP
param(
    [Parameter(Mandatory)][string]$Config,
    [Parameter(Mandatory)][string]$Type,
    [Parameter(Mandatory)][string]$Title,
    [string]$Description = '',
    [string]$Tags = '',
    [int]$ParentId = 0
)
. "$PSScriptRoot/Ado.Common.ps1"
$cfg = Get-AdoConfig -Key $Config
Assert-AdoLogin
$id = New-AdoItem -Org $cfg.organizationUrl -Project $cfg.project -Type $Type `
                  -Title $Title -Description $Description -Tags $Tags -ParentId $ParentId
Write-Host "Created $Type #${id}: $Title"
$id
