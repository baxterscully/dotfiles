vim.g.mapleader = " "
local opts = {noremap = "true", silent=true}

-- Copilot --
-- vim.keymap.set("i", "<C-Space>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
-- vim.keymap.set("n", "<leader>cd", ':Copilot disable<CR>')
-- vim.keymap.set("n", "<leader>ce", ':Copilot enable<CR>')

vim.g.copilot_no_tab_map = true

vim.keymap.set("n", "<C-c>", "<ESC>")

-- Increment and Decrement
vim.keymap.set("n", "<C-i>", "<C-a>")

-- Clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("i", "<C-c>", "<ESC>")

vim.keymap.set("n", "<leader><C-r>", ":w !python %<CR>")

-- Move text block visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--Window nav
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true })

-- Window nav with tmux
vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true })

vim.keymap.set({ "n", "x" }, 'x', '"_x', opts)
vim.keymap.set({ "n", "x" }, 'c', '"_c', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- lazydocker
vim.keymap.set("n", "<leader>ld", "<cmd>LazyDocker<CR>", { desc = "Toggle LazyDocker", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", { desc = "Toggle UndoTree", noremap = true, silent = true })


