# Neovim

このディレクトリは、この dotfiles で使っている Neovim 設定です。  
ベースは LazyVim で、必要な差分だけこのリポジトリで管理しています。

## 方針

- プラグイン管理は `lazy.nvim`
- ディストリビューションは `LazyVim`
- 独自設定は最小限にして、基本は上流の標準設定を使う

## 現在の独自差分

- 追加プラグイン: `fuyu28/textobj-entire.nvim`
- `lua/config/options.lua`
- `lua/config/keymaps.lua`
- `lua/config/autocmds.lua`

現状では `options.lua` と `keymaps.lua` はほぼ素のままで、今後の追加用の置き場になっています。

## 主要ファイル

- `init.lua`: エントリーポイント
- `lua/config/lazy.lua`: `lazy.nvim` と LazyVim の初期化
- `lua/plugins/`: 追加・上書きするプラグイン設定
- `lazy-lock.json`: プラグインの lockfile
- `stylua.toml`: Lua の整形設定

## セットアップ

`chezmoi apply` 後に `nvim` を起動すると、必要なプラグインが自動で取得されます。  
初回起動時は `git` と Neovim 本体が必要です。

LazyVim の前提条件や詳細は公式ドキュメントを参照してください。  
https://lazyvim.github.io/installation
