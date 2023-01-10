local function load()
	vim.g.initialized = 1
	vim.api.nvim_exec_autocmds("User", {pattern = "Initialized"})
end

if #vim.v.argv > 1 then
	vim.api.nvim_create_autocmd("VimEnter", {callback = load, once = true})
else
	vim.api.nvim_create_autocmd("User", {
		pattern = "AlphaReady",
		callback = function() vim.defer_fn(load, 10) end,
		once = true,
	})
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "plugins/init.lua",
	callback = function()
		package.loaded.plugins = nil
		require'plugins'.sync()
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "nerdcontrast.lua",
	callback = function()
		package.loaded.nerdcontrast = nil
		require'nerdcontrast'.load()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.*",
	callback = function(state)
		local clients = vim.lsp.get_active_clients({bufnr = state.buf})
		for _, client in ipairs(clients) do
			if client.name ~= "null-ls" and client.config.root_dir ~= nil then
				vim.api.nvim_set_current_dir(client.config.root_dir)
				return
			end
		end
	end,
})

vim.cmd [[
augroup _general_settings
	au!
	au TextYankPost * lua require'vim.highlight'.on_yank{higroup = 'Search', timeout = 40}
	au FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
	au BufEnter *.json5 setlocal ft=json
	au TermOpen * setlocal nonu scrollback=100
augroup end
]]
