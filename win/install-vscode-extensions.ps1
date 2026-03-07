# Installs VS Code extensions
#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$extensions = @(
    '42crunch.vscode-openapi'
    'ionide.ionide-fsharp'
    'ms-azure-devops.azure-pipelines'
    'ms-azuretools.vscode-azurefunctions'
    'ms-azuretools.vscode-azureresourcegroups'
    'ms-azuretools.vscode-azurestorage'
    'ms-azuretools.vscode-bicep'
    'ms-azuretools.vscode-docker'
    'ms-dotnettools.csdevkit'
    'ms-vscode.powershell'
    'hediet.vscode-drawio'
    'devcycles.contextive'
    'ChrisChinchilla.vscode-pandoc'
    'bierner.markdown-mermaid'
)

Write-Host "Installing VS Code extensions..." -ForegroundColor Cyan
foreach ($ext in $extensions) {
    Write-Host "  Installing $ext" -ForegroundColor Yellow
    code --install-extension $ext
}

Write-Host "`nDone!" -ForegroundColor Green
