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

### macOS

- Homebrewのformula・cask・tap
- AeroSpace + borders
- Ghostty
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

EndeavourOS の明示インストール済み pacman パッケージと AUR パッケージは適用時に導入します。AUR は EndeavourOS リポジトリから導入される `paru` を使うため、i3 周辺を含め Arch / EndeavourOS を前提にしています。

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
├── .chezmoiscripts/{darwin,linux}/
├── .chezmoitemplates/
│   ├── ignore/{darwin,linux}
│   └── zsh/{darwin,linux}
├── dot_Brewfile
├── dot_config/
│   ├── aerospace/
│   ├── ghostty/
│   ├── i3/
│   ├── mise/
│   ├── nvim/
│   └── polybar/
├── Library/Application Support/
├── dot_gitconfig
├── dot_latexmkrc
├── dot_tmux.conf
├── dot_xprofile
├── dot_zprofile
└── dot_zshrc.tmpl
```

## OS ごとの設定を追加する

共通設定は `dot_config/` などの配置先に対応するファイルで管理します。差分が数行なら Ghostty のようにテンプレート内で分岐し、まとまった差分は `.chezmoitemplates/` に切り出します。Zsh は `dot_zshrc.tmpl` が共通設定を持ち、`zsh/darwin` または `zsh/linux` を適用時に埋め込みます。

OS 専用のファイルを追加したら、`.chezmoitemplates/ignore/darwin` または `ignore/linux` に**配置先のパス**を追加します（例: `dot_aerospace.toml` → `.aerospace.toml`）。ディレクトリは `dir/**` ではなく `dir` で書きます。`dir/**` だと中身だけが除外され、空のディレクトリが作られます。OS 専用の run スクリプトは `.chezmoiscripts/darwin/` または `.chezmoiscripts/linux/` に置けば、もう一方の OS では丸ごと除外されます。`.chezmoiignore.tmpl` が現在の OS に不要な一覧を読み込みます。共通ファイルには登録不要です。

パッケージ導入スクリプトは OS ごとに分けています。Linux のパッケージ一覧には EndeavourOS 固有のパッケージも含むため、自動導入は EndeavourOS のみに限定しています。`role` と壁紙のパスは引き続き各端末の `~/.config/chezmoi/chezmoi.toml` で指定します。

## 秘密情報の方針

このリポジトリは公開を前提としています。秘密情報は直接追加せず、`gh auth login`、SSH鍵、macOS Keychainなど各サービスの安全な認証フローで復元します。

## GTKの外観設定

GTK 2・3・4とxsettingsdの共通値は `.chezmoidata.toml` の `[gtk]` で管理します。現在のローカル環境に合わせ、GTK 2 のカーソルは `[gtk2]`、GTK 3 のカーソルは `[gtk3]`、xsettingsd のアイコン・カーソルは `[xsettings]` に分けています。GTK 4 はテーマ名のみ管理します。DPIは端末固有のため管理しません。

i3起動時はGTK 3設定からGSettingsへフォント・テーマ・カーソル（サイズを含む）を同期します。テーマ・アイコン・フォント自体は各端末にインストールする必要があります。`nwg-look` で変更した場合は、対応するデータにも反映してください。
