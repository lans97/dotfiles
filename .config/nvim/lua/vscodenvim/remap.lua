vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-------------------------------------------------------------------------------
-- ENVIRONMENT SETUP & ALIASES
-------------------------------------------------------------------------------
local vscode = nil

local vscode_module = require("vscode")
-- Short alias to invoke native VS Code commands directly
vscode = function(action)
	vscode_module.call(action)
end

-------------------------------------------------------------------------------
-- SHARED KEYMAPS (Works identically in both Terminal Neovim & VS Code)
-------------------------------------------------------------------------------
-- Move visual blocks smoothly
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor static/centered during movements
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over visual selection without losing current register copy
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Escape insert mode with Ctrl+C
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Global search and replace blueprint for word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Go error snippet generation
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-------------------------------------------------------------------------------
-- CONDITIONAL OVERRIDES (VS Code vs. Terminal Neovim equivalents)
-------------------------------------------------------------------------------
-- File Tree Explorer
vim.keymap.set("n", "<leader>pv", function()
	vscode("workbench.files.action.focusFilesExplorer")
end)

-- Code Formatting
vim.keymap.set("n", "<leader>f", function()
	vscode("editor.action.formatDocument")
end)

-- Tab Traversal (Native editor groups instead of buffers)
vim.keymap.set("n", "]b", function()
	vscode("workbench.action.nextEditorInGroup")
end)
vim.keymap.set("n", "[b", function()
	vscode("workbench.action.previousEditorInGroup")
end)
vim.keymap.set("n", "<leader>bd", function()
	vscode("workbench.action.closeActiveEditor")
end)

-- Native Window Layout Navigation using original <C-w> prefixes
vim.keymap.set("n", "<C-w>h", function()
	vscode("workbench.action.navigateLeft")
end)
vim.keymap.set("n", "<C-w>j", function()
	vscode("workbench.action.navigateDown")
end)
vim.keymap.set("n", "<C-w>k", function()
	vscode("workbench.action.navigateUp")
end)
vim.keymap.set("n", "<C-w>l", function()
	vscode("workbench.action.navigateRight")
end)
vim.keymap.set("n", "<C-w>v", function()
	vscode("workbench.action.splitEditorRight")
end)
vim.keymap.set("n", "<C-w>s", function()
	vscode("workbench.action.splitEditorDown")
end)
vim.keymap.set("n", "<C-w>q", function()
	vscode("workbench.action.closeActiveEditor")
end)

-- Fuzzy File Search (Your alternative to Telescope)
vim.keymap.set("n", "<leader>pf", function()
	vscode("workbench.action.quickOpen")
end)

-- Native Code Actions
vim.keymap.set({ "n", "v" }, "<leader>ca", function()
	vscode("editor.action.quickFix")
end)
