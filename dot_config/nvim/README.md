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

## プラグイン一覧

現在 `lazy-lock.json` で管理しているプラグインです。`lazy.nvim` 自身も含みます。

| プラグイン                                    | 役割                                                           |
| --------------------------------------------- | -------------------------------------------------------------- |
| `folke/lazy.nvim`                             | プラグインのインストール・遅延読み込み・更新を管理             |
| `folke/snacks.nvim`                           | ファイル検索、ファイル一覧、ターミナル、通知などをまとめて提供 |
| `nvim-lualine/lualine.nvim`                   | ステータスラインを表示                                         |
| `akinsho/bufferline.nvim`                     | バッファをタブ風に表示                                         |
| `nvim-mini/mini.icons`                        | ファイル種別や LSP のアイコンを提供                            |
| `folke/noice.nvim`                            | メッセージ、コマンドライン、通知の表示を改善                   |
| `MunifTanjim/nui.nvim`                        | UI 部品を提供する noice などの依存ライブラリ                   |
| `folke/which-key.nvim`                        | `<leader>` などのキーバインド候補を表示                        |
| `catppuccin/nvim`                             | Catppuccin カラースキーム                                      |
| `folke/tokyonight.nvim`                       | TokyoNight カラースキーム（現在の既定）                        |
| `MagicDuck/grug-far.nvim`                     | プロジェクト内の検索・置換 UI                                  |
| `folke/flash.nvim`                            | 移動先を素早く選ぶジャンプ・検索操作                           |
| `lewis6991/gitsigns.nvim`                     | Git の変更箇所を行番号欄に表示し、操作を追加                   |
| `folke/trouble.nvim`                          | diagnostics、参照、シンボルなどを一覧表示                      |
| `monaqa/dial.nvim`                            | 数値、日付、真偽値などを増減                                   |
| `folke/persistence.nvim`                      | セッションを保存・復元                                         |
| `nvim-lua/plenary.nvim`                       | 多くのプラグインが使う Lua 共通ライブラリ                      |
| `smjonas/inc-rename.nvim`                     | LSP のシンボル名を入力中にプレビューしながら変更               |
| `saghen/blink.cmp`                            | 補完候補の表示と確定（現在の補完エンジン）                     |
| `rafamadriz/friendly-snippets`                | 各言語のスニペット集                                           |
| `nvim-mini/mini.pairs`                        | 括弧や引用符を自動で対にする                                   |
| `nvim-mini/mini.ai`                           | Treesitter 対応の拡張テキストオブジェクト                      |
| `folke/ts-comments.nvim`                      | TypeScript 系ファイルのコメント記法を補正                      |
| `folke/lazydev.nvim`                          | Lua 設定を編集する際の開発用補完・型情報                       |
| `neovim/nvim-lspconfig`                       | LSP サーバーを Neovim に接続・設定                             |
| `mason-org/mason.nvim`                        | LSP、formatter、linter など外部ツールをインストール            |
| `mason-org/mason-lspconfig.nvim`              | Mason と lspconfig の連携                                      |
| `stevearc/conform.nvim`                       | formatter を実行し、保存時の整形を設定                         |
| `mfussenegger/nvim-lint`                      | 外部 linter の結果を diagnostics として表示                    |
| `b0o/SchemaStore.nvim`                        | JSON Schema を追加し、JSON の補完・検証を改善                  |
| `nvim-treesitter/nvim-treesitter`             | 構文解析、ハイライト、折りたたみ、選択範囲を改善               |
| `nvim-treesitter/nvim-treesitter-textobjects` | 関数・クラスなどを単位に移動・選択                             |
| `windwp/nvim-ts-autotag`                      | HTML・JSX などのタグを自動補完・更新                           |
| `iamcco/markdown-preview.nvim`                | Markdown をブラウザでプレビュー                                |
| `MeanderingProgrammer/render-markdown.nvim`   | Markdown を編集中の画面内で装飾表示                            |
| `lervag/vimtex`                               | LaTeX の編集、コンパイル、PDF 閲覧を支援                       |

言語別の設定は `lua/plugins/lang/` にあり、各ファイルから必要な LSP、formatter、linter、Treesitter 言語を追加しています。
