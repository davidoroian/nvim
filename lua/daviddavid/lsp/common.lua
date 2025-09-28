local M = {}

-- Ensure only apply UI once even if required multiple times
local _ui_applied = false
local _attach_autocmd_set = false

function M.setup_ui()
  if _ui_applied then return end
  _ui_applied = true

  vim.diagnostic.config({
    virtual_text = {
      spacing = 2,
      prefix = "●",
      severity = { min = vim.diagnostic.severity.HINT },
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "if_many",
      header = "",
      prefix = "",
    },
  })
  -- Ensure our on_attach runs for every LSP client/buffer
  if not _attach_autocmd_set then
    _attach_autocmd_set = true
    local group = vim.api.nvim_create_augroup("daviddavid_lsp_common_attach", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- Reuse the shared on_attach for all LSP clients (Mason, Metals, etc.)
        require("daviddavid.lsp.common").on_attach(client, bufnr)
      end,
    })
  end
end

function M.capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  return caps
end

-- Keymaps and buffer-local behavior for all LSPs
function M.on_attach(client, bufnr)
  local function nmap(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
  end

  nmap("gd", vim.lsp.buf.definition, "LSP: Goto Definition")
  nmap("gD", vim.lsp.buf.declaration, "LSP: Goto Declaration")
  nmap("gr", vim.lsp.buf.references, "LSP: References")
  nmap("gi", vim.lsp.buf.implementation, "LSP: Implementation")
  nmap("K", vim.lsp.buf.hover, "LSP: Hover")
  nmap("<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")

  local ok_tb, tb = pcall(require, "telescope.builtin")
  if ok_tb then
    nmap("<leader>ds", tb.lsp_document_symbols, "LSP: Document Symbols")
    nmap("<leader>ws", tb.lsp_dynamic_workspace_symbols, "LSP: Workspace Symbols")
  end

  nmap("<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "Format buffer")
end

-- Returns fresh defaults table
function M.server_defaults()
  return {
    capabilities = M.capabilities(),
  }
end

-- Helper: merge defaults (and optional extras) into a server config table
function M.apply_to_config(cfg, extra)
  local merged = vim.tbl_deep_extend("force", M.server_defaults(), cfg or {})
  if extra then
    merged = vim.tbl_deep_extend("force", merged, extra)
  end
  return merged
end

return M
