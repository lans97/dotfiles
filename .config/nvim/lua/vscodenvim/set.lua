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
vscode_module.update_config("editor.tabSize", 4, 1)
vscode_module.update_config("editor.insertSpaces", true, 1)
vscode_module.update_config("editor.detectIndentation", false, 1)

-- 2. Numbers & Rulers
vscode_module.update_config("editor.lineNumbers", "relative", 1)
vscode_module.update_config("editor.rulers", { 81 }, 1)

-- 3. Screen layout/Wrapping
vscode_module.update_config("editor.wordWrap", "off", 1)

-- 4. Search Behavior (Match your incsearch/hlsearch logic)
vscode_module.update_config("editor.find.seedSearchStringFromSelection", "never", 1)
