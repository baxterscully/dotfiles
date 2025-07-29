return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
        local h_pct = 0.90
        local w_pct = 0.80
        local w_limit = 75
        
        local standard_setup = {
            -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            -- borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" }, -- thick lines
            -- borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" }, -- double lines
            -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
            borderchars = { "─", "│", "─", "│", "╭",  "╮", "╯", "╰"},

            preview = { hide_on_startup = true },
            layout_strategy = 'vertical',
            layout_config = {
                vertical = {
                    mirror = true,
                    prompt_position = 'top',
                    width = function(_, cols, _)
                        return math.min(math.floor(w_pct * cols), w_limit)
                    end,
                    height = function(_, _, rows)
                        return math.floor(rows * h_pct)
                    end,
                    preview_cutoff = 10,
                    preview_height = 0.4,
                },
            },
        }
        
        local fullscreen_setup = {
            -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            -- Alternative border styles you can try:
            -- borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" }, -- thick lines
            -- borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" }, -- double lines
            -- borderchars = { "-", "|", "-", "|", "+", "+", "+", "+" }, -- simple ASCII
            -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
            borderchars = { "─", "│", "─", "│", "╭",  "╮", "╯", "╰"},

            preview = { hide_on_startup = false },
            layout_strategy = 'flex',
            layout_config = {
                flex = { flip_columns = 100 },
                horizontal = {
                    mirror = false,
                    prompt_position = 'top',
                    width = function(_, cols, _)
                        return math.floor(cols * w_pct)
                    end,
                    height = function(_, _, rows)
                        return math.floor(rows * h_pct)
                    end,
                    preview_cutoff = 10,
                    preview_width = 0.5,
                },
                vertical = {
                    mirror = true,
                    prompt_position = 'top',
                    width = function(_, cols, _)
                        return math.floor(cols * w_pct)
                    end,
                    height = function(_, _, rows)
                        return math.floor(rows * h_pct)
                    end,
                    preview_cutoff = 10,
                    preview_height = 0.5,
                },
            },
        }

        require('telescope').setup({
            defaults = vim.tbl_extend('error', standard_setup, {
                prompt_prefix = "  ",
                selection_caret = "  ",
                entry_prefix = "  ",
                sorting_strategy = "ascending",
                path_display = { "filename_first" },
                file_ignore_patterns = {
                    "node_modules/",
                    "%.git/",
                    "%.DS_Store",
                    "target/",
                    "build/",
                    "dist/",
                },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                    '--glob=!.git/*',
                },
                color_devicons = true,
                mappings = {
                    n = {
                        ['o'] = require('telescope.actions.layout').toggle_preview,
                        ['<C-c>'] = require('telescope.actions').close,
                    },
                    i = {
                        ['<C-o>'] = require('telescope.actions.layout').toggle_preview,
                    },
                },
            }),
            
            pickers = {
                find_files = vim.tbl_extend('error', standard_setup, {
                    hidden = true,
                    find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git", "--exclude", "node_modules" },
                }),
                git_files = standard_setup,
                buffers = vim.tbl_extend('error', standard_setup, {
                    show_all_buffers = true,
                    sort_lastused = true,
                    mappings = {
                        i = {
                            ["<C-d>"] = require("telescope.actions").delete_buffer,
                        },
                        n = {
                            ["dd"] = require("telescope.actions").delete_buffer,
                        },
                    },
                }),
                live_grep = vim.tbl_extend('error', fullscreen_setup, {
                    additional_args = function()
                        return { "--hidden", "--glob", "!.git/*", "--glob", "!node_modules/*" }
                    end,
                }),
                grep_string = vim.tbl_extend('error', fullscreen_setup, {
                    additional_args = function()
                        return { "--hidden", "--glob", "!.git/*", "--glob", "!node_modules/*" }
                    end,
                }),
                colorscheme = vim.tbl_extend('error', standard_setup, {
                    enable_preview = true,
                }),
                help_tags = fullscreen_setup,
                commands = standard_setup,
                command_history = standard_setup,
                marks = standard_setup,
                registers = {
                    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                    layout_strategy = 'cursor',
                },
                keymaps = fullscreen_setup,
                builtin = standard_setup,
                lsp_references = fullscreen_setup,
                lsp_definitions = fullscreen_setup,
                lsp_implementations = fullscreen_setup,
            },
            
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })
        
        -- Load extensions
        pcall(require('telescope').load_extension, 'fzf')
        
        local builtin = require('telescope.builtin')
        
        -- Your original keymaps
        vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = "Find Files" })
        vim.keymap.set('n', '<leader>fa', function()
            builtin.find_files({ no_ignore = true, hidden = true })
        end, { desc = "Find All Files (no ignore)" })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Git Files" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent Files" })
        
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = "Live Grep" })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = "Search Word Under Cursor" })
        vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = "Commands" })
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = "Help Tags" })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = "Keymaps" })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = "Telescope Builtins" })
        
        vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = "LSP References" })
        -- vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = "LSP Definitions" }) conflict with lazydocker
        vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = "LSP Implementations" })
        vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = "Document Symbols" })
        vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols, { desc = "Workspace Symbols" })
        
        vim.keymap.set('n', '<leader>:', builtin.command_history, { desc = "Command History" })
        vim.keymap.set('n', '<leader>m', builtin.marks, { desc = "Marks" })
        
        -- vim.keymap.set('n', '<leader>fc', function()
        --     builtin.find_files({ cwd = vim.fn.stdpath("config") })
        -- end, { desc = "Find Config Files" })
    end
}
