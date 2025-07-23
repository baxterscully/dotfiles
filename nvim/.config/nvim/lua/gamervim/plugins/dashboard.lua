local function dotfiles()
  require('telescope.builtin').find_files({
    prompt_title = "< dotfiles >",
    cwd = "~/dotfiles",
    hidden = true,
  })
  require('neo-tree.command').execute({
    action = 'toggle',
    reveal_force_cwd = true
  })
end

local function syntensor()
  require('telescope.builtin').find_files({
    prompt_title = "< Syntensor Projects >",
    cwd = "~/syntensor/dev/",
    hidden = true,
  })
  require('neo-tree.command').execute({
    action = 'toggle',
    reveal_force_cwd = true
  })
end

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Syntensor Projects',
            group = 'DiagnosticHint',
            action = syntensor,
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = dotfiles,
            key = 'd',
          },
        },
      },
    })
  end,
  dependencies = {'nvim-tree/nvim-web-devicons'}
}
