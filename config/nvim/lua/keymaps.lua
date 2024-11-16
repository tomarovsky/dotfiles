vim.g.mapleader = " "

local keymap = vim.keymap

-- clipboard
keymap.set({"n", "v", "x"}, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
keymap.set({"n"}, '<leader>yy', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })

-- folding with the spacebar
keymap.set("n", "<Space><Space>", "za")

-- tabs
keymap.set("n",    "<Tab>",         ">>",  { noremap = true, silent = true })
keymap.set("n",    "<S-Tab>",       "<<",  { noremap = true, silent = true })
keymap.set("v",    "<Tab>",         ">gv", { noremap = true, silent = true })
keymap.set("v",    "<S-Tab>",       "<gv", { noremap = true, silent = true })

-- keys for split navigation
keymap.set("n", "<C-J>", "<C-W><C-J>")
keymap.set("n", "<C-K>", "<C-W><C-K>")
keymap.set("n", "<C-L>", "<C-W><C-L>")
keymap.set("n", "<C-H>", "<C-W><C-H>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<S-l>", "<cmd>bn<CR>", { desc = "Go to next tab" }) -- open new tab
keymap.set("n", "<S-h>", "<cmd>bp<CR>", { desc = "Go to previous tab" }) -- close current tab
keymap.set("n", "<S-x>", "<cmd>bd<CR>", { desc = "Close tab" }) --  go to next tab

-- autorun snakefmt on save
keymap.set("n", "<leader>is", ":w | !snakefmt -l 150 %", { desc = "Apply Snakefmt" }) -- format file using Snakefmt
keymap.set("n", "<leader>ii", ":w | !isort --profile black %", { desc = "Apply isort" }) -- format file using Isort
keymap.set("n", "<leader>ib", ":w | !black -l 150 %", { desc = "Apply black" }) -- format file using black
keymap.set("n", "<leader>ir", ":w | !ruff format --line-length 150 %", { desc = "Apply ruff" }) -- format file using black
