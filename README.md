# dotfiles

macOS と EndeavourOS の環境を [chezmoi](https://www.chezmoi.io/) で管理する個人用 dotfiles。

- 共通: Zsh (zinit)、Git / GitHub CLI、tmux、Neovim (LazyVim)、Starship、mise
- macOS: Homebrew、AeroSpace + borders、Ghostty、Cursor / VS Code、macOS の主要設定
- Linux: i3 / sway、i3blocks、Rofi、Picom、Dunst、Kitty、fcitx5

## セットアップ

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply fuyu28/dotfiles
# chezmoi がすでにある場合
chezmoi init --apply fuyu28/dotfiles
```

macOS では Homebrew と `Brewfile` のパッケージ、mise のツール、エディタ拡張、macOS の設定まで入る。

Linux（EndeavourOS 前提）では pacman / paru でパッケージを入れる。初回の init で次を聞かれ、`~/.config/chezmoi/chezmoi.toml` に保存される。

| キー | 内容 |
|---|---|
| `role` | `desktop` / `laptop`。電源管理やバッテリー表示などの切り替えに使う |
| `skk` | 日本語入力に SKK を使うか（false なら mozc） |
| `private` | private リポジトリ `fuyu28/dotfiles-private` を使うか（要 `gh auth login`） |

テンプレートに項目が増えたら `chezmoi init` を実行し直す。既存の値は聞かれない。

認証情報は管理しないので、`gh auth login`、SSH 鍵、各アプリへのログイン、フォント（HackGen Console NF）は手動で戻す。

## 公開しないもの

このリポジトリは公開前提なので、秘密情報は置かない。再配布できない素材など公開できないものは `fuyu28/dotfiles-private` に置き、`private = true` の端末でだけ external として clone して使う。

## 更新

```sh
chezmoi update
```

パッケージや mise のツールは、`dot_Brewfile`、Linux のパッケージスクリプト、`dot_config/mise/config.toml` を変更すると次回の適用時に入る。

## OS ごとの設定

- OS 専用のファイルは、配置先のパスを `.chezmoitemplates/ignore/darwin` か `ignore/linux` に追加する。ディレクトリは `dir/**` ではなく `dir` と書く（`dir/**` だと空のディレクトリが作られる）。
- OS 専用のスクリプトは `.chezmoiscripts/darwin/` か `linux/` に置く。
- 数行の差分はテンプレート内で分岐し、大きな差分は `.chezmoitemplates/` に切り出す。

## Linux の外観

値は `.chezmoidata.toml` にまとめている。

- `[gtk]`: GTK 3・4 と `~/.Xresources` のテーマ・フォント・ダークモード。i3 / sway の起動時に GSettings へ同期する。
- `[cursor]`: カーソルテーマと論理サイズ。画面の倍率をかけて使う。
- `[[monitors]]`: モニタごとの倍率とモード。載っていないモニタは倍率 1。`make` / `model` / `serial` は `swaymsg -t get_outputs` の表記に合わせる。sway は output 設定を生成し、i3 は `display-scale` が EDID で照合して DPI とカーソルサイズを決める。

テーマ・アイコン・フォント自体は各端末にインストールしておく。
