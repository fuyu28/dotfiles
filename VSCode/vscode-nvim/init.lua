-- core setting
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.opt.langmenu = 'en_US.UTF-8'
vim.cmd('language message en_US.UTF-8')
vim.opt.clipboard = 'unnamedplus'

map("n", "<S-h>", "^", opts)
map("n", "<S-l>", "$", opts)
map("v", "<S-h>", "^", opts)
map("v", "<S-l>", "$", opts)
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- ノーマルモードの yy を "+yy にする（行コピー）
vim.keymap.set('n', 'yy', '"+yy', { noremap = true, silent = true })

-- ビジュアルモードの y も "+y にする（選択コピー）
vim.keymap.set('v', 'y', '"+y', { noremap = true, silent = true })

-- vscode only
--if vim.g.vscode then
--end

-- neovim only
if not vim.g.vscode then
    -- only Neovim
    vim.cmd('syntax enable')
    vim.opt.number = true
end

