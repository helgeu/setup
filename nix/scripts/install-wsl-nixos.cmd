@echo off
:: Launcher for install-wsl-nixos.ps1 - bypasses execution policy
:: Run as Administrator
powershell -ExecutionPolicy Bypass -File "%~dp0install-wsl-nixos.ps1" %*
