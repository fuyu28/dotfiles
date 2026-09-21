# dotfiles

macOSとEndeavourOSの環境を[`chezmoi`](https://www.chezmoi.io/)で管理する個人用dotfilesです。
シェル・Git・tmux・Neovimなどは共通化し、デスクトップ環境とパッケージ導入はOSごとに分離しています。

## 管理対象

### 共通

- Zsh + zinit
- Git / GitHub CLI
- tmux
- Neovim (LazyVim)
- Starship
- mise
- Ghostty

### macOS

- Homebrewのformula・cask・tap
- AeroSpace + borders
- Cursor / VS Codeの汎用設定と拡張
- Dock、Finder、キー入力の主要設定

### Linux

- EndeavourOS + i3
- Polybar、Rofi、Picom、Dunst、i3blocks
- KittyとX11用スクリプト

`.chezmoiignore.tmpl`がOSを判定するため、macOSへi3設定を配置したり、LinuxへAeroSpaceやBrewfileを配置したりすることはありません。

## 新しいmacOSをセットアップする

### 1. chezmoiで適用する

Homebrewがなくても、chezmoiの公式インストーラーから初期化できます。

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply fuyu28/dotfiles
```

適用時に次の処理が実行されます。

1. Homebrewをインストール
2. `Brewfile`のformula・caskをインストール
3. dotfilesを配置
4. `mise install`で言語・ツールチェインを導入
5. Cursor / VS CodeのCLIがあれば拡張を導入
6. 主要なmacOS設定を反映

すでにchezmoiがある場合:

```sh
chezmoi init --apply fuyu28/dotfiles
```

### 2. 手動で戻すもの

認証情報はリポジトリに保存していません。必要なものだけ再認証してください。

```sh
gh auth login
```

- SSH鍵を新規作成または安全なバックアップから復元
- GitHub、Cursor、各アプリへログイン
- Visual Studio Code、Google Chrome、SlackなどHomebrew管理外だったアプリを必要に応じて導入
- フォント（HackGen Console NF）を導入
- FileVaultとファイアウォールを用途に合わせて有効化

`~/.config/gh/hosts.yml`、SSH秘密鍵、Keychain、シェル履歴、エディタ履歴は意図的に管理していません。

## Linuxで使う

```sh
chezmoi init --apply fuyu28/dotfiles
```

初期値はlaptopです。desktopへ切り替える場合は、`~/.config/chezmoi/chezmoi.toml`を変更します。

```toml
[data]
role = "desktop"
```

Linuxのシステムパッケージはディストリビューション側で導入してください。i3周辺はArch / EndeavourOSを前提にしています。

## 更新

```sh
chezmoi update
```

Homebrewパッケージを変更した場合は`~/.Brewfile`ではなく、chezmoi source stateの`dot_Brewfile`を編集します。内容が変わると次回適用時に`brew bundle`が再実行されます。

miseのバージョン指定は`~/.config/mise/config.toml`で管理され、変更時に`mise install`が再実行されます。

## 主な構成

```text
.
├── .chezmoi.toml.tmpl
├── .chezmoiignore.tmpl
├── dot_Brewfile
├── dot_config/
│   ├── aerospace/
│   ├── ghostty/
│   ├── i3/
│   ├── mise/
│   ├── nvim/
│   └── polybar/
├── Library/Application Support/
├── run_onchange_*.sh.tmpl
├── dot_gitconfig
├── dot_tmux.conf
├── dot_xprofile
├── dot_zprofile
└── dot_zshrc
```

## 秘密情報の方針

このリポジトリは公開を前提としています。秘密情報は直接追加せず、`gh auth login`、SSH鍵、macOS Keychainなど各サービスの安全な認証フローで復元します。
