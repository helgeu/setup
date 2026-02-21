#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Bootstrap script for installing NixOS on WSL2.

.DESCRIPTION
    This script automates the installation of:
    1. WSL2 (if not already installed)
    2. NixOS-WSL distribution
    3. Initial flake configuration

.NOTES
    Run this script from an elevated PowerShell prompt.
    After completion, run the setup script inside WSL.

.EXAMPLE
    # If execution policy blocks the script:
    Set-ExecutionPolicy Bypass -Scope Process -Force
    .\install-wsl-nixos.ps1

    # Or run directly:
    powershell -ExecutionPolicy Bypass -File .\install-wsl-nixos.ps1
#>

param(
    [string]$DistroName = "NixOS",
    [string]$InstallPath = "$env:USERPROFILE\WSL\$DistroName",
    [string]$Username = "helge",
    [string]$FlakeRepo = "https://github.com/helgereneurholm/setup.git",
    [switch]$SkipWSLInstall,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# Colors for output
function Write-Step { param($msg) Write-Host "`n=== $msg ===" -ForegroundColor Cyan }
function Write-Info { param($msg) Write-Host "  $msg" -ForegroundColor Gray }
function Write-Success { param($msg) Write-Host "  $msg" -ForegroundColor Green }
function Write-Warning { param($msg) Write-Host "  $msg" -ForegroundColor Yellow }

Write-Host @"

    _   _ _       ___  ____     __        ______  _
   | \ | (_)_  __/ _ \/ ___|    \ \      / / ___|| |
   |  \| | \ \/ / | | \___ \ ____\ \ /\ / /\___ \| |
   | |\  | |>  <| |_| |___) |_____\ V  V /  ___) | |___
   |_| \_|_/_/\_\\___/|____/       \_/\_/  |____/|_____|

   Bootstrap Installer
"@ -ForegroundColor Magenta

# -----------------------------------------------------------------------------
# Step 1: Check prerequisites
# -----------------------------------------------------------------------------
Write-Step "Checking prerequisites"

# Check Windows version (WSL2 requires Windows 10 version 1903+ or Windows 11)
$osVersion = [System.Environment]::OSVersion.Version
Write-Info "Windows version: $($osVersion.Major).$($osVersion.Minor).$($osVersion.Build)"

if ($osVersion.Build -lt 18362) {
    throw "WSL2 requires Windows 10 version 1903 (build 18362) or later."
}
Write-Success "Windows version OK"

# Check if virtualization is enabled
$hyperv = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty HypervisorPresent
if (-not $hyperv) {
    Write-Warning "Hyper-V/virtualization may not be enabled. WSL2 requires virtualization."
    Write-Warning "Enable it in BIOS if installation fails."
}

# -----------------------------------------------------------------------------
# Step 2: Install/Update WSL
# -----------------------------------------------------------------------------
if (-not $SkipWSLInstall) {
    Write-Step "Installing/Updating WSL"

    # Check if WSL is installed
    $wslInstalled = Get-Command wsl -ErrorAction SilentlyContinue

    if (-not $wslInstalled) {
        Write-Info "Installing WSL..."
        wsl --install --no-distribution

        Write-Warning "WSL installed. A REBOOT is required."
        Write-Warning "After reboot, run this script again with -SkipWSLInstall"

        $reboot = Read-Host "Reboot now? (y/N)"
        if ($reboot -eq 'y') {
            Restart-Computer -Force
        }
        exit 0
    }

    # Update WSL to latest version
    Write-Info "Updating WSL to latest version..."
    wsl --update

    # Set WSL2 as default
    Write-Info "Setting WSL2 as default version..."
    wsl --set-default-version 2

    Write-Success "WSL is ready"
}

# -----------------------------------------------------------------------------
# Step 3: Check if NixOS already exists
# -----------------------------------------------------------------------------
Write-Step "Checking existing distributions"

$existingDistros = wsl --list --quiet 2>$null
if ($existingDistros -contains $DistroName) {
    if ($Force) {
        Write-Warning "Removing existing $DistroName distribution..."
        wsl --unregister $DistroName
    } else {
        Write-Warning "$DistroName already exists."
        $remove = Read-Host "Remove and reinstall? (y/N)"
        if ($remove -eq 'y') {
            wsl --unregister $DistroName
        } else {
            Write-Info "Skipping installation. Use existing distribution."
            Write-Info "To enter: wsl -d $DistroName"
            exit 0
        }
    }
}

