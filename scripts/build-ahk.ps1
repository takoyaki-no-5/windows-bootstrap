$ErrorActionPreference = "Stop"

$repo = Split-Path $PSScriptRoot -Parent

$compiler = Join-Path ${env:ProgramFiles} "AutoHotkey\Compiler\Ahk2Exe.exe"

$inputFile = Join-Path $repo "autohotkey\basic_keyboard\Main.ahk"
$outputDir = Join-Path $repo "dist"
$outputFile = Join-Path $outputDir "basic_keyboard.exe"

New-Item -ItemType Directory -Force $outputDir | Out-Null

& $compiler `
    /in $inputFile `
    /out $outputFile

if ($LASTEXITCODE -ne 0) {
    throw "AHK build failed"
}
