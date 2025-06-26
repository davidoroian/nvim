return {
    "nosduco/remote-sshfs.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config  = function()
        require('remote-sshfs').setup{
            connections = {
                ssh_configs = { -- which ssh configs to parse for hosts list
                    vim.fn.expand "$HOME" .. "/.ssh/config",
                    "/etc/ssh/ssh_config",
                    -- "/path/to/custom/ssh_config"
                },
                -- NOTE: Can define ssh_configs similarly to include all configs in a folder
                -- ssh_configs = vim.split(vim.fn.globpath(vim.fn.expand "$HOME" .. "/.ssh/configs", "*"), "\n")
                sshfs_args = { -- arguments to pass to the sshfs command
                    "-o reconnect",
                    "-o ConnectTimeout=5",
                    "-o ServerAliveInterval=15",
                    "-o ServerAliveCountMax=3",
                },
            },
            mounts = {
                base_dir = vim.env.HOME .. "/.sshfs/", -- base directory for mount points
                unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
            },
            handlers = {
                on_connect = {
                    change_dir = true, -- when connected change vim working directory to mount point
                },
                on_disconnect = {
                    clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
                },
                on_edit = {}, -- not yet implemented
            },
            ui = {
                select_prompts = false, -- not yet implemented
                confirm = {
                    connect = true, -- prompt y/n when host is selected to connect to
                    change_dir = false, -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
                },
            },
            log = {
                enabled = false, -- enable logging
                truncate = false, -- truncate logs
                types = { -- enabled log types
                    all = false,
                    util = false,
                    handler = false,
                    sshfs = false,
                },
            },
        }
        local api = require('remote-sshfs.api')
        local function refresh_netrw()
            local connections = require('remote-sshfs.connections')

            if connections.is_connected() then
                -- Force refresh netrw by reopening current directory
                vim.cmd('edit .')
                print("✓ Refreshed netrw for remote directory: " .. vim.fn.getcwd())
            end
        end

        -- Enhanced connect function for netrw
        local function connect_and_refresh_netrw()
            api.connect()

            -- Wait for connection, then refresh netrw
            vim.defer_fn(function()
                refresh_netrw()
            end, 5000)
        end

        -- Keymaps
        vim.keymap.set('n', '<leader>rc', connect_and_refresh_netrw, { desc = "Connect and refresh netrw" })
        vim.keymap.set('n', '<leader>rd', api.disconnect, {})
        vim.keymap.set('n', '<leader>rr', refresh_netrw, { desc = "Refresh netrw" })
        vim.keymap.set('n', '<leader>re', api.edit, {})
    end,
}
