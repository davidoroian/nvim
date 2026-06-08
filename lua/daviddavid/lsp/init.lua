local common = require("daviddavid.lsp.common")

local M = {}

-- LSP servers managed by mason-lspconfig.
M.ensure_servers = {
  "lua_ls",
  "bashls",
  "jsonls",
  "yamlls",
  "pyright",
  "clangd",
  "marksman",
}

-- Non-LSP tools (formatters, linters, DAPs). mason-lspconfig only knows
-- about LSPs, so these go through mason-registry directly.
M.ensure_tools = {
  "stylua",
}

local function ensure_mason_tools(tools)
  local ok, registry = pcall(require, "mason-registry")
  if not ok then return end
  registry.refresh(function()
    for _, name in ipairs(tools) do
      local ok_pkg, pkg = pcall(registry.get_package, name)
      if ok_pkg and not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end

function M.setup()
  common.setup_ui()

  -- Mason core.
  require("mason").setup()

  -- Global defaults applied to every LSP server via the '*' wildcard.
  -- These get merged with nvim-lspconfig's per-server lsp/*.lua and
  -- any per-server overrides we define below.
  vim.lsp.config("*", common.server_defaults())

  -- Per-server overrides from daviddavid.lsp.servers.<name>.
  -- Optional — a server file just needs to `return { settings = {...} }`.
  for _, name in ipairs(M.ensure_servers) do
    local ok, custom = pcall(require, "daviddavid.lsp.servers." .. name)
    if ok then
      vim.lsp.config(name, custom)
    end
  end

  -- mason-lspconfig v2: ensure_installed handles installation,
  -- automatic_enable (default true) calls vim.lsp.enable() for each.
  -- No more `handlers`, no more `automatic_installation`.
  require("mason-lspconfig").setup({
    ensure_installed = M.ensure_servers,
    automatic_enable = true,
  })

  -- Install formatters/linters separately.
  ensure_mason_tools(M.ensure_tools)
end

return M
