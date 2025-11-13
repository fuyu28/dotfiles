#!/bin/bash

# dotfilesセットアップスクリプト
# 初期状態からdotfilesを適用し、必要なパッケージをインストールします

set -e

# カラー出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ログ関数
info() {
    echo -e "${BLUE}==>${NC} $1"
}

success() {
    echo -e "${GREEN}==>${NC} $1"
}

warning() {
    echo -e "${YELLOW}==>${NC} $1"
}

error() {
    echo -e "${RED}==>${NC} $1"
}

# dotfilesディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

info "dotfilesのセットアップを開始します"

# chezmoiがインストールされているか確認
if ! command -v chezmoi &> /dev/null; then
    warning "chezmoiがインストールされていません。インストールしますか? (y/N)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        info "chezmoiをインストール中..."
        sudo pacman -S --needed chezmoi
        success "chezmoiをインストールしました"
    else
        error "chezmoiが必要です。終了します。"
        exit 1
    fi
fi

# chezmoi applyを実行
info "chezmoi applyを実行中..."
chezmoi apply
success "dotfilesを適用しました"

# パッケージリストの存在確認
if [[ ! -f "$SCRIPT_DIR/pacman-explicit.txt" ]]; then
    error "pacman-explicit.txt が見つかりません"
    exit 1
fi

if [[ ! -f "$SCRIPT_DIR/pacman-aur.txt" ]]; then
    warning "pacman-aur.txt が見つかりません（スキップします）"
fi

# 公式リポジトリのパッケージをインストール
info "不足している公式パッケージをチェック中..."
missing_official=()

while IFS= read -r line; do
    # 空行とコメントをスキップ
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    # パッケージ名を取得（バージョン番号を除く）
    package=$(echo "$line" | awk '{print $1}')

    # パッケージがインストールされているかチェック
    if ! pacman -Qq "$package" &> /dev/null; then
        missing_official+=("$package")
    fi
done < "$SCRIPT_DIR/pacman-explicit.txt"

if [[ ${#missing_official[@]} -gt 0 ]]; then
    info "不足している公式パッケージ: ${#missing_official[@]}個"
    echo "${missing_official[@]}" | tr ' ' '\n' | head -10
    if [[ ${#missing_official[@]} -gt 10 ]]; then
        echo "... 他 $((${#missing_official[@]} - 10))個"
    fi

    warning "これらのパッケージをインストールしますか? (y/N)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        info "公式パッケージをインストール中..."
        # AURパッケージを除外するため、公式リポジトリに存在するもののみインストール
        for pkg in "${missing_official[@]}"; do
            if pacman -Si "$pkg" &> /dev/null; then
                sudo pacman -S --needed --noconfirm "$pkg" || warning "スキップ: $pkg"
            fi
        done
        success "公式パッケージのインストールが完了しました"
    fi
else
    success "全ての公式パッケージがインストール済みです"
fi

# AURパッケージをインストール
if [[ -f "$SCRIPT_DIR/pacman-aur.txt" ]]; then
    info "不足しているAURパッケージをチェック中..."
    missing_aur=()

    while IFS= read -r line; do
        # 空行とコメントをスキップ
        [[ -z "$line" || "$line" =~ ^# ]] && continue

        # パッケージ名を取得（バージョン番号を除く）
        package=$(echo "$line" | awk '{print $1}')

        # パッケージがインストールされているかチェック
        if ! pacman -Qq "$package" &> /dev/null; then
            missing_aur+=("$package")
        fi
    done < "$SCRIPT_DIR/pacman-aur.txt"

    if [[ ${#missing_aur[@]} -gt 0 ]]; then
        info "不足しているAURパッケージ: ${#missing_aur[@]}個"
        echo "${missing_aur[@]}" | tr ' ' '\n'

        # paruがインストールされているか確認
        if ! command -v paru &> /dev/null; then
            warning "paruがインストールされていません。インストールしますか? (y/N)"
            read -r response
            if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
                info "paruをインストール中..."
                # base-develとgitが必要
                sudo pacman -S --needed base-devel git

                # paruをビルドしてインストール
                temp_dir=$(mktemp -d)
                cd "$temp_dir"
                git clone https://aur.archlinux.org/paru.git
                cd paru
                makepkg -si --noconfirm
                cd "$SCRIPT_DIR"
                rm -rf "$temp_dir"
                success "paruをインストールしました"
            else
                warning "paruが必要です。AURパッケージのインストールをスキップします。"
                exit 0
            fi
        fi

        warning "AURパッケージをインストールしますか? (y/N)"
        read -r response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            info "AURパッケージをインストール中..."
            paru -S --needed "${missing_aur[@]}"
            success "AURパッケージのインストールが完了しました"
        fi
    else
        success "全てのAURパッケージがインストール済みです"
    fi
fi

success "セットアップが完了しました！"
info "必要に応じて、ログアウト/再起動を行ってください。"
