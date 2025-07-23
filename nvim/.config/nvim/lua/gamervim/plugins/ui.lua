return {
    {

        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                opts = {
                    top_down = false,
                    background_color = "#000000"
                },
            },
        },
        config = function ()
            require("noice").setup({
                views = {
                    selection_menu = {
                        backend = "popup",
                        relative = "editor",
                        focusable = true,
                        enter = true,
                        zindex = 200,
                        position = {
                            row = "30%",
                            col = "50%",
                        },
                        size = {
                            min_width = 60,
                            width = "auto",
                            height = "auto",
                            max_height = 15,
                        },
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                            text = {
                                top = " Selection ",
                            },
                        },
                        win_options = {
                            winhighlight = {
                                Normal = "NoicePopup",
                                FloatTitle = "NoicePopupTitle",
                                FloatBorder = "NoicePopupBorder",
                                CursorLine = "Visual",
                            },
                            winbar = "",
                            foldenable = false,
                            cursorline = true,
                        },
                    },
                },
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = true, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                            }
                        },
                        view = "mini",
                        opts = { skip = true },
                    },
                },
            })
        end
    },
    {
        "folke/snacks.nvim",
        opts = {
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = false }, -- Configure in your statuscolumn settings
            toggle = { map = true },
            words = { enabled = true },
        },
        keys = {
            { "<leader>sn", "", desc = "+notifications" },
            { "<leader>snh", function()
                if require("snacks").config.picker and require("snacks").config.picker.enabled then
                    require("snacks").picker.notifications()
                else
                    require("snacks").notifier.show_history()
                end
            end, desc = "Notification History" },
            { "<leader>snd", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
        },
    }
}


