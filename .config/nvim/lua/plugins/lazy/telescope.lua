return {
    "nvim-telescope/telescope.nvim", version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- optional but recommended
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },

    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope git files" })
        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Telescope grep word"})
        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Telescope grep WORD"})
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "Telescope grep input"})
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Telescope help tags"})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    end
}
