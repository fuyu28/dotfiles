local root = vim.fn.getcwd()
local temporary = vim.fn.tempname()
vim.env.XDG_STATE_HOME = temporary .. "/state"
vim.env.XDG_CACHE_HOME = temporary .. "/cache"
vim.opt.loadplugins = true
vim.opt.rtp:prepend(root)
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

local lazy = require("lazy")
local setup = lazy.setup
lazy.setup = function(opts)
  opts.install.missing = false
  opts.checker.enabled = false
  opts.change_detection = { enabled = false }
  opts.state = temporary .. "/lazy-state.json"
  opts.readme = { enabled = false }
  setup(opts)
end

dofile(root .. "/init.lua")
local notifications = {}
vim.notify = function(message, level)
  if level == "warn" or level == "error" or (type(level) == "number" and level >= vim.log.levels.WARN) then
    notifications[#notifications + 1] = tostring(message)
  end
end
vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
-- Flush delayed notifications, including errors from plugin init callbacks.
vim.wait(750, function()
  return false
end)

local config = require("lazy.core.config")
assert(not config.plugins.LazyVim, "Unexpected LazyVim dependency")
assert(config.spec.modules[1] == "plugins.core", vim.inspect(config.spec.modules))
assert(#config.spec.notifs == 0, vim.inspect(config.spec.notifs))
for name in pairs(package.loaded) do
  assert(not name:match("^lazyvim"), "Unexpected module: " .. name)
end

local lock = vim.json.decode(table.concat(vim.fn.readfile(root .. "/lazy-lock.json")))
local locked, configured = vim.tbl_keys(lock), vim.tbl_keys(config.plugins)
table.sort(locked)
table.sort(configured)
assert(vim.deep_equal(locked, configured), "Configured plugins differ from lazy-lock.json")

local expected = {
  c = '"_c',
  C = '"_C',
  d = '"_d',
  D = '"_D',
  x = '"_x',
  X = '"_X',
  ["<leader>d"] = '"+d',
  ["<leader>D"] = '"+D',
}
for _, mode in ipairs({ "n", "x" }) do
  for lhs, rhs in pairs(expected) do
    assert(vim.fn.maparg(lhs, mode) == rhs, mode .. ": " .. lhs)
  end
end

local function opts(name)
  return require("lazy.core.plugin").values(assert(config.plugins[name]), "opts", false)
end
local lint = opts("nvim-lint")
assert(lint.linters.golangcilint.ignore_exitcode == true)
assert(vim.tbl_contains(lint.linters_by_ft.go, "golangcilint"))
local lsp = opts("nvim-lspconfig")
for _, name in ipairs({
  "gopls",
  "clangd",
  "pyright",
  "ruff",
  "vtsls",
  "jsonls",
  "marksman",
  "texlab",
  "bashls",
  "lua_ls",
}) do
  assert(lsp.servers[name] and lsp.servers[name].enabled ~= false, "Missing LSP: " .. name)
end
local formatting = opts("conform.nvim")
assert(vim.deep_equal(formatting.formatters_by_ft.go, { "goimports", "gofumpt" }))
assert(ConfigUtil.pick.picker.name == "snacks")
assert(vim.g.colors_name and vim.g.colors_name:match("^tokyonight"))
for _, path in ipairs(vim.fn.glob(root .. "/**/*.lua", false, true)) do
  assert(loadfile(path))
end
assert(#notifications == 0, table.concat(notifications, "\n"))
io.stdout:write("PASS: startup, plugins, language settings, formatting, mappings, and Lua syntax\n")
vim.cmd("qa!")
