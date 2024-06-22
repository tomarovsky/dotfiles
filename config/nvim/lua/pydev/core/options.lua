vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
local cmd = vim.cmd
local api = vim.api

opt.mouse = ''
opt.relativenumber = false
opt.number = true

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.smarttab = true
opt.softtabstop = 4
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.guicursor = ""
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- highlight on search
opt.hlsearch = true

-- save undo history
opt.undofile = true

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.ruler = true

-- folding
opt.foldmethod = "indent"
opt.foldlevel = 99

-- completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- clipboard
-- opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- disable status line
opt.laststatus = 0

-- decrease update time
opt.updatetime = 250

-- tab/space/indent settings for each filetype
api.nvim_create_autocmd({ "BufNewFile", "BufRead" },
  { pattern = "Snakefile,*.smk", command = "set filetype=snakemake" })
api.nvim_create_autocmd({ "BufRead", "BufNewFile" },
  { pattern = "*.py,*.smk", command = "match BadWhitespace /\\s\\+$/" })