# -----------------------------------------------------------------------------
# Step 4: Download NixOS-WSL
# -----------------------------------------------------------------------------
Write-Step "Downloading NixOS-WSL"

$nixosWslRelease = "https://github.com/nix-community/NixOS-WSL/releases/latest/download/nixos-wsl.tar.gz"
$downloadPath = "$env:TEMP\nixos-wsl.tar.gz"

# Check for existing download
if (Test-Path $downloadPath) {
    Write-Info "Found existing download at $downloadPath"
    $redownload = Read-Host "Re-download? (y/N)"
    if ($redownload -eq 'y') {
        Remove-Item $downloadPath -Force
    }
}

if (-not (Test-Path $downloadPath)) {
    Write-Info "Downloading from $nixosWslRelease..."

    # Use BITS for better download experience
    try {
        Start-BitsTransfer -Source $nixosWslRelease -Destination $downloadPath -DisplayName "NixOS-WSL"
    } catch {
        # Fallback to Invoke-WebRequest
        Write-Info "BITS transfer failed, using WebRequest..."
        Invoke-WebRequest -Uri $nixosWslRelease -OutFile $downloadPath -UseBasicParsing
    }

    Write-Success "Download complete"
}

# Verify download
$fileSize = (Get-Item $downloadPath).Length / 1MB
Write-Info "Downloaded file size: $([math]::Round($fileSize, 2)) MB"

if ($fileSize -lt 50) {
    throw "Download appears incomplete (< 50 MB). Please try again."
}

# -----------------------------------------------------------------------------
# Step 5: Import NixOS distribution
# -----------------------------------------------------------------------------
Write-Step "Importing NixOS distribution"

# Create install directory
if (-not (Test-Path $InstallPath)) {
    Write-Info "Creating install directory: $InstallPath"
    New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
}

Write-Info "Importing NixOS to $InstallPath..."
Write-Info "This may take a few minutes..."

wsl --import $DistroName $InstallPath $downloadPath --version 2

if ($LASTEXITCODE -ne 0) {
    throw "Failed to import NixOS distribution"
}

Write-Success "NixOS imported successfully"

# Set as default distribution
Write-Info "Setting $DistroName as default WSL distribution..."
wsl --set-default $DistroName

# -----------------------------------------------------------------------------
# Step 6: Initial configuration
# -----------------------------------------------------------------------------
Write-Step "Running initial NixOS configuration"

# Create initial setup script to run inside NixOS
$setupScript = @"
#!/usr/bin/env bash
set -e

echo "=== NixOS-WSL Initial Setup ==="

# Update channels
echo "Updating Nix channels..."
sudo nix-channel --update

# Set password for nixos user
echo ""
echo "Set a password for the 'nixos' user:"
sudo passwd nixos

# Enable flakes
echo ""
echo "Enabling Nix flakes..."
sudo mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

# Clone the configuration repository
echo ""
echo "Cloning configuration repository..."
mkdir -p ~/git
cd ~/git
if [ ! -d "setup" ]; then
    git clone $FlakeRepo
else
    echo "Repository already exists, pulling latest..."
    cd setup && git pull
fi

echo ""
echo "=== Initial setup complete ==="
echo ""
echo "Next steps:"
echo "1. Review/edit the flake at ~/git/setup/mac/nix/"
echo "2. Run: sudo nixos-rebuild switch --flake ~/git/setup/mac/nix#wsl-work"
echo ""
"@

# Write setup script and execute it
$setupScriptPath = "/tmp/initial-setup.sh"
$setupScript | wsl -d $DistroName -- bash -c "cat > $setupScriptPath && chmod +x $setupScriptPath"
wsl -d $DistroName -- bash $setupScriptPath

# -----------------------------------------------------------------------------
# Step 7: Summary
# -----------------------------------------------------------------------------
Write-Step "Installation Complete"

Write-Host @"

NixOS-WSL has been installed successfully!

Distribution: $DistroName
Install Path: $InstallPath
Default User: nixos (change to $Username via configuration.nix)

To enter NixOS:
  wsl -d $DistroName

To rebuild with your flake:
  sudo nixos-rebuild switch --flake ~/git/setup/mac/nix#wsl-work

To open in Windows Terminal:
  Add a new profile with command: wsl.exe -d $DistroName

"@ -ForegroundColor Green
