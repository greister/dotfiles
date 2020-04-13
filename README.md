# dotfiles
# In admin powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine

# In regular powershell
```ps
"199.232.4.133 raw.githubusercontent.com" >>  C:\Windows\System32\drivers\etc\hosts
[environment]::setEnvironmentVariable('SCOOP','D:\Scoop','User')
$env:SCOOP='D:\Application
[environment]::setEnvironmentVariable('SCOOP_GLOBAL','D:\Applications','Machine')'
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://get.scoop.sh')
scoop install git

New-Item ~\_src -ItemType Directory
Set-Location ~\_src
git clone https://github.com/greister/windows-dotfiles.git
Set-Location windows-dotfiles

.\windows\bootStrap.ps1

```ps