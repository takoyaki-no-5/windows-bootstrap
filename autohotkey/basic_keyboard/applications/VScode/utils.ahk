#Requires AutoHotkey v2.0

if IsSet(_ideUtilsLoaded)
    return
_ideUtilsLoaded := true

vscode := "ahk_exe Code.exe"
cursor := "ahk_exe Cursor.exe"

ide_is_active() => WinActive(vscode) or WinActive(cursor)