local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
    },
}

local function get_project_name()
    -- Get the full path to the current working directory
    local cwd = vim.fn.getcwd()
    -- Extract the base name (project directory name)
    return vim.fn.fnamemodify(cwd, ":t")
end

local function run_cmake_command(cmd, detach)
    if detach then
        -- Run the command in a separate tmux window
        vim.fn.system("tmux neww '" .. cmd .. "'")
        print("Command sent to tmux: " .. cmd)
    else
        -- Run the command inside Neovim
        vim.cmd("!" .. cmd)
    end
end

local cmake_menu = function()
    local project_name = get_project_name()
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local conf = require('telescope.config').values

    pickers.new({}, {
        prompt_title = "CMake Menu",
        finder = finders.new_table {
            results = {
                { "Generate Build Files (Debug/Release)",
                    "cmake -S . -B bin/ -G \"Ninja Multi-Config\" -D CMAKE_EXPORT_COMPILE_COMMANDS=ON && ln -sf bin/compile_commands.json compile_commands.json"
                },
                { "Build Debug",
                    "cmake --build bin --config Debug" },
                { "Build Release",
                    "cmake --build bin --config Release" },
                { "Run Release (tmux)",
                    "bin/Release/" .. project_name .. "; echo \"Press <RETURN> to close...\"; read -n 1",
                    true
                },
                { "Debug Debug (tmux)",
                    "lldb bin/Debug/" .. project_name,
                    true
                },
            },
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry[1],
                    ordinal = entry[1],
                    cmd = entry[2],
                    detach = entry[3] or false
                }
            end
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            local execute_command = function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                run_cmake_command(selection.cmd, selection.detach)
            end

            map('i', '<CR>', execute_command)
            map('n', '<CR>', execute_command)

            return true
        end
    }):find()
end

return {
    cmake_menu = cmake_menu
}
