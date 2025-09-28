vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- all workspace diagnostics
vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
vim.keymap.set("n", "<leader>ae", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end)

-- all workspace warnings
vim.keymap.set("n", "<leader>aw", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
end)
