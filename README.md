# dotfiles-eos

`chezmoi` で管理している個人用 dotfiles です。  
EndeavourOS + i3 を前提に、普段使いのデスクトップ環境と開発環境をまとめています。

## これは何か

このリポジトリには、主に次の設定が入っています。

- デスクトップ環境: i3, Polybar, Rofi, Picom, Dunst, i3blocks
- ターミナル周り: Kitty, Zsh, tmux, Starship
- 開発環境: Neovim, mise
- 補助スクリプト: スクリーンショット、電源メニュー、壁紙切り替え

「OS を入れ直したあとに、いつもの作業環境を早く戻す」ことを目的にしています。

## 特徴

- `chezmoi` で dotfiles を一元管理
- EndeavourOS の i3 設定をベースに、自分用に整理・拡張
- Polybar は複数テーマを同梱
- `CHEZMOI_ROLE` 相当の `role` データで desktop / laptop を切り替え
- 壁紙パスや表示方法を `chezmoi` の data で管理
- Zsh は `zinit` + `zoxide` + `starship` + `mise` を利用
- Neovim は LazyVim ベース

## セットアップ

### 1. リポジトリを適用する

```sh
chezmoi init --apply fuyu28/dotfiles-eos
```

### 2. 必要なら role を切り替える

このリポジトリは `role` に応じて一部設定を切り替えます。  
初期値は `.chezmoi.toml.tmpl` で `laptop` になっています。

```toml
[data]
role = "laptop"
```

たとえばデスクトップ機で使う場合は、`~/.config/chezmoi/chezmoi.toml` などで `role = "desktop"` に変更してから再適用します。

```sh
chezmoi apply
```

現在のテンプレートでは、`laptop` のときだけ i3blocks にバッテリー表示が入ります。

### 3. 壁紙設定を必要に応じて変更する

`set-wallpaper` は `chezmoi` の data を参照します。

```toml
[data.wallpaper]
mode = "fill"
path = "/home/user/Pictures/current_wallpaper.png"
```

変更後は再度 `chezmoi apply` を実行してください。

## 主な内容

### i3

- `Mod` は `Super`
- ターミナルは `kitty`
- `rofi` ランチャー、音量調整、輝度調整、スクリーンショットなどを設定
- `~/.local/bin/rofi-powermenu.sh` を使った電源メニューを用意

### Polybar

同梱テーマ:

- `blocks`
- `colorblocks`
- `cuts`
- `docky`
- `forest`
- `grayblocks`
- `hack`
- `material`
- `panels`
- `pwidgets`
- `shades`
- `shapes`

### Zsh

- プラグイン管理: `zinit`
- プロンプト: `starship`
- ディレクトリ移動: `zoxide`
- ツールチェイン管理: `mise`
- `fzf` を前提にした自作関数をいくつか定義

### tmux

- プレフィックスは `Ctrl-Space`
- `vi` 風キーバインド
- マウス操作を有効化

### Neovim

- LazyVim ベース
- 詳細は [dot_config/nvim/README.md](/home/fuyu/.local/share/chezmoi/dot_config/nvim/README.md)

## ディレクトリ構成

```text
.
├── .chezmoi.toml.tmpl      # chezmoi data の初期値
├── dot_config/             # ~/.config 配下
├── dot_local/bin/          # ~/.local/bin 配下のスクリプト
├── dot_gitconfig           # ~/.gitconfig
├── dot_tmux.conf           # ~/.tmux.conf
├── dot_xprofile            # ~/.xprofile
└── dot_zshrc               # ~/.zshrc
```

## 補助スクリプト

- `dot_local/bin/executable_screenshot.sh`: `maim` + `xclip` で画面キャプチャ
- `dot_local/bin/executable_rofi-powermenu.sh`: `rofi` ベースの電源メニュー
- `dot_local/bin/executable_rofi-launcher.sh`: `rofi` ランチャー
- `dot_local/bin/executable_set-wallpaper.tmpl`: `feh` を使った壁紙反映

## 前提にしているツール

よく使うもの:

- `chezmoi`
- `i3`
- `polybar`
- `rofi`
- `picom`
- `dunst`
- `kitty`
- `tmux`
- `nvim`
- `starship`
- `zinit`
- `zoxide`
- `mise`

フォント:

- Noto Sans
- Iosevka Nerd Font
- HackGen Console NF

## 補足

- `dot_xprofile` では `fcitx5`、`xdg-desktop-portal`、`GTK_USE_PORTAL` などを設定しています
- 一部スクリプトやキーバインドは Arch / EndeavourOS 系のパッケージ構成を前提にしています
- そのまま他環境でも使えますが、i3 周りは依存コマンドの調整が必要です
