local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd


-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------
-- open terminal
map('n', '<C-t>', ':Term<CR>', { noremap = true })

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)       -- open/close
map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts) -- search file

-- telescope
map('n', '<leader>f', ':Telescope find_files<CR>', default_opts)  -- refresh
map('n', '<leader>s', ':Telescope live_grep<CR>', default_opts)  -- refresh
map('n', ';', ':Telescope buffers<CR>', default_opts)  -- refresh

