# Never use VSCode again NeoVim setup

This is my NeoVim config

## Installation

Copy this repository in whatever method you want in your `~/.config/` directory 

## Requirements

- NeoVim `>= 0.11` 

Optional if desired:
- C/C++ LSP [clangd](https://clangd.llvm.org/installation.html)
- Lua LSP [lua-language-server](https://github.com/LuaLS/lua-language-server)
- Markdown LSP [marksman](https://github.com/artempyanykh/marksman)
- Python LSP [python-language-server](https://github.com/python-lsp/python-lsp-server) - make sure to configure the `cmd` from `lsp/pylsp.lua` where you actually have the command available (venv recommended)
    - for the python LSP the go to definition does not seem to work perfectly at the moment
## Basic functionality:

For the above mentioned lsps, the configuration is available in `lsp/<lsp_name>.lua`. For `[Metals](https://scalameta.org/metals/)`(Scala LSP) it is available in `lua/daviddavid/lazy/nvim-metals.lua`

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
- `gD`          - go to definition of the class/function under the cursor
- `gr`          - see references of the word under cursor
- `K`           - hover over word under cursor 
- `gi`          - see implementation of word under cursor (not sure what exactly it is supposed to do, but feel free to find out)


