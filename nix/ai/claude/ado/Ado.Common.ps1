# Shared helpers for the ADO toolkit. Dot-source:  . "$PSScriptRoot/Ado.Common.ps1"
# Reads org/project configs from ~/.claude/ado/configs/<org>-<project>.json (nix-generated).
$ErrorActionPreference = 'Stop'

function Get-AdoConfig {
    param([Parameter(Mandatory)][string]$Key)   # e.g. <org>-<project>
    $path = Join-Path $HOME ".claude/ado/configs/$Key.json"
    if (-not (Test-Path $path)) { throw "No ADO config '$Key' at $path" }
    $cfg = Get-Content $path -Raw | ConvertFrom-Json
    if ($cfg.azureConfigDir) { $env:AZURE_CONFIG_DIR = $cfg.azureConfigDir }
    return $cfg
}

function Assert-AdoLogin {
    az account show -o none 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Not logged in (AZURE_CONFIG_DIR=$($env:AZURE_CONFIG_DIR)). Run: az login --allow-no-subscriptions"
    }
}

function Get-AdoTitles {
    param([Parameter(Mandatory)][string]$Org, [Parameter(Mandatory)][string]$Project)
    $out = az boards query --org $Org --project $Project `
        --wiql "SELECT [System.Title] FROM workitems WHERE [System.TeamProject]='$Project'" `
        --query '[].fields."System.Title"' -o tsv 2>$null
    if ([string]::IsNullOrWhiteSpace($out)) { return @() }
    return @($out -split "`n" | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' })
}

function Get-AdoIdByTitle {
    param([string]$Org, [string]$Project, [string]$Title, [string]$Type)
    $t = $Title -replace "'", "''"
    $wiql = "SELECT [System.Id] FROM workitems WHERE [System.Title]='$t' AND [System.WorkItemType]='$Type'"
    $id = az boards query --org $Org --project $Project --wiql $wiql --query "[0].id" -o tsv 2>$null
    if ([string]::IsNullOrWhiteSpace($id)) { return 0 }
    return [int]$id.Trim()
}

function New-AdoItem {
    param(
        [Parameter(Mandatory)][string]$Org,
        [Parameter(Mandatory)][string]$Project,
        [Parameter(Mandatory)][string]$Type,
        [Parameter(Mandatory)][string]$Title,
        [string]$Description = '',
        [string]$Tags = '',
        [int]$ParentId = 0
    )
    $a = @('boards','work-item','create','--org',$Org,'--project',$Project,
           '--type',$Type,'--title',$Title,'--query','id','-o','tsv')
    if ($Description) { $a += @('--description',$Description) }
    if ($Tags)        { $a += @('--fields',"System.Tags=$Tags") }
    $id = az @a
    if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($id)) { throw "Create failed: $Type '$Title'" }
    $id = [int]$id.Trim()
    if ($ParentId -gt 0) {
        az boards work-item relation add --org $Org --id $id --relation-type parent --target-id $ParentId -o none
        if ($LASTEXITCODE -ne 0) { throw "Link failed: $Type #$id -> parent #$ParentId" }
    }
    return $id
}
