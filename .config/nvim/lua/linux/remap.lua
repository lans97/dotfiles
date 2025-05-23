
vim.keymap.set("n", "<leader>gs", "<cmd>silent !tmux neww lazygit<CR>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux popup -E tms<CR>")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })