return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require('neo-tree').setup({
      filesystem = {
        window = {
          mappings = {
            ['<C-n>'] = 'close_window',
          },
        },
      },
    })
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', { desc = 'NeoTree reveal' })
    vim.cmd [[
      hi NeoTreeNormal guibg=NONE ctermbg=NONE
      hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
    ]]
  end
}
