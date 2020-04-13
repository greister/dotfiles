# Add Visual Studio Code context menu option to Windows Explorer

$regPath = Resolve-Path -Path $scoopInstalled + \scoop\apps\vscode\current\vscode-install-context.reg

reg.exe import $regPath


# Install Visual Studio Code extensions
# Add Visual Studio Code context menu option to Windows Explorer

$regPath = Resolve-Path -Path $scoopInstalled + \scoop\apps\vscode\current\vscode-install-context.reg
reg.exe import $regPath
code --force --install-extension DotJoshJohnson.xml `
             --install-extension ms-vscode-remote.remote-wsl `
             --install-extension ms-vscode.powershell `
             --install-extension vscodevim.vim `
             --install-extension scalameta.metals


