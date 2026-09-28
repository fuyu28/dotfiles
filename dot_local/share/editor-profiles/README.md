# Editor profiles

VS Code と Cursor の共通設定は、各エディタの内部プロファイルIDではなく、
言語名を付けた `.code-profile` ファイルとして管理する。

## 現在のプロファイル

- Base
- C/C++
- Go
- Java
- LaTeX
- Unity
- Web

## 更新方法

1. VS Code の `Preferences: Open Profiles (UI)` を開く。
2. 対象プロファイルのメニューから **Export Profile** を選び、ローカルファイルへ出力する。
3. このディレクトリに小文字の言語名で保存する。
   例: `base.code-profile`, `go.code-profile`, `latex.code-profile`。
4. 内容にトークン・ローカルパス・社内URLが含まれないことを確認してからコミットする。

## 復元方法

VS Code / Cursor の `Preferences: Open Profiles (UI)` から **Import Profile** を選び、
このディレクトリの対応ファイルを読み込む。

VS Code Settings Sync を併用する場合は、Profiles・Settings・Extensions を同期対象から外し、
このリポジトリを唯一の設定元にする。
