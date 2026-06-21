$ErrorActionPreference = "Stop"

$repo = Split-Path $PSScriptRoot -Parent

$compiler = "$env:ProgramFiles\AutoHotkey\Compiler\Ahk2Exe.exe"
$baseFile = "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe"

$inputFile = Join-Path $repo "autohotkey\basic_keyboard\Main.ahk"

$outputFile = [System.IO.Path]::ChangeExtension(
    $inputFile,
    ".exe"
)

if (-not (Test-Path $compiler)) {
    throw "Ahk2Exe not found: $compiler"
}

if (-not (Test-Path $baseFile)) {
    throw "Base file not found: $baseFile"
}

if (-not (Test-Path $inputFile)) {
    throw "Input file not found: $inputFile"
}

if (Test-Path $outputFile) {
    Remove-Item $outputFile -Force
}

Write-Host "Compiler : $compiler"
Write-Host "BaseFile : $baseFile"
Write-Host "Input    : $inputFile"
Write-Host "Output   : $outputFile"

$args = @(
    "/in `"$inputFile`"",
    "/out `"$outputFile`"",
    "/base `"$baseFile`"",
    "/silent verbose"
)

Start-Process `
    -FilePath $compiler `
    -ArgumentList $args `
    -Wait `
    -NoNewWindow

if (-not (Test-Path $outputFile)) {
    throw "AHK build failed. Output exe was not created."
}

Write-Host "AHK build succeeded."
