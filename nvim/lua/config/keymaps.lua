-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ノーマル／ビジュアルで行頭・行末へ
map("v", "<S-h>", "^", opts)
map("v", "<S-l>", "$", opts)

-- 数値インクリメント／デクリメント
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- 全選択
map("n", "<C-a>", "ggVG", opts)

-- Insert モードで 'jj' を押したら <Esc>
map("i", "jj", "<Esc>", opts)

-- Insert モードで 'jk' を押したら <Esc> + ファイル保存
map("i", "jk", "<Esc>:w<CR>", opts)

map("n", "<F5>", function()
  vim.o.conceallevel = (vim.o.conceallevel == 0) and 2 or 0
end, opts)
