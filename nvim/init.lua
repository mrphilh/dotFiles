----------------------------------------------
--- System parameters
----------------------------------------------

local platform = vim.loop.os_uname().sysname

local vars = {
    MAKE_BIN = (platform == "FreeBSD" and {"gmake"} or {"make"})[1]
}
----------------------------------------------
--- Basic settings
----------------------------------------------

-- set leader key to space
vim.g.mapleader = " "

-- line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number         = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
vim.opt.tabstop    = 4     -- 4 spaces for tabs (prettier default)
vim.opt.shiftwidth = 4     -- 4 spaces for indent width
vim.opt.expandtab  = true  -- expand tab to spaces
vim.opt.autoindent = true  -- copy indent from current line when starting new one
vim.opt.wrap       = false -- disable line wrapping

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase  = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
vim.opt.cursorline = true -- highlight the current cursor line

-- file explorer
vim.cmd("let g:netrw_liststyle = 3")

-- display settings
vim.opt.termguicolors = true
vim.opt.background    = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn    = "yes" -- show sign column so that text doesn't shift

-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
vim.opt.swapfile = false

-- persistent undo
vim.opt.undodir  = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

-- title
vim.opt.title       = true
vim.opt.titlestring = "nvim"

-- lsp
vim.lsp.inlay_hint.enable(true)

----------------------------------------------
--- Plugins
----------------------------------------------
local plugins = {
    { "nvim-lua/plenary.nvim" }, -- general Lua functions used by other plugins
    { "nvim-tree/nvim-web-devicons" }, -- icons used by many plugins
    { "folke/tokyonight.nvim" },
    { "nvim-lualine/lualine.nvim"}, -- status line 
--	{ "tpope/vim-fugitive" }, -- git 
    { "nvim-telescope/telescope.nvim" }, -- fuzzy find
    { "nvim-telescope/telescope-fzf-native.nvim", build = vars.MAKE_BIN }, -- fzf backed fuzzy find
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "mason-org/mason.nvim" }, -- LS manager
    { "neovim/nvim-lspconfig" }, -- general LSP config
    { "mason-org/mason-lspconfig.nvim" }, --
    { "stevearc/conform.nvim"}, -- code formatting not covered by LSP
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts_extend = { "sources.default" }
    },
    { "folke/todo-comments.nvim" },
    { "folke/trouble.nvim" }, 
    { "folke/which-key.nvim"},

}

----------------------------------------------
--- Launch Lazy Plugin Manager
----------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins)

----------------------------------------------
--- Plugin Configuration
----------------------------------------------
require("lualine").setup()
--require("vim-fugitive").setup()
require("telescope").setup()
require("nvim-treesitter.config").setup({
    ensure_installed = {
        "typescript",
        "python",
        "rust",
        "go",
    },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true, },
})
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright",
        "eslint",
        "gopls",
        "ruff",
--      If FreeBSD rust analyzer must be installed manually
--      "rust_analyzer",
    },
})
require("conform").setup({
    default_format_opts = { lsp_format = "fallback" },
    formatters_by_ft = {
        javascript = { "prettier", stop_after_first = true },
        typescript = { "prettier", stop_after_first = true },
        json       = { "prettier", stop_after_first = true },
        html       = { "prettier", stop_after_first = true },
        css        = { "prettier", stop_after_first = true },
    },
})
require("blink.cmp").setup(
    {
        build = "cargo +nightly-2025-09-30 build --release",
    }
)
require("todo-comments").setup()
require("trouble").setup()
require("which-key").setup({
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeout = 500
    end,
})


----------------------------------------------
--- Colorscheme
----------------------------------------------
vim.cmd.colorscheme("tokyonight")		

----------------------------------------------
--- LSP Config
----------------------------------------------

vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
        },
    },
})
vim.lsp.enable("rust_analyzer")


----------------------------------------------
--- Keymaps
----------------------------------------------

-- open netrw
vim.keymap.set("n", "<leader>o", vim.cmd.Ex, { desc = "Open file explorer" })

-- Colapse line belon onto the currnet line separated by a space, while keeping
--  the cursor inplace
--
vim.keymap.set("n", "J", "mzJ`z")

-- Page (u)p/(d)own but keep the cirspr in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search term in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- chmod currnet file to be executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Trouble Plugin Keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Open/close trouble list" } )
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Open trouble workspace diagnostics" } )
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Open trouble document diagnostics" } )
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Open trouble quickfix list" } )
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", { desc = "Open trouble location list" } )
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<CR>", { desc = "Open todos in trouble" } )

-- Telescope Plugin Keymaps
vim.keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader>ps", "<cmd>Telescope live_grep<cr>", { desc = "Find string under cursor in cwd" })
vim.keymap.set("n", "<leader>pc", "<cmd>Telescope grep_string<cr>", { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>pt", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
vim.keymap.set("n", "<leader>vh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
