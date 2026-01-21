if vim.g.vscode then
    require("vscodenvim")
else
    require("lanns")

    if vim.loop.os_uname().sysname == "Windows_NT" then
        require("windows")
    else
        require("linux")
    end

    ColorMyPencils()
end
