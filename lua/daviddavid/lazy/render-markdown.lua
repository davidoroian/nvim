return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig

    config = function()
        require('render-markdown').setup({
            completions = { lsp = { enabled = true } },
            render_modes = { 'n', 'c', 't' },
        })
    end,
}
