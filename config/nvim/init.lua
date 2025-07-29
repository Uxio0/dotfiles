-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("config.lazy")

vim.cmd.colorscheme("Tomorrow-Night")
require('lualine').setup()

-- vim.opt.clipboard = "unnamedplus"
-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

require("nvim-tree").setup()
vim.keymap.set("n", "<leader>e", require('nvim-tree.api').tree.toggle, { desc = "Nvim Tree" })

require('Comment').setup()

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })
