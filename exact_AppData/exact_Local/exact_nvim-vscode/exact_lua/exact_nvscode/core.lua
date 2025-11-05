-- UI / 言語設定
vim.opt.langmenu = "en_US.UTF-8"
vim.cmd("language message en_US.UTF-8")
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true -- 行番号表示
vim.cmd("syntax enable") -- シンタックスハイライト

-- お好み：リーダーキーなど
vim.g.mapleader = " "

-- VSCode 内フラグ（必要なら分岐に使える）
-- if vim.g.vscode then ... end
