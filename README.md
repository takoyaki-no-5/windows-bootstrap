管理者権限でPowerShellを開く

```shell
set -euo pipefail
Set-ExecutionPolicy -Scope Process Bypass
winget install --id Git.Git -e
git clone https://github.com/takoyaki-no-5/windows-bootstrap.git
cd windows-bootstrap
.\scripts\install.ps1
.\scripts\vscode-link.ps1
```

