# Neovim

`lazy.nvim` でプラグインを管理するローカル設定です。
LazyVim 由来の設定と独自設定は統合済みで、LazyVim 本体への依存はありません。

## 構成

```text
init.lua
lua/
  config/        # 起動処理、オプション、キーマップ、autocmd
  plugins/       # 用途別のプラグイン設定
    init.lua     # 読み込むモジュールと順序
    lang/        # Go、Python、TypeScript などの言語設定
  util/          # LSP、整形、プロジェクトルートなどの共通処理
queries/         # Tree-sitter クエリ
licenses/        # 元コードのライセンス・変更記録
tests/           # 起動と設定の検証
lazy-lock.json
stylua.toml
```

## 設定の変更

- オプションは `lua/config/options.lua`、キー操作は `lua/config/keymaps.lua` を編集します。
- プラグイン設定は `lua/plugins/` の該当ファイルを直接編集します。
- モジュールを追加・削除する場合は `lua/plugins/init.lua` の import 一覧を変更します。
- 言語設定は `lua/plugins/lang/` にあります。TypeScript は `vtsls` を使用します。
- Go の lint 設定は `lua/plugins/linting.lua` に統合しています。

`c / C / d / D / x / X` はレジスタを上書きせず変更・削除し、
`<leader>d / <leader>D` はクリップボードに切り取ります。

`lazyvim.json` と `:LazyExtras` は使用しません。ダッシュボードの `c` から設定ファイルを探せます。
`:Lazy update` はプラグインのみを更新し、この設定自体は更新しません。

## セットアップ

Neovim 0.11.2 以降と `git` が必要です。
設定を配置して `nvim` を起動すると、`lazy.nvim` と必要なプラグインが取得されます。
言語サーバーや外部ツールは各言語設定と Mason で管理します。

## 検証

プラグインのインストール後、このディレクトリで実行します。
起動テストはプラグインの自動取得・更新を止め、一時ディレクトリにキャッシュと状態を保存します。

```sh
stylua --check init.lua lua tests
nvim --headless -u NONE -i NONE -l tests/smoke.lua
```

元コードの出典と変更内容は `licenses/README.md` に記録しています。
