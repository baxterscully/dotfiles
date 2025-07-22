return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        "nvimtools/none-ls.nvim",
        ft = {"python"},
        config = function ()
            local null_ls = require('null_ls')
            null_ls.setup({
                sources = {
                    null_ls.builtin.diagnostics.mypy,
                    null_ls.builtin.diagnostics.ruff,
                }
            })
        end
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            local cmp = require('cmp')
            -- local cmp_autopairs = require('nvim-autopairs')

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = "menu,menuone,noinsert"
                },
                sources = {
                    {name = 'nvim_lsp'},
                    {name = 'luasnip'},
                    {
                        {name = 'buffer'},
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
                    ['<CR>'] = cmp.mapping.confirm({behvior = 'select'}),
                    ['<A-K>'] = cmp.mapping.scroll_docs(-4),
                    ['<A-J>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        -- require('luasnip').lsp_expand(args.body)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                local opts = {buffer = bufnr}
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })

            require('mason-lspconfig').setup({
                ensure_installed = {"lua_ls", "ts_ls", "pyright", "mypy", "ruff"},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    ["lua_ls"] = function ()
                        local lspconfig = require('lspconfig')
                        lspconfig.lua_ls.setup {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        }
                    end,
                    ["pyright"] = function ()
                        local lspconfig = require('lspconfig')
                        lspconfig.pyright.setup {
                            settings = {
                                python = {
                                    analysis = {
                                        typeCheckingMode = "off"
                                    }
                                }
                            }
                        }
                    end
                }
            })
        end
    }
}
