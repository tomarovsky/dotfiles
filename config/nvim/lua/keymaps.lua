vim.g.mapleader = " "

local keymap = vim.keymap

-- folding with the spacebar
keymap.set("n", "<Space><Space>", "za")

-- menu
keymap.set("n", "<C-t>", function()
	require("menu").open("default")
end, {})

keymap.set("n", "<RightMouse>", function()
	vim.cmd.exec('"normal! \\<RightMouse>"')

	local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
	require("menu").open(options, { mouse = true })
end, {})

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

-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- autorun snakefmt on save
keymap.set("n", "<leader>is", ":w | !snakefmt -l 150 %", { desc = "Apply Snakefmt" }) -- format file using Snakefmt
keymap.set("n", "<leader>ii", ":w | !isort --profile black %", { desc = "Apply isort" }) -- format file using Isort
keymap.set("n", "<leader>ib", ":w | !black -l 150 %", { desc = "Apply black" }) -- format file using black
