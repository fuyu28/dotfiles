-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- ===== デフォルトは全部ブラックホール =====
map({ "n", "x" }, "d", '"_d')
map({ "n", "x" }, "D", '"_D')
map({ "n", "x" }, "c", '"_c')
map({ "n", "x" }, "C", '"_C')
map({ "n", "x" }, "x", '"_x')
map("x", "p", '"_dP') -- ビジュアルでペーストしてもヤンクが残る

-- ===== 明示的に「切り取ってレジスタに入れる」= <leader>d =====
-- noremap なので右辺の d は“組み込みの d”＝本物のカット
map({ "n", "x" }, "<leader>d", "d", { desc = "Cut (yank + delete)" })
map("n", "<leader>D", "dd", { desc = "Cut line" })
