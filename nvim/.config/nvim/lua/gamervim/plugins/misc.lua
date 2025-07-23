return {
    {
        "tpope/vim-surround", -- Surround text
        "tpope/vim-sleuth", -- auto indent
        "tpope/vim-commentary", -- comments
        "christoomey/vim-tmux-navigator",
        "mbbill/undotree"
    },
    {
        -- autopairs
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,

    },
    { -- ssh client
        'baxterscully/distant.nvim',
        branch = 'v0.3',
        config = function()
            require('distant'):setup()
        end
    },
    {
        "kmontocam/nvim-conda", -- anaconda shit
        dependencies = { "nvim-lua/plenary.nvim" },
        -- config = function ()
        --     require("nvim-conda").setup()

        --     local current_env = os.getenv("CONDA_DEFAULT_ENV")
        --     if current_env then
        --         vim.defer_fn(function ()
        --             vim.cmd("CondaActivate " .. current_env, 100)
        --         end)
        --     end
        -- end
    },
    {
		"crnvl96/lazydocker.nvim",
		event = "VeryLazy",
		opts = {}, -- automatically calls `require("lazydocker").setup()`
		dependencies = {
			"MunifTanjim/nui.nvim",
        }
    },
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        config = function ()
            require("mini.animate").setup({
                cursor = {enable = false},
                scroll = {
                    enable = true,
                    timing = function (_, n)
                        return 50 / n
                    end
                },
                open = {enable = false},
                close = {enable = false},
            })
        end
    },
    {
        "smjonas/inc-rename.nvim",
        config = function ()
            require("inc_rename").setup()
            vim.keymap.set("n", "<leader>rn", function ()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, {expr = true})
        end
    },
    -- nvim v0.8.0
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- show colors for hex strings, rgb, etc.
    {
        "norcalli/nvim-colorizer.lua",
        config = function ()
            require("colorizer").setup({
                "css",
                "javascript",
                "typescript",
                "python",
                "html",
            })
        end
    },
    {
        "f-person/git-blame.nvim",
        event = "VeryLazy",
        opts = {
            enabled = true,
            message_template = " <author> • <date> • <<sha>>",
            date_format = "%m-%d-%Y %H:%M:%S",
            virtual_text_column = 1,
        }
    },
}
