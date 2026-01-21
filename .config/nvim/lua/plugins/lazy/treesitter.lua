return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require'nvim-treesitter'.setup {
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath('data') .. '/site'
        }
        require('nvim-treesitter').install({ 'lua', 'javascript', 'python' }):wait(300000) -- wait max. 5 minutes
    end
}
