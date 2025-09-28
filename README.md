# Never use VSCode again NeoVim setup

This is my NeoVim config

## Installation

Copy this repository in whatever method you want in your `~/.config/` directory 

## Requirements

- NeoVim `>= 0.11` 

## Basic functionality:

In the `lua/daviddavid/lazy/` directory are all the configurations for the plugins which get installed once you start neovim using [Lazy](https://github.com/folke/lazy.nvim) 

For understanding plugin configruration check out the files in the above mentioned directory and if you want more info about them look them up on [Github](https://github.com/)

### But here are some basic useful commands:

- The `<leader>` I have set up is a `spacebar` press, you can change it by modifying [this](https://github.com/davidoroian/nvim/blob/master/lua/daviddavid/remap.lua) file

#### Remote connection

- `<leader>rc` - connect to remote directory (you might need to make sure you have a password prompter installed in order for this to work)
- `<leader>rr` - for refreshing the current directory once you have connected to the host
- `<leader>rd` - for disconnecting from the host (currently this gives an error but does the job)

#### Other useful ones

For comments, surround, git, pairs and many others (if you want to add any) checkout [mini.nvim](https://github.com/echasnovski/mini.nvim?tab=readme-ov-file)

- `gcc`         - comment line of code
- `<leader>pf`  - fuzzy search for file
- `<leader>ps`  - search for files containing phrase
- `ctr+a`       - add file to telescope
- `ctr+e`       - see telescope files
- `ctr+h/t/n/s` - move to telescoped files with index `1/2/3/4`
- `saiw(`       - surround current word with `()`
- `sd(`         - remove `()` surround
- `gd`          - go to definition of the class/function under the cursor
- `gD`          - go to declaration of the class/function under the cursor
- `gr`          - see references of the word under cursor
- `K`           - hover over word under cursor 
- `gi`          - see implementation of word under cursor (not sure what exactly it is supposed to do, but feel free to find out)

## LSPs

This configuration uses [mason](https://github.com/mason-org/mason.nvim) for managing most of the LSPs, except for Metals, which is its own extension.

The mason configuration is found in `lua/daviddavid/lsp/init.lua`. Here you can tell mason which LSPsi, DAPs, Linters or Formatters 
to install by modifying the `ensure_servers` table.

`lua/daviddavid/lsp/common.lua` is a file which is used in both the mason LSPs configurations as well as the metals one, in order to ensure both of them 
have similar functionality with the code existing only in one place. Here the `setup_ui` function configs `vim.diagnostics` and makes sure the `on_attach`
function is called for each LSP. 

For `[Metals](https://scalameta.org/metals/)`(Scala LSP) the config is available in `lua/daviddavid/lazy/nvim-metals.lua`
