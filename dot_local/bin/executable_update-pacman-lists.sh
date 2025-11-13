#!/bin/bash

# pacmanのパッケージリストを自動生成するスクリプト

# dotfilesのルートディレクトリを取得
DOTFILES_DIR="$HOME/ghq/github.com/fuyu28/dotfiles"

# エラーハンドリング
set -e

echo "パッケージリストを更新しています..."

# AURパッケージのリストを生成
echo "- AURパッケージを取得中..."
pacman -Qm > "$DOTFILES_DIR/pacman-aur.txt"
echo "  → pacman-aur.txt を更新しました ($(wc -l < "$DOTFILES_DIR/pacman-aur.txt") パッケージ)"

# 明示的にインストールされたパッケージのリストを生成
echo "- 明示的にインストールされたパッケージを取得中..."
pacman -Qe > "$DOTFILES_DIR/pacman-explicit.txt"
echo "  → pacman-explicit.txt を更新しました ($(wc -l < "$DOTFILES_DIR/pacman-explicit.txt") パッケージ)"

echo "完了しました！"
