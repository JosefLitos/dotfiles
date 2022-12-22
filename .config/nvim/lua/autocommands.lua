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
	pattern = "plugins.lua",
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

-- vim.api.nvim_create_autocmd({"BufFilePost"}, {
-- 	pattern = "*conf*",
-- 	callback = function(data) vim.api.nvim_buf_set_option(data.buf, "filetype", "config") end,
-- })

vim.cmd [[
augroup _general_settings
	au!
	au TextYankPost * lua require'vim.highlight'.on_yank{higroup = 'Search', timeout = 40}
	au FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
	au BufRead *.json5 setlocal ft=json
augroup end
]]
