# dotfiles

macOS と EndeavourOS の環境を [chezmoi](https://www.chezmoi.io/) で管理する個人用 dotfiles。Windows では一部の設定だけを使う（[Windows](#windows) を参照）。

- 共通: Zsh (zinit)、Git / GitHub CLI、tmux、Neovim (LazyVim)、Starship、mise
- macOS: Homebrew、AeroSpace + borders、Ghostty、Cursor / VS Code、macOS の主要設定
- Linux: i3 / sway、i3blocks、Rofi、Picom、Dunst、Kitty、fcitx5
- Windows: Git / GitHub CLI、lazygit、Neovim、Starship、mise、PowerShell、エージェントのスキル

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
| `desktops` | 使うデスクトップ（複数選択）。`i3`、`sway`、`kde` から選ぶ。選ばなかったものはパッケージも設定ファイルも入れない |
| `packageGroups` | 追加で入れるパッケージのグループ（複数選択）。`apps`、`dev`、`android`、`cli`、`tex` から選ぶ |

パッケージの中身は `.chezmoidata/packages.toml` にある。

テンプレートに項目が増えたら `chezmoi init` を実行し直す。既存の値は聞かれない。

認証情報は管理しないので、`gh auth login`、SSH 鍵、各アプリへのログイン、フォント（HackGen Console NF）は手動で戻す。

## 公開しないもの

このリポジトリは公開前提なので、秘密情報は置かない。再配布できない素材など公開できないものは `fuyu28/dotfiles-private` に置き、`private = true` の端末でだけ external として clone して使う。壁紙（`~/Pictures/Wallpaper`）とエージェントのスキル（`~/.agents`）は、その clone への symlink になる。

## 更新

```sh
chezmoi update
```

パッケージや mise のツールは、`dot_Brewfile`、`.chezmoidata/packages.toml`、`dot_config/mise/config.toml` を変更すると次回の適用時に入る。

## OS ごとの設定

- OS 専用のファイルは、配置先のパスを `.chezmoitemplates/ignore/darwin`、`ignore/linux`、`ignore/windows` のどれかに追加する。Linux と macOS の両方で使い Windows では使わないものは `ignore/unix` に追加する。ディレクトリは `dir/**` ではなく `dir` と書く（`dir/**` だと空のディレクトリが作られる）。
- mise のツールを OS で絞るときは、chezmoi のテンプレートではなく mise の `os` オプション（例: `os = ["unix"]`）を使う。`config.toml` には mise 自身の `{{ }}` テンプレートがあり、chezmoi の記法とぶつかるため。
- OS 専用のスクリプトは `.chezmoiscripts/darwin/` か `linux/` に置く。
- 数行の差分はテンプレート内で分岐し、大きな差分は `.chezmoitemplates/` に切り出す。

## Windows

Windows では Git / GitHub CLI、lazygit、Neovim、Starship、mise、PowerShell のプロファイル、エージェントのスキルだけを使う。Zsh、tmux、デスクトップ環境などは `ignore/unix` などで除外している。

### 事前準備

1. **開発者モードを有効にする**（設定 → システム → 開発者向け）。chezmoi が symlink（`~/.agents` やスキル）を作るのに必要。
2. **`XDG_CONFIG_HOME` を設定する**。Windows の Neovim、GitHub CLI、lazygit は既定で `AppData` の下を読むので、`~/.config` を読ませるためにユーザー環境変数を設定する。設定したあとに開いたターミナルから有効になる。

   ```powershell
   [Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', "$env:USERPROFILE\.config", 'User')
   ```

3. **winget でツールを入れる**。CLI アプリは Linux の pacman や macOS の Homebrew と同じく winget で管理し、言語ランタイムだけを mise に任せる。

   ```powershell
   winget install twpayne.chezmoi Git.Git GitHub.cli Neovim.Neovim Starship.Starship JesseDuffield.lazygit jdx.mise
   ```

4. **`gh auth login` を済ませる**。`private = true` のとき、`fuyu28/dotfiles-private` を gh の認証で clone する。

### 適用

```powershell
chezmoi init --apply fuyu28/dotfiles
```

init で聞かれる項目のうち、Windows で意味があるのは `private` だけ。ほかは何を選んでもよい。

### mise と Python

Windows で mise が入れるのは go、node、codex、uv、usage。Windows で動かないものや別の方法で入れるものには `os = ["unix"]` を付けている。

- Claude Code は公式インストーラで入れる。
- Rust は winget の `Rustlang.Rustup` で入れる。
- Python は uv で入れる: `uv python install --default`（`~/.local/bin` に `python.exe` が置かれる）。

### Git

credential helper は、github.com と gist.github.com では gh、それ以外では Git Credential Manager（Git for Windows に同梱）を使う。

`ghq.root` などのマシン固有の設定は `~/.gitconfig.local` に書く。これは chezmoi で管理せず、`.gitconfig` から include する。ほかの OS でも同じように使える。

## Linux の外観

値は `.chezmoidata.toml` にまとめている。

- `[gtk]`: GTK 3・4 と `~/.Xresources` のテーマ・フォント・ダークモード。i3 / sway の起動時に GSettings へ同期する。
- `[cursor]`: カーソルテーマと論理サイズ。画面の倍率をかけて使う。
- `[[monitors]]`: モニタごとの倍率とモード。載っていないモニタは倍率 1。`make` / `model` / `serial` は `swaymsg -t get_outputs` の表記に合わせる。sway は output 設定を生成し、i3 は `display-scale` が EDID で照合して DPI とカーソルサイズを決める。

テーマ・アイコン・フォント自体は各端末にインストールしておく。

壁紙は `wallpaper`（`$mod+Shift+w`）で `~/Pictures/Wallpaper` から rofi で選ぶ。`wallpaper <名前>` や `wallpaper --random` でも変えられる。
