# スクリプト実行時の引数
# 例:
# .\install.ps1 desired.yaml
param(
    [string]$YamlFile = "desired.yaml"
)

# powershell-yaml モジュールが未インストールなら導入
if (-not (Get-Module -ListAvailable -Name powershell-yaml)) {
    Install-Module powershell-yaml -Scope CurrentUser -Force
}

# YAMLを読み込むためのモジュールを有効化
Import-Module powershell-yaml

# YAMLファイルを読み込む
#
# desired.yaml
# packages:
#   - id: Microsoft.VisualStudioCode
#   - id: Brave.Brave
#
# ↓
#
# $config.packages に変換される
$config = Get-Content $YamlFile -Raw | ConvertFrom-Yaml

# packages配列を1件ずつ処理
foreach ($pkg in $config.packages) {

    # パッケージIDを取得
    $id = $pkg.id

    # ログ出力
    Write-Host "Installing: $id"

    # wingetでインストール
    winget install `
        --id $id `
        -e `
        --accept-package-agreements `
        --accept-source-agreements
}

# AutoHotkey Startup登録
& "$PSScriptRoot\autohotkey-startup.ps1"
