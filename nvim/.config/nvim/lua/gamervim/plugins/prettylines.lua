local gitblame = require("gitblame")
local opts = {
    theme = "catppuccin",
    sections = {
        lualine_y = {
            { gitblame.get_current_blame_text, cond = gitblame.is_blame_text_available }
        },
        lualine_z = {{ "progress", separator = "" }, { "location", separator = "" }},
    }
}

vim.g.gitblame_display_virtual_text = 0

return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = opts,
        -- config = function ()
        --     require("lualine").setup({
        --         options = opts,
        --     })
        -- end
    },
}
