return {
  "stevearc/conform.nvim",
  opts = {
    -- Map filetypes to one or more formatters
    formatters_by_ft = {
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },

      json = { "prettierd" },
      jsonc = { "prettierd" },

      -- add more as you like:
      css = { "prettierd" },
      html = { "prettierd" },
      markdown = { "prettierd" },
      yaml = { "prettierd" },
    },

    -- Optional: format on save
    format_on_save = {
      timeout_ms = 2000,
      lsp_fallback = true, -- if no formatter configured, try LSP
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    -- Manual format keymap
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      require("conform").format({ lsp_fallback = true, timeout_ms = 2000 })
    end, { desc = "Format" })
  end,
}
