vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

local vscode_module = require("vscode")

-- 1. Tab & Indentation Rules
vscode_module.update_config("editor.tabSize", 4, "global")
vscode_module.update_config("editor.insertSpaces", true, "global")
vscode_module.update_config("editor.detectIndentation", false, "global")

-- 2. Numbers & Rulers
vscode_module.update_config("editor.lineNumbers", "relative", "global")
vscode_module.update_config("editor.rulers", 81, "global")

-- 3. Screen layout/Wrapping
vscode_module.update_config("editor.wordWrap", "off", "global")

-- 4. Search Behavior (Match your incsearch/hlsearch logic)
vscode_module.update_config("editor.find.seedSearchStringFromSelection", "never", "global")
