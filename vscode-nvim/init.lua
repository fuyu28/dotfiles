-- core setting
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- UI / 言語設定
vim.opt.langmenu = "en_US.UTF-8"
vim.cmd("language message en_US.UTF-8")
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true -- 行番号表示
vim.cmd("syntax enable") -- シンタックスハイライト

-- ノーマル／ビジュアルで行頭・行末へ
map("n", "<S-h>", "^", opts)
map("n", "<S-l>", "$", opts)

-- 数値インクリメント／デクリメント
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- 全選択
map("n", "<C-a>", "ggVG", opts)

-- クリップボード連携（行／選択コピー）
map("n", "yy", '"+yy', opts)
map("v", "y", '"+y', opts)
