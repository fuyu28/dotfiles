# dotfiles

個人用 dotfiles リポジトリ。chezmoi で管理し、EndeavourOS + i3 のデスクトップ環境に最適化しています。

## 概要

i3 を中心に、Polybar/rofi/picom/dunst などのデスクトップ周りと、zsh/kitty/tmux/Neovim の開発環境をまとめた設定群です。日常の作業で使う CLI ツールや小さな補助スクリプトも含みます。

## 特徴

- **chezmoi 管理**: dotfiles の適用とテンプレート管理
- **i3**: タイル型ウィンドウマネージャー設定
- **Polybar**: 複数テーマ/スタイル（blocks, colorblocks, cuts, docky, forest, grayblocks, hack, material, panels, pwidgets, shades, shapes）
- **Zsh**: zinit + starship + zoxide + mise
- **Kitty + tmux**: 透過設定と `C-Space` プレフィックス
- **Neovim**: LazyVim ベース
- **カスタムスクリプト**: スクリーンショット、rofi パワーメニュー、壁紙切替

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

## インストール (chezmoi)

```sh
chezmoi init --apply fuyu28/dotfiles
```

### Roles

`CHEZMOI_ROLE` でテンプレートの切り替えができます (i3blocks のバッテリー表示など)。

```sh
CHEZMOI_ROLE=desktop chezmoi apply
CHEZMOI_ROLE=laptop  chezmoi apply
```

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

## Fonts / Tools

- Fonts: Noto Sans, Iosevka Nerd Font, HackGen Console NF
- Tools: i3, rofi, polybar, picom, dunst, kitty, tmux, starship, zinit, zoxide, mise
