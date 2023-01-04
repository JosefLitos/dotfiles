return {
	cmd = {"typescript-language-server", "--stdio"},
	folding = true,
	filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
	root_dir = require'lspconfig.util'.root_pattern("package.json", "tsconfig.json", "jsconfig.json",
			".git"),
	init_options = {suggestFromUnimportedLibraries = true, closingLabels = true},
}
