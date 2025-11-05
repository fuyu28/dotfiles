local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

-- rtp はこれまで通り
vim.opt.runtimepath:append(root)

-- Lua module 検索パス
package.path = table.concat({root .. "\\lua\\?.lua", root .. "\\lua\\?\\init.lua", root .. "/lua/?.lua",
                             root .. "/lua/?/init.lua", package.path}, ";")

-- packadd が見に行けるように packpath へも登録
vim.opt.packpath:prepend(root)
-- --- end BOOTSTRAP ---

require("nvscode.core")
require("nvscode.plugins")
require("nvscode.options")
require("nvscode.keymaps")
require("nvscode.textobj")
