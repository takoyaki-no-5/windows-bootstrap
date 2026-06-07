@'
$ErrorActionPreference = "Stop"

$repo = Split-Path $PSScriptRoot -Parent
$extensionsPath = Join-Path $repo "vscode\extensions.txt"

New-Item -ItemType Directory -Force (Split-Path $extensionsPath) | Out-Null

code --list-extensions | Sort-Object | Set-Content -Encoding UTF8 $extensionsPath
'@ | Set-Content -Encoding UTF8 .\scripts\export-vscode.ps1
