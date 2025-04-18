
# vscode_install.ps1

# VSCodeの設定ファイルディレクトリ
$vsUserDir = "$env:APPDATA\Code\User"

# ファイルのシンボリックリンクを作成する関数
function Link-File($source, $destination) {
    if (Test-Path $destination) {
        Write-Host "既に存在: $destination"
    } else {
        New-Item -ItemType SymbolicLink -Path $destination -Target $source | Out-Null
        Write-Host "リンク作成: $destination → $source"
    }
}

# settings.json と keybindings.json のリンク作成
Link-File "$PSScriptRoot\settings.json" "$vsUserDir\settings.json"
Link-File "$PSScriptRoot\keybindings.json" "$vsUserDir\keybindings.json"

# vscode-nvim ディレクトリの準備
$vscodeNvimDir = "$env:LOCALAPPDATA\vscode-nvim"
if (-not (Test-Path $vscodeNvimDir)) {
    New-Item -ItemType Directory -Path $vscodeNvimDir | Out-Null
    Write-Host "ディレクトリ作成: $vscodeNvimDir"
}

# init.lua のリンク作成
Link-File "$PSScriptRoot\vscode-nvim\init.lua" "$vscodeNvimDir\init.lua"
ink-File $initSource $initTarget
