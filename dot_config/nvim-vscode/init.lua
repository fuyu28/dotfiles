local opt = vim.opt

-- 行番号の表示
opt.number = true
opt.relativenumber = true

-- タブとインデントの設定
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- 検索設定
opt.ignorecase = true
opt.smartcase = true

-- クリップボード
opt.clipboard:append({ "unnamedplus" })

-- 折り返し行を自然に移動
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- 削除・変更で無名レジスタを汚さない（内容を貼り付けたいときは d / c を使う）
for _, key in ipairs({ "c", "C", "d", "D", "x", "X" }) do
  vim.keymap.set({ "n", "x" }, key, '"_' .. key)
end
