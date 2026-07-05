$startup = [Environment]::GetFolderPath("Startup")

$target = Join-Path (Get-Location) "autohotkey\basic_keyboard\Main.exe"
$link = Join-Path $startup "Main.lnk"

$wshell = New-Object -ComObject WScript.Shell
$shortcut = $wshell.CreateShortcut($link)
$shortcut.TargetPath = $target
$shortcut.WorkingDirectory = Split-Path $target
$shortcut.Save()
