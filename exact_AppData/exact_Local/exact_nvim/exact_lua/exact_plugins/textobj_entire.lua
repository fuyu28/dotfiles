return {
  "fuyu28/textobj-entire.nvim",
  lazy = false, -- always available
  config = function()
    require("textobj_entire").setup()
  end,
}
