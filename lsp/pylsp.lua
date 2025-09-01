return {
	cmd = {
		vim.fn.expand('$HOME/anaconda3/envs/pylsp-env/bin/pylsp'),
	},
	filetypes = {
		"python",
		"py",
	},
	root_markers = {
		".git",
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".pylintrc",
		".python-version",
	},
	settings = {
		pylsp = {
			plugins = {
				jedi_definition = {
					enabled = true,
					follow_imports = true,
					follow_builtin_imports = true,
				},
				jedi_hover = {
					enabled = true,
				},
				jedi_references = {
					enabled = true,
				},
				jedi_signature_help = {
					enabled = true,
				},
				jedi_symbols = {
					enabled = true,
					all_scopes = true,
				},
				-- Code formatting and linting
				ruff = {
					enabled = true,
				},
				-- Disable conflicting plugins if using ruff
				pycodestyle = {
					enabled = false,
				},
				pyflakes = {
					enabled = false,
				},
				mccabe = {
					enabled = false,
				},
				pylint = {
					enabled = false,
				},
			}
		}
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	on_attach = function(client, bufnr)
		-- LSP keymaps
		local opts = { buffer = bufnr, silent = true }
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	end,
}
