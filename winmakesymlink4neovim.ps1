if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    Write-Output "Needs to run in elevated"
    exit
   }

$userprofile = $env:USERPROFILE
$link = $userprofile+"/AppData/Local/nvim/"
$target = $PSScriptRoot+"\nvim"

Write-Output "Make a symlink from: $link to $target"

Write-Output "New-Item -ItemType SymbolicLink -Path $link -Target $target"

New-Item -ItemType SymbolicLink -Path $link -Target $target