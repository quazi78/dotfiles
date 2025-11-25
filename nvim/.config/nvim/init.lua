vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- vim.cmd("set showtabline=2")
vim.cmd("set laststatus=2")
vim.cmd("set hidden")
vim.cmd("set noshowmode")
vim.cmd("set ic")
vim.cmd("set hlsearch")
vim.cmd("nnoremap ; :")
vim.g.mapleader = " "

require("config.lazy")

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Tab>', ':bnext<CR>', {})

vim.cmd.colorscheme "kanagawa"
