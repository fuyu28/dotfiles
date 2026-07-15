-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- change / x / visual paste はブラックホール（delete 系の d/D は標準のまま）
map({ "n", "x" }, "c", '"_c')
map({ "n", "x" }, "C", '"_C')
map({ "n", "x" }, "x", '"_x')
map("x", "p", '"_dP') -- ビジュアルでペーストしてもヤンクが残る
