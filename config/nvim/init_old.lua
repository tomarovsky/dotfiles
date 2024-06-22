-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
        lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Add plugins
require('lazy').setup({
    {'nvim-lua/plenary.nvim'},                                -- Nessesary functions
    {'ellisonleao/gruvbox.nvim'},                             -- Theme
    {'norcalli/nvim-colorizer.lua'},                          -- Colorizer 
    {'nvim-tree/nvim-web-devicons'},                          -- Icons
    {'tpope/vim-fugitive'},                                   -- Git commands in nvim
    {'tpope/vim-rhubarb'},                                    -- Fugitive-companion to interact with github
    {'numToStr/Comment.nvim'},                                -- "gc" to comment visual regions/lines
    {"folke/todo-comments.nvim"},                             -- TODO comments
	{"nvim-tree/nvim-tree.lua",                               -- Nvim Tree 
        dependencies = {"nvim-tree/nvim-web-devicons"}},
    {'nvim-lualine/lualine.nvim'},                            -- Fancier statusline
    {'lukas-reineke/indent-blankline.nvim',                   -- Add indentation guides even on blank lines
		main = 'ibl',
		version = "=3.5.4"},
    {'lewis6991/gitsigns.nvim'},                              -- Add git related info in the signs columns and popups
    {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"}, -- Highlight, edit, and navigate code
    {'nvim-treesitter/nvim-treesitter-textobjects'},          -- Additional textobjects for treesitter
    {'williamboman/mason.nvim'},                              -- Automatically install LSPs to stdpath for neovim
    {'williamboman/mason-lspconfig.nvim'},                    -- Mason Syntax Formaters
    {'WhoIsSethDaniel/mason-tool-installer.nvim'},            -- Mason Syntax Formaters
    {'hrsh7th/nvim-cmp',                                      -- Autocompletion
        dependencies = {
			'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-buffer', -- source for text in buffer
            'hrsh7th/cmp-path', -- source for file system paths
			'hrsh7th/cmp-nvim-lsp',
        },
    },
	{'neovim/nvim-lspconfig',                                 -- LSP
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			{'antosha417/nvim-lsp-file-operations', config = true},
			{'folke/neodev.nvim'},
		},
    },
    -- Fuzzy Finder (files, lsp, etc)
    {'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' }},
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
})

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = ''

-- Cursor
vim.opt.guicursor = ""

-- Tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.keymap.set({ 'n', 'v' }, "<Tab>", ">>", { silent = true })
vim.keymap.set({ 'n', 'v' }, "<S-Tab>", "<<", { silent = true })

--Set highlight on search
vim.o.hlsearch = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- more powerful backspacing
vim.opt.backspace = "indent,eol,start"
vim.opt.ruler = true

-- Disable status line
vim.opt.laststatus = 0

-- Decrease update time
vim.o.updatetime = 250

-- Remap keys for split navigation
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Enable folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99 

-- Enable folding with the spacebar
vim.keymap.set("n", "<Space>", "za")

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Transparent background
vim.cmd.highlight({ "normal", "guibg=NONE ctermbg=NONE" })

-- Colorizer
require'colorizer'.setup()

-- Disable gray left column
vim.cmd.highlight({ "clear", "SignColumn" })
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Highlight bad whitespace
vim.cmd.highlight({ "BadWhitespace", "ctermbg=red guibg=red" })

--Set statusbar
require('lualine').setup {
    options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
    },
}

-- Comment.nvim and TODO comments
require('Comment').setup()
require("todo-comments").setup()

--Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Highlight tabs
require('ibl').setup {
    indent = { 
        char = '┊',
        },
    exclude = { 
        filetypes = {
            'help',
        },
    },
}

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
		vim.keymap.set('n', '[c', require('gitsigns').preview_hunk, { buffer = bufnr })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr })
    end,
}


-- Nvim-tree 
require('nvim-tree').setup({
	view = {
		width = 35,
		relativenumber = true,
	},
    -- change folder arrow icons
    renderer = {
		indent_markers = {
			enable = true,
		},
        icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
        },
    },
    -- disable window_picker for
    -- explorer to work well with
    -- window splits
    actions = {
        open_file = {
			window_picker = {
				enable = false,
			},
        },
    },
    -- filters = {
    --     custom = { ".DS_Store" },
    -- },
    git = {
        ignore = false,
    },
})

-- set keymaps
local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

local nvimtree = require("nvim-tree")

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Telescope configuration
-- Setup
require('telescope').setup {
    defaults = {
		path_display = { "smart" },
        mappings = {
            i = {
                ["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
                ["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
            },
        },
    },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

--Add leader shortcuts
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files { previewer = false } end)
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<leader>fs', function() require('telescope.builtin').grep_string() end)
vim.keymap.set('n', '<leader>?', function() require('telescope.builtin').oldfiles() end)

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true, -- false will disable the whole extension
	},
	-- enable indentation
    indent = {
        enable = true,
    },
	ensure_installed = {
        "bash",
        "python",
	    "snakemake",
	    "yaml",
	    "json",
	    "toml",
	    "markdown",
	    "dockerfile",
	    "gitignore",
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
        },
    },
}

-- Diagnostic settings
vim.diagnostic.config {
    virtual_text = false,
    update_in_insert = true,
}

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist)

-- Mason
require("mason").setup({
    PATH = "prepend",
})

require("mason-lspconfig").setup({
	-- list of servers for mason to install
	ensure_installed = {
		"pyright",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"isort", -- python formatter
		"black", -- python formatter
		"pylint", -- python linter
		"snakefmt", -- snakemake formater	
	},
})

-- LSP settings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
		vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
		vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
		vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	end,
})

-- Enable the following language servers
for _, lsp in ipairs({ 'pyright' }) do
	require('lspconfig')[lsp].setup {
		on_attach = on_attach,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	}
end

-- Autocompletion
require("cmp").setup({
	completion = {
		completeopt = "menu,menuone,preview,noselect",
	},
	snippet = { -- configure how nvim-cmp interacts with snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = require("cmp").mapping.preset.insert({
		["<C-k>"] = require("cmp").mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = require("cmp").mapping.select_next_item(), -- next suggestion
		["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
		["<C-f>"] = require("cmp").mapping.scroll_docs(4),
		["<C-Space>"] = require("cmp").mapping.complete(), -- show completion suggestions
		["<C-e>"] = require("cmp").mapping.abort(), -- close completion window
		["<CR>"] = require("cmp").mapping.confirm({ select = false }),
	}),
	-- sources for autocompletion
	sources = require("cmp").config.sources({
		{ name = "nvim_lsp"},
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
})

-- Set tab/space/indent settings for each filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "Snakefile,*.smk", command = "set filetype=snakemake" })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.py", command = "match BadWhitespace /\\s\\+$/" })



