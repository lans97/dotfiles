return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("neo-tree").setup({
                window = {
                    position = "right",
                    width = 30,
                },
            })

            local function find_neotree_win_in_tab()
                local tab = vim.api.nvim_get_current_tabpage()
                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    if vim.bo[buf].filetype == "neo-tree" then
                        return win
                    end
                end
            end

            local function neotree_smart_toggle_last()
                local neotree_win = find_neotree_win_in_tab()
                local cur_win = vim.api.nvim_get_current_win()

                if neotree_win then
                    if neotree_win == cur_win then
                        -- Neo-tree is focused → close it (don’t “toggle”, just close the window)
                        vim.api.nvim_win_close(neotree_win, true)
                    else
                        -- Neo-tree is open but not focused → focus it (do NOT close)
                        vim.api.nvim_set_current_win(neotree_win)
                    end
                    return
                end

                -- No Neo-tree window open → open the last source and focus it
                require("neo-tree.command").execute({
                    action = "focus",
                    source = "last",
                })
            end

            vim.keymap.set("n", "<leader>pv", neotree_smart_toggle_last, {
                desc = "Toggle Neo-tree (last source)"
            })
        end
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { "neo-tree", "neo-tree-popup", "notify" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { "terminal", "quickfix" },
                    },
                },
            })
        end,
    },
}
