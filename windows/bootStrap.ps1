#Requires -Version 6.0

$scoopInstalled = 'D:\Applications'
#
#Add-Content C:\Windows\System32\drivers\etc\hosts "`n199.232.4.133 raw.githubusercontent.com"

if ($IsLinux) {
    throw "This script supports Windows only. To install dotfiles on Linux, run `"curl https://setup.davidhaymond.dev | bash`"."
}
elseif ($IsMacOS) {
    throw "This script supports Windows only. This dotfiles repo is not yet supported on macOS."
}


# Temporarily allow scripts to run so scoop can install
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# Clear .gitconfig to avoid Git errors

if (Test-Path -Path ~\.gitconfig) {

    if ((Get-Item -Path ~\.gitconfig).LinkType -eq 'SymbolicLink') {

        Remove-Item -Path ~\.gitconfig -Force
    }
    else {
        Rename-Item -Path ~\.gitconfig -NewName .gitconfig.bak -Force
    }
}

#Requires -RunAsAdministrator

# Install the latest version of PowerShell
Invoke-Expression "& { $(Invoke-RestMethod -Uri https://aka.ms/install-powershell.ps1) } -UseMSI -AddExplorerContextMenu -Quiet"

#Install Scoop and chocolatey
Write-Output "Installing Scoop..."
if (!(CommandExists("scoop"))) {    
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
else {    
    Write-Warn "Scoop Already installed"
}

if (!(CommandExists("choco")))
{
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {    
    Write-Warn "Chocolatey Already installed"
}

# Add buckets
{
$usedBUckets = @( "extras", "java", "main", "nirsoft", "jetbrains", "versions", "nerd-fonts")

foreach ($t1 in $usedBUckets) {
	scoop bucket add  $t1
	}
}
# $chocoTools = @("googlechrome", “microsoft-windows-terminal”,
#                 "DroidSansMono-NF"
#                 )
# foreach ($t2 in $chocoTools) {
# 	choco install -y $t2
# 	}

$scoopTools = @("7zip", "vim","doskey", "vscode", "firefox", "v2ray","wget","gow", "git", "sublime-merge", "FiraCode", "neovim")
scoop install aria2
scoop install git
foreach ($t3 in $scoopTools) {
    scoop install $t3
    }





#https://github.com/davidhaymond/dotfiles
# Clone dotfiles repo

$isDotfilesInstalled = Test-Path -Path ~\.dotfiles -PathType Container

if (!$isDotfilesInstalled) {
    Push-Location -Path ~

    git clone https://github.com/greister/dotfiles.git .dotfiles
    $dotfilesDir = Get-Item -Path .dotfiles -Force
    $dotfilesDir.Attributes = $dotfilesDir.Attributes -bor [System.IO.FileAttributes]::Hidden
    Set-Location -Path .dotfiles
    git remote set-url --push origin git@github.com:davidhaymond/dotfiles.git
}
else {
    Push-Location -Path ~\.dotfiles
    git pull
}


# Run global initialization script
$adminSetupPath = Resolve-Path -Path .\scripts\admin-setup.ps1
$adminSetupArgs = "-NoProfile -File `"$adminSetupPath`""
$adminProcess = Start-Process -FilePath pwsh.exe -ArgumentList $adminSetupArgs -Verb RunAs -Wait -PassThru

# Run dotfiles install script
.\windows\install.ps1
if ($adminProcess.ExitCode -eq 3010) {
    $finishSetupPath = Resolve-Path -Path .\scripts\finish-setup.ps1
    $regParams = @{
        Path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce'
        Name = 'Finish dotfiles installation'
        Value = "pwsh.exe -NoProfile -File `"$finishSetupPath`""
    }
    Set-ItemProperty @regParams
    Write-Information -MessageData "Restarting in 5 seconds..." -InformationAction Continue
    Start-Sleep -Seconds 5
    Restart-Computer
}
else {
    .\scripts\finish-setup.ps1
}

Pop-Location