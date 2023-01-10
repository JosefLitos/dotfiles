require'neodev'.setup {setup_jsonls = false, lspconfig = false}

if package.loaded.lsp then
	package.loaded.lsp "sumneko_lua"
else
	vim.api.nvim_create_autocmd("User", {
		pattern = "LspInit",
		once = true,
		callback = function(state) state.data "sumneko_lua" end,
	})
end
