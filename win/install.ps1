# Windows setup script - installs apps via winget
#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$packages = @(
    'Microsoft.PowerShell.Preview'
    'Microsoft.WindowsTerminal'
    'Microsoft.Azure.FunctionsCoreTools'
    'Microsoft.VisualStudioCode'
    'Microsoft.VisualStudio.2022.Professional'
    'Microsoft.SQLServerManagementStudio'
    'JanDeDobbeleer.OhMyPosh'
    'Git.Git'
    'Mozilla.Firefox'
    'Docker.DockerDesktop'
    'Bruno.Bruno'
    'Microsoft.PowerToys'
    'Microsoft.AzureCLI'
    'OpenJS.NodeJS.LTS'
    'ShiningLight.OpenSSL.Dev'
    'JohnMacFarlane.Pandoc'
    'Spotify.Spotify'
    'WiresharkFoundation.Wireshark'
    'Neovim.Neovim'
    'JesseDuffield.lazygit'
    'junegunn.fzf'
    'BurntSushi.ripgrep.MSVC'
    'sharkdp.fd'
    'Microsoft.Sysinternals'
)

Write-Host "Installing packages via winget..." -ForegroundColor Cyan
foreach ($pkg in $packages) {
    Write-Host "  Installing $pkg" -ForegroundColor Yellow
    winget install --exact --id $pkg --accept-source-agreements --accept-package-agreements
}

Write-Host "`nInstalling Oh My Posh fonts..." -ForegroundColor Cyan
oh-my-posh font install meslo
oh-my-posh font install firacode

Write-Host "`nInstalling Azure Artifacts credential provider..." -ForegroundColor Cyan
Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-artifacts-credprovider.ps1) }"

Write-Host "`nDone! Run install-vscode-extensions.ps1 next." -ForegroundColor Green
