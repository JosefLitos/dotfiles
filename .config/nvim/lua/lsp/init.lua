vim.diagnostic.config {
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {focusable = false, border = "rounded", source = "always"},
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})

local capabilities = require'cmp_nvim_lsp'.default_capabilities()
local lsc = require "lspconfig"
local function setup(server, opts)
	if not opts then opts = require("lsp." .. server) end
	if not opts.capabilities then
		opts.capabilities = capabilities
	else
		opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, capabilities)
	end
	local on_attach = opts.on_attach
	opts.on_attach = function(client, bufnr)
		if vim.api.nvim_buf_get_option(bufnr, "bufhidden") ~= "" or
				(on_attach and on_attach(client, bufnr) == false) then
			vim.schedule(function() vim.lsp.buf_detach_client(bufnr, client.id) end)
			return
		end
		if on_attach then on_attach(client, bufnr) end
		if opts.folding then require'folding'.on_attach() end
		client.server_capabilities.documentFormattingProvider = (opts.settings and
				                                                        opts.settings.documentFormatting)
		vim.bo.formatoptions = "tcqjl1"
		vim.wo.signcolumn = "number"
		if client.config.root_dir ~= nil then vim.api.nvim_set_current_dir(client.config.root_dir) end
	end
	lsc[server].setup(opts)
end

vim.fn.sign_define("DiagnosticSignError",
		{texthl = "DiagnosticError", text = "", numhl = "DiagnosticError"})
vim.fn.sign_define("DiagnosticSignWarn",
		{texthl = "DiagnosticWarn", text = "", numhl = "DiagnosticWarn"})
vim.fn.sign_define("DiagnosticSignHint",
		{texthl = "DiagnosticHint", text = "", numhl = "DiagnosticHint"})
vim.fn.sign_define("DiagnosticSignInfo",
		{texthl = "DiagnosticInfo", text = "", numhl = "DiagnosticInfo"})

setup("bashls", {})
setup("clangd", {capabilities = {offsetEncoding = 'utf-16'}})
-- require "lsp.js-ts"
setup("pyright", {})
setup("rust_analyzer", {settings = {documentFormatting = true}})
setup "texlab"
-- setup("cssls", {cmd = {"vscode-css-language-server", "--stdio"}})
-- setup("html",
-- {cmd = {"vscode-html-language-server", "--stdio"}, settings = {documentFormatting = true}})
-- setup "jsonls"
-- setup("yamlls", {})

-- Lsp diagnostic
map({"n", "i"}, "<M-d>", vim.diagnostic.open_float)
map({"n", "i"}, "<M-N>", vim.diagnostic.goto_prev)
map({"n", "i"}, "<M-n>", vim.diagnostic.goto_next)
-- Lsp code helpers
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gr", vim.lsp.buf.references)
map("n", "gi", vim.lsp.buf.implementation)
map({"n", "i"}, "<M-i>", vim.lsp.buf.hover)
map({"n", "i"}, "<M-h>", vim.lsp.buf.document_highlight)
map({"n", "i"}, "<M-H>", vim.lsp.buf.clear_references)
map("n", "ca", vim.lsp.buf.code_action)
map("i", "<M-c>", vim.lsp.buf.code_action)
map({"n", "i"}, "<C-r>", vim.lsp.buf.rename)
map({"n", "i"}, "<F2>", vim.lsp.buf.rename)

map({"n", "i"}, "<M-g>", function()
	for _, s in ipairs(vim.lsp.get_active_clients({bufnr = 0})) do
		if s.server_capabilities.definitionProvider and s.name ~= "bashls" then
			vim.lsp.buf.definition()
			return
		end
	end
	local cur = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local cwd = vim.loop.cwd()
	vim.loop.chdir(vim.api.nvim_buf_get_name(0):gsub("[^/]*$", ""))
	local path = line:sub(0, cur):gsub("^.*[^a-zA-Z0-9/.~_-]", "") ..
			             line:sub(cur + 1, -1):gsub("[^a-zA-Z0-9/.~_-].*$", "")
	vim.cmd('e ' .. path:gsub('~', os.getenv('HOME')))
	vim.loop.chdir(cwd)
end)

map({"n", "i"}, "<M-F>", function()
	vim.lsp.buf.format({
		tabSize = vim.bo.tabstop,
		insertSpaces = vim.bo.expandtab,
		trimTrailingWhitespace = true,
		insertFinalNewline = false,
		async = true,
	})
end)

require "ui"

return setup
