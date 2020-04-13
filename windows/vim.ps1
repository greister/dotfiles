	$autoloadDir = "~\vimfiles\autoload"
	$plugPath = Join-Path -Path $autoloadDir -ChildPath "plug.vim"
	if (!(Test-Path -Path $plugPath)) {
    if (!(Test-Path -Path $autoloadDir)) {
        New-Item -ItemType Directory -Path $autoloadDir -Force | Out-Null
    }
    # Showing progress decreases download speed and adds visual clutter
    $prevProgPref = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -OutFile $plugPath
    $ProgressPreference = $prevProgPref
    Start-Sleep -Seconds 1
    vim -c "PlugInstall | quit | quit"
	}

else {
    vim -c "PlugUpgrade | PlugUpdate | quit | quit"
    }

