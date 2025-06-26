return {
	cmd = {
		vim.fn.expand('$HOME/anaconda3/bin/pylsp'),
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
				ruff = {
					enabled = true,
				},
			}
		}
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
