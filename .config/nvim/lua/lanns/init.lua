require("lanns.remap")
require("lanns.set")

require("plugins")

local augroup = vim.api.nvim_create_augroup
local LannsGroup = augroup('Lanns', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
	require("plenary.reload").reload_module(name)
end

-- Clear trailing whitespace
autocmd({"BufWritePre"}, {
    group = LannsGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
    group = LannsGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

autocmd("FileType", {
  callback = function(ev)
    local buf = ev.buf
    local ft = ev.match

    -- 1. real file buffers only
    if vim.bo[buf].buftype ~= "" then
      return
    end

    -- 2. must map to a TS language
    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then
      return
    end

    -- 3. optional hard excludes
    local excluded = {
      netrw = true,
      help = true,
      lazy = true,
      mason = true,
    }
    if excluded[ft] then
      return
    end

    if vim.api.nvim_buf_line_count(buf) > 50000 then
      return
    end

    if vim.bo[buf].binary then
      return
    end

    -- 4. start or install
    local ok = pcall(vim.treesitter.start, buf, lang)
    if ok then
      return
    end

    coroutine.wrap(function()
      require("nvim-treesitter").install({ lang }):wait(300000)
      vim.schedule(function()
        pcall(vim.treesitter.start, buf, lang)
      end)
    end)()
  end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
