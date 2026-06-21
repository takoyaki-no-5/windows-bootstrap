$ErrorActionPreference = "Stop"

$repoRoot = Split-Path $PSScriptRoot -Parent
$shortcutDir = Join-Path $repoRoot "autohotkey\applications_shortcut"

$localAppData = $env:LOCALAPPDATA
$programFiles = $env:ProgramFiles
$programFilesX86 = ${env:ProgramFiles(x86)}

New-Item -ItemType Directory -Force $shortcutDir | Out-Null

$braveCandidates = @(
    Join-Path $localAppData "BraveSoftware\Brave-Browser\Application\brave.exe"
    Join-Path $programFiles "BraveSoftware\Brave-Browser\Application\brave.exe"
    Join-Path $programFilesX86 "BraveSoftware\Brave-Browser\Application\brave.exe"
    "brave.exe"
)

$apps = @(
    @{
        Name = "Brave"
        Candidates = $braveCandidates
        Arguments = ""
    }

    @{
        Name = "ChatGPT"
        Candidates = $braveCandidates
        Arguments = "--app=https://chatgpt.com"
    }

    @{
        Name = "Visual Studio Code"
        Candidates = @(
            Join-Path $localAppData "Programs\Microsoft VS Code\Code.exe"
            Join-Path $programFiles "Microsoft VS Code\Code.exe"
            Join-Path $programFilesX86 "Microsoft VS Code\Code.exe"
            "Code.exe"
        )
        Arguments = ""
    }

    @{
        Name = "Obsidian"
        Candidates = @(
            Join-Path $localAppData "Obsidian\Obsidian.exe"
            Join-Path $programFiles "Obsidian\Obsidian.exe"
            Join-Path $programFilesX86 "Obsidian\Obsidian.exe"
            "Obsidian.exe"
        )
        Arguments = ""
    }

    @{
        Name = "Terminal"
        Candidates = @(
            Join-Path $localAppData "Microsoft\WindowsApps\wt.exe"
            Join-Path $programFiles "WindowsApps\wt.exe"
            Join-Path $programFilesX86 "WindowsApps\wt.exe"
            "wt.exe"
        )
        Arguments = ""
    }
)

$wsh = New-Object -ComObject WScript.Shell

foreach ($app in $apps) {
    $target = $null

    foreach ($candidate in $app.Candidates) {
        if (-not $candidate) {
            continue
        }

        if (Test-Path $candidate) {
            $target = $candidate
            break
        }

        $cmd = Get-Command $candidate -ErrorAction SilentlyContinue

        if ($cmd) {
            $target = $cmd.Source
            break
        }
    }

    if (-not $target) {
        Write-Warning "$($app.Name) が見つかりません"
        continue
    }

    $lnk = $wsh.CreateShortcut(
        (Join-Path $shortcutDir "$($app.Name).lnk")
    )

    $lnk.TargetPath = $target
    $lnk.Arguments = $app.Arguments
    $lnk.Save()

    Write-Host "Created: $($app.Name) -> $target"
}