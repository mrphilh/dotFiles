-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>o", vim.cmd.Ex, { desc = "Open file explorer" })

-- Colapse line belon onto the currnet line separated by a space, while keeping
--  the cursor inplace
keymap.set("n", "J", "mzJ`z")
-- Page (u)p/(d)own but keep the cirspr in the middle of the screen
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
-- Keep search term in the middle of the screen
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
-- chmod currnet file to be executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
