$ErrorActionPreference = "Stop"

$repo = Split-Path $PSScriptRoot -Parent

$vscodeUser = Join-Path $env:APPDATA "Code\User"

New-Item -ItemType Directory -Force $vscodeUser | Out-Null

$links = @{
    "$vscodeUser\settings.json"    = "$repo\vscode\settings.json"
    "$vscodeUser\keybindings.json" = "$repo\vscode\keybindings.json"
}

foreach ($link in $links.GetEnumerator()) {

    if (Test-Path $link.Key) {
        Remove-Item $link.Key -Force
    }

    New-Item `
        -ItemType SymbolicLink `
        -Path $link.Key `
        -Target $link.Value `
        -Force | Out-Null
}

Get-Content "$repo\vscode\extensions.txt" | ForEach-Object {
    code --install-extension $_ --force
}

Write-Host "VSCode linked successfully."
