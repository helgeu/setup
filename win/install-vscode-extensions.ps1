# Installs VS Code extensions
#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$extensions = @(
    '42crunch.vscode-openapi'
    'redhat.vscode-yaml'                       # Required by vscode-openapi
    'ionide.ionide-fsharp'
    'ms-dotnettools.vscode-dotnet-runtime'      # Required by csdevkit
    'ms-dotnettools.csharp'                     # Required by csdevkit
    'ms-dotnettools.csdevkit'
    'ms-vscode.powershell'
    'hediet.vscode-drawio'
    'ChrisChinchilla.vscode-pandoc'
    'bierner.markdown-mermaid'
)

Write-Host "Installing VS Code extensions..." -ForegroundColor Cyan
foreach ($ext in $extensions) {
    Write-Host "  Installing $ext" -ForegroundColor Yellow
    code --install-extension $ext
}

Write-Host "`nDone!" -ForegroundColor Green
