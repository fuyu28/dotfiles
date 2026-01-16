# dotfiles

個人用 dotfiles リポジトリ。chezmoi で管理し、EndeavourOS + i3 のデスクトップ環境に最適化しています。

## 概要

i3 を中心に、Polybar/rofi/picom/dunst などのデスクトップ周りと、zsh/kitty/tmux/Neovim の開発環境をまとめた設定群です。日常の作業で使う CLI ツールや小さな補助スクリプトも含みます。

## できること

- **chezmoi 管理**: dotfiles の適用とテンプレート管理
- **i3**: タイル型ウィンドウマネージャー設定
- **Polybar**: 複数テーマ/スタイル
- **Zsh**: zinit + starship + zoxide + mise
- **Kitty + tmux**: 透過設定と `C-Space` プレフィックス
- **Neovim**: LazyVim ベース
- **カスタムスクリプト**: スクリーンショット、rofi パワーメニュー、壁紙切替

## 前提 (最低限)

- OS: EndeavourOSで動作確認
- 必須ツール: `git`, `chezmoi`
- 主要パッケージ: i3, rofi, polybar, picom, dunst, kitty, tmux, starship, zinit, zoxide, mise
- フォント: Noto Sans, Iosevka Nerd Font, HackGen Console NF

## インストール (chezmoi)

```sh
chezmoi init --apply fuyu28/dotfiles
```

## 使い始めるまでの手順

1) ロールと壁紙設定を用意

```toml
# chezmoi edit-config
[data]
role = "laptop"
# role = "desktop"

[data.wallpaper]
mode = "fill"
path = "/home/user/Pictures/current_wallpaper.png"
```

1) 壁紙のシンボリックリンクを作成

```sh
ln -sf /home/user/Pictures/current_wallpaper.png [好きな画像のパス]
```

1) 設定を適用

```sh
chezmoi apply
```

## よく使うコマンド

- 変更の取り込み: `chezmoi update`
- 反映前の確認: `chezmoi diff`
- 再適用: `chezmoi apply`

## 主要コンポーネント

### ウィンドウマネージャー / デスクトップ

- i3
- Polybar
- Picom
- Dunst
- Rofi
- i3blocks

### ターミナル / シェル

- Kitty
- Zsh (zinit)
- Starship
- tmux

### エディタ / 開発ツール

- Neovim (LazyVim)
- mise

## ディレクトリ構造

```
.
├── dot_config/          # ~/.config (i3, polybar, rofi, kitty, nvim, etc)
├── dot_local/           # ~/.local (scripts)
├── dot_zshrc            # ~/.zshrc
├── dot_tmux.conf        # ~/.tmux.conf
├── dot_xprofile         # ~/.xprofile
└── dot_gitconfig        # ~/.gitconfig
```

## カスタムスクリプト

- `dot_local/bin/executable_screenshot.sh`: maim + xclip で撮影・クリップボードコピー
- `dot_local/bin/executable_rofi-powermenu.sh`: rofi ベースの電源メニュー
- `dot_local/bin/executable_set-wallpaper.tmpl`: feh を使った壁紙切替 (chezmoi テンプレート)

## Notes

- `dot_local/bin/executable_set-wallpaper.tmpl` は `wallpaper.mode` と `wallpaper.path` の data を参照します。
- `dot_xprofile` で fcitx5 / portal 関連の環境変数を設定しています。
