# dotfiles

個人用dotfilesリポジトリ。chezmoi で管理し、Linux (Manjaro/Arch) と Windows の両方に対応しています。

## 概要

このリポジトリには、i3-gaps ウィンドウマネージャーを中心とした開発環境の設定ファイルが含まれています。モダンな CLI ツール、カスタムスクリプト、複数の Polybar テーマなど、日常的な開発作業に最適化された環境を提供します。

## 特徴

- **chezmoi管理**: クロスプラットフォーム対応（Linux/Windows）の dotfiles 管理
- **i3-gaps**: カスタマイズされたタイル型ウィンドウマネージャー
- **Polybar**: 12種類のテーマから選択可能（shades, hack, material, cuts など）
- **モダンCLIツール**: bat, eza, fd, ripgrep, zoxide など
- **開発環境**: mise による複数言語のランタイム管理（Go, Rust, Node, Bun）
- **カスタムスクリプト**: スクリーンショット、電源メニュー、クリップボード管理など
- **透過ターミナル**: WezTerm with Starship prompt

## 主要コンポーネント

### ウィンドウマネージャー / デスクトップ環境

- **i3-gaps**: タイル型ウィンドウマネージャー（gaps inner 8px）
- **Polybar**: ステータスバー（12テーマ）
- **Picom**: コンポジター（透過・エフェクト）
- **Dunst**: 通知デーモン
- **Rofi**: アプリケーションランチャー
- **betterlockscreen**: ロック画面

### ターミナル / シェル

- **WezTerm**: ターミナルエミュレーター（透過度50%）
- **Zsh**: Zinit プラグインマネージャー
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - zoxide
- **Starship**: カスタムプロンプト

### エディタ / 開発ツール

- **Neovim**: LazyVim 設定
- **Ranger**: ファイルマネージャー（devicons対応）
- **Git**: libsecret 認証ヘルパー設定済み
- **mise**: ランタイムバージョン管理
- **LazyGit**: Git TUI

### ユーティリティ

- **CopyQ**: クリップボードマネージャー（カスタムコマンド付き）
- **btop**: システムモニター
- **Nitrogen**: 壁紙マネージャー
- **fcitx5**: 日本語入力

### モダンCLIツール

| 従来ツール | 代替ツール | 用途 |
|-----------|-----------|------|
| cat | bat | ファイル表示 |
| ls | eza | ディレクトリ一覧 |
| find | fd | ファイル検索 |
| grep | ripgrep | テキスト検索 |
| cd | zoxide | ディレクトリ移動 |

その他: procs, dust, duf, gping, httpie, tldr, sd, fq など

## 必須要件

- chezmoi
- i3-gaps (Linux のみ)
- git
- 各種パッケージ（詳細は `pacman-explicit.txt` および `pacman-aur.txt` を参照）

## インストール

### 1. chezmoi のインストール

```bash
# Arch/Manjaro
sudo pacman -S chezmoi

# その他のディストリビューション
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### 2. dotfiles の適用

```bash
# リポジトリのクローンと初期化
chezmoi init https://github.com/fuyu28/dotfiles.git

# 変更内容の確認
chezmoi diff

# dotfiles の適用
chezmoi apply -v
```

### 3. パッケージのインストール（Arch/Manjaro）

#### 自動セットアップ（推奨）

```bash
# リポジトリをクローン
git clone https://github.com/fuyu28/dotfiles.git
cd dotfiles

# セットアップスクリプトを実行
./executable_setup.sh
```

このスクリプトは以下を自動で実行します：
- chezmoi apply
- 不足パッケージの検出とインストール（公式リポジトリ + AUR）
- paru のインストール（必要な場合）

#### 手動インストール

```bash
# 公式リポジトリから
sudo pacman -S --needed $(cat pacman-explicit.txt | awk '{print $1}')

# AUR パッケージ（paru を使用）
paru -S --needed $(cat pacman-aur.txt | awk '{print $1}')
```

## ディレクトリ構造

```
.
├── dot_config/          # ~/.config/ の設定ファイル
│   ├── i3/             # i3 設定
│   ├── polybar/        # Polybar テーマ
│   ├── nvim/           # Neovim 設定
│   ├── wezterm/        # WezTerm 設定
│   └── ...
├── dot_local/bin/      # カスタムスクリプト
│   ├── screenshot.sh   # スクリーンショットツール
│   ├── power-menu.sh   # 電源メニュー
│   └── ...
├── dot_i3/             # i3 追加設定
├── docs/               # ドキュメント
│   ├── i3.md          # i3 キーバインド一覧
│   └── zsh_aliases.md # エイリアス一覧
├── exact_AppData/      # Windows 設定
└── ...
```

## カスタムスクリプト

### screenshot.sh

スクリーンショット撮影ツール（maim 使用）

- 領域選択: 範囲を選択してキャプチャ
- 全画面: 画面全体をキャプチャ
- ウィンドウ: アクティブウィンドウをキャプチャ
- 自動的にクリップボードにコピーし、通知を表示

### power-menu.sh

Rofi ベースの電源メニュー

- Lock, Suspend, Logout, Shutdown, Reboot

### rofi-clip-paste.sh

Rofi でクリップボード履歴から選択して貼り付け

### update-pacman-lists.sh

インストール済みパッケージリストを更新

- `pacman-aur.txt`: AURパッケージのリスト
- `pacman-explicit.txt`: 明示的にインストールされたパッケージのリスト

```bash
~/.local/bin/update-pacman-lists.sh
```

## カスタマイズ

### Polybar テーマの変更

```bash
~/.config/polybar/launch.sh --<theme-name>
```

利用可能なテーマ: shades, hack, material, cuts, shapes, grayblocks, blocks, colorblocks, forest, pwidgets, docky, adaptive

### i3 キーバインド

詳細なキーバインド一覧は [docs/i3.md](docs/i3.md) を参照してください。

主要なキーバインド:
- `Mod (Win) + Enter`: ターミナル起動
- `Mod + d`: Rofi ランチャー
- `Mod + Shift + q`: ウィンドウを閉じる
- `Mod + [1-8]`: ワークスペース切り替え
- `Mod + Print`: スクリーンショット

### エイリアス

Zsh エイリアスの一覧は [docs/zsh_aliases.md](docs/zsh_aliases.md) を参照してください。

## ドキュメント

- [i3 設定とキーバインド](docs/i3.md)
- [Zsh エイリアス](docs/zsh_aliases.md)

## プラットフォーム固有の設定

`.chezmoiignore.tmpl` により、以下のように設定が分離されています:

- **Linux**: i3, polybar, X11 設定、システム設定
- **Windows**: VSCode, Nushell, Clink, Neovim 設定（AppData）

## 更新

```bash
# リポジトリの更新を確認
chezmoi git pull

# 変更内容の確認
chezmoi diff

# 適用
chezmoi apply -v
```

## 備考

- カラーテーマ: メインアクセントカラーは `#d8a657`（ゴールド）
- フォント: Iosevka Nerd Font, Noto Sans CJK JP
- WezTerm の透過度: 50%
- i3 gaps: inner 8px, outer 0px

## ライセンス

MIT
