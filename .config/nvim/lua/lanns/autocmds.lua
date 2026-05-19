local augroup = vim.api.nvim_create_augroup
local LannsGroup = augroup("Lanns", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

-- Clear trailing whitespace
autocmd({ "BufWritePre" }, {
	group = LannsGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = LannsGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({count=1, float=true})
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({count=-1, float=true})
		end, opts)
	end,
})

local ignored_filetypes = {
	netrw = true,
	qf = true, -- Quickfix window
	help = true, -- Built-in help docs
	man = true, -- Man pages
	lspinfo = true, -- LSP info floating window
	checkhealth = true, -- Health check buffers
    fidget = true, -- Fidget notis
	-- Add any others you encounter here, like 'NvimTree', 'TelescopePrompt', etc.
}

autocmd("FileType", {
	group = LannsGroup,
	pattern = "*", -- Runs on all filetypes
	callback = function(args)
		if ignored_filetypes[args.match] then
			return
		end

		-- 1. Get the proper treesitter language name for the current filetype
		-- (e.g., filetype 'typescriptreact' maps to lang 'tsx')
		local lang = vim.treesitter.language.get_lang(args.match) or args.match

		-- 2. Check if the parser file exists in runtimepath and can be loaded
		if not vim.treesitter.language.add(lang) then
			require("nvim-treesitter").install({ lang })
			return
		end

		-- 3. Safely attempt to start treesitter highlighting/parsing
		-- pcall prevents Neovim from throwing a blocking stack trace if queries are missing
		local success, _ = pcall(vim.treesitter.start, args.buf, lang)

		if success then
			-- Treesitter is installed and successfully active on this buffer!
			-- You can execute custom logic here (like disabling standard regex syntax)
		else
			-- Parser exists, but active parsing failed (e.g., corrupted queries)
		end
	end,
})
