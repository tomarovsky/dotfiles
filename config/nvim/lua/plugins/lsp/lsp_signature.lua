return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  config = function()
    require("lsp_signature").setup {
      bind = true,
      floating_window = false, -- main window
      hint_enable = true,
      hint_prefix = "🐖 ",
      handler_opts = {
        border = "rounded"
      }
    }
  end
}
