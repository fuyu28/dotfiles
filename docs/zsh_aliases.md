## ファイル表示まわり

### `alias b='bat'`

* `cat` の代わりに **`b` で bat を呼ぶ**。
* シンタックスハイライト・行番号付きでファイルを表示。
* 例: `b main.go`

### `alias bc='bat --style=plain'`

* 色や枠を消した **素の表示モードの bat**。
* パイプの途中に挟みたいときとかに便利。
* 例: `bc config.yaml | rg foo`

---

## ディレクトリ移動・ナビ

### `alias z='zoxide query -l | fzf --tac --preview "eza -la --color=always {}" | xargs -r cd'`

* zoxide が覚えてるディレクトリのリストを **fzf で選んで cd するランチャー**。
* 右側に `eza -la` のプレビュー付き。
* 例: シェルで `z` → fzf 画面から行きたいディレクトリ選ぶだけ。

### `alias zz='z'`

* 上の `z` を **打ちやすくしたショートカット**。
* `zz` と叩くだけで z ランチャー起動。

---

## 検索系（find / grep の現代版）

### `alias f='fd -HI'`

* `find` の代わりに **`fd` を “全部対象モード” で呼ぶ**。
* `-H` 隠しファイルも見る
* `-I` .gitignore 無視
* 例: `f '*.go'` → カレント以下の .go を高速で探す

### `alias g='rg -uu --color=always'`

* `grep` の代わりに **ripgrep を “全部対象モード” で呼ぶ**。
* `-uu` で隠しファイル・.gitignore 無視・バイナリ以外ほぼ全部対象。
* 例: `g TODO` → リポジトリ全体から TODO 探す

---

## ls 強化（eza）

### `alias l='eza -a --icons'`

* `ls` の代わりに **隠しファイル込みの eza**。
* アイコン付きで視認性アップ。
* 例: `l`

### `alias ll='eza -la --icons --git'`

* `ls -la` 的なやつを **詳細表示＋git 情報付き** で。
* 例: `ll` → 変更状態が一目で分かる

### `alias la='eza -la --icons --git'`

* `ll` と同じ。`la` 派の指にも対応した感じ。

---

## プロセス・リソース・ネットワーク系

### `alias p='procs'`

* `ps` の代わりに **人間が読める ps**。
* ツリー表示・色付きでどのプロセスが何か分かりやすい。

### `alias dus='dust'`

* `du` の代わりに **ディスク使用量を木構造で見せてくれる dust**。
* どのディレクトリが容量食ってるか一瞬で分かる。
* 例: `dus` / `dus .`

### `alias d='duf'`

* `df` の代わりに **きれいな TUI 風ディスク一覧**。
* マウントポイント・使用率が見やすく表示される。

### `alias pg='gping'`

* `ping` の代わりに **グラフ付き ping**。
* レイテンシの変動が視覚的に分かる。
* 例: `pg google.com`

### `alias fk='ps aux | fzf | awk "{print \$2}" | xargs -r kill'`

* **fzf でプロセスを選んで kill できるやつ**。
* `fk` → プロセス一覧から選択 → 選んだやつに kill。

---

## HTTP / API / ドキュメント・テキスト処理

### `alias h='http'`

* `curl` より人間フレンドリーな **httpie** を短く呼ぶ。
* JSON をキレイに表示してくれるから API 叩くのが楽。
* 例: `h GET https://api.github.com`

### `alias td='tldr'`

* man ページの “要約版”。
* 具体例ベースでコマンドの使い方だけサクッと見れる。
* 例: `td tar`

### `alias sdr='sd'`

* `sed` の代わりに **現代版 search & replace ツール sd**。
* 正規表現も直感的で、よくある置換が書きやすい。
* 例: `sdr foo bar file.txt`

### `alias jf='fq'`

* JSON / 構造化ログ用の **フィルタリングツール fq** を短く呼ぶ。
* jq 的なことをもっとモダンにできる。

---

## Git 周りのショートカット

### `alias gs='git status'`

### `alias gc='git commit'`

### `alias gp='git push'`

### `alias gl='git pull'`

### `alias gd='git diff'`

### `alias lg='lazygit'`

* よく使う git コマンドを **2文字ショートカット化**。
* `lg` で lazysgiy の TUI を即起動。

---

## コマンド終了通知

### `alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//\'')"''`

* 直前に実行したコマンドが終わったら **デスクトップ通知を出す alias**。
* ジョブの末尾に `; alert` をつけて使うイメージ。
* 例:
  `long_running_command; alert`
  → 終わったら「成功 or 失敗」でアイコン変えて通知。

