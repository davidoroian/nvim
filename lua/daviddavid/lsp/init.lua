local common = require("daviddavid.lsp.common")

local M = {}

-- Add more servers as needed; mason-lspconfig will install them automatically.
M.ensure_servers = {
  -- LSPs
  "lua_ls",
  "bashls",
  "jsonls",
  "yamlls",
  "pyright",
  "clangd",
  "marksman",
  -- Formatters
  "stylua",
}

function M.setup()
  common.setup_ui()

  local lspconfig = require("lspconfig")

  -- Setup Mason core UI/registry
  local ok_mason, mason = pcall(require, "mason")
  if ok_mason then
    mason.setup()
  end

  -- Setup Mason-LSP bridge and register handlers
  local ok_mlsp, mason_lspconfig = pcall(require, "mason-lspconfig")
  if ok_mlsp then
    mason_lspconfig.setup({
      -- Default handler for any installed server
      ensure_installed = M.ensure_servers,
      automatic_installation = true,
      handlers = {
        function(server_name)
          local opts = common.server_defaults()
          local ok_custom, custom = pcall(require, "daviddavid.lsp.servers." .. server_name)
          if ok_custom then
            opts = vim.tbl_deep_extend("force", opts, custom)
          end
          lspconfig[server_name].setup(opts)
        end,
      }
    })
  end
end

return M
