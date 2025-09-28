return {
    'echasnovski/mini.nvim',
    version = "*",
    config = function()
        require('mini.pairs').setup()
        require('mini.surround').setup()
        require('mini.comment').setup()
        require('mini.git').setup()
        require('mini.icons').setup()
        require('mini.snippets').setup()
        require('mini.completion').setup()
    end
}
