return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      PATH = "append"
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "pyright",
        "ruff_lsp"
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "snakefmt", -- snakemake formatter
        -- "isort", -- python formatter
        -- "black", -- python formatter
        -- "pylint", -- python linter
        -- "prettier", -- markdown formatter
        -- "stylua" -- lua formatter
      },
    })
  end,
}
