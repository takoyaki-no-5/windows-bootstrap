[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()

Write-Host "Git 初期設定"

$name = Read-Host "name"
$email = Read-Host "email"

git config --global user.name "$name"
git config --global user.email "$email"

Write-Host "✔ user.name / user.email 設定完了"

git config --global core.hooksPath ".githooks"

Write-Host "✔ hooks path を .githooks に設定しました"