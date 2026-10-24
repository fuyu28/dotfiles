return {
  {
    "nvim-mini/mini.trailspace",
    version = false,
    event = "LazyFile",
    opts = {},
    config = function(_, opts)
      require("mini.trailspace").setup(opts)

      vim.api.nvim_set_hl(0, "MiniTrailspace", {
        bg = "#ff5555",
      })

      -- Trim trailing whitespace and blank lines at the end of the file on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("config_trim_on_save", { clear = true }),
        callback = function(event)
          if vim.g.trim_on_save == false then
            return
          end
          local bo = vim.bo[event.buf]
          -- Markdown uses trailing spaces as hard line breaks
          if bo.buftype ~= "" or not bo.modifiable or vim.tbl_contains({ "markdown", "diff" }, bo.filetype) then
            return
          end
          vim.api.nvim_buf_call(event.buf, function()
            MiniTrailspace.trim()
            MiniTrailspace.trim_last_lines()
          end)
        end,
      })

      Snacks.toggle({
        name = "Trim on Save",
        get = function()
          return vim.g.trim_on_save ~= false
        end,
        set = function(state)
          vim.g.trim_on_save = state
        end,
      }):map("<leader>ut")
    end,
  },
}
