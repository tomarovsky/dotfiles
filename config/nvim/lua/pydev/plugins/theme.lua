return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    local opt = vim.opt
    local cmd = vim.cmd
    -- turn on termguicolors for tokyonight colorscheme to work
    -- (have to use iterm2 or any other true color terminal)
    opt.termguicolors = true
    opt.background = "dark" -- colorschemes that can be light or dark will be made dark
    cmd("colorscheme gruvbox")
    -- transparent background
    cmd.highlight({ "normal", "guibg=NONE ctermbg=NONE" })
    -- highlight bad whitespaces
    cmd.highlight({ "BadWhitespace", "ctermbg=red guibg=red" })
    -- disable gray left column
    cmd.highlight({ "clear", "SignColumn" })
    opt.splitbelow = true
    opt.splitright = true
  end,
}
