-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ノーマル／ビジュアルで行頭・行末へ
map("n", "<S-h>", "^", opts)
map("n", "<S-l>", "$", opts)
map("v", "<S-h>", "^", opts)
map("v", "<S-l>", "$", opts)

-- 数値インクリメント／デクリメント
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- クリップボード連携（行／選択コピー）
map("n", "yy", '"+yy', opts)
map("v", "y", '"+y', opts)
