require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"bash",
		"bibtex",
		"c",
		"cpp",
		"css",
		"html",
		"java",
		"json",
		"latex",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"regex",
		"rust",
		"vim",
		"yaml",
	},
	ignore_install = {"haskell"},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = function(_, buf)
			local ok, bfd = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
			return ok and bfd
		end,
	},
	autotag = {enable = true},
	autopairs = {enable = true},
	indent = {enable = true, disable = {"yaml"}},
}
vim.cmd [[
set fdm=expr fdn=1
set foldexpr=nvim_treesitter#foldexpr()
]]

-- Treesitter Debugging
map("n", "<M-t>", function()
	local res = vim.treesitter.get_captures_at_cursor(0)
	local str = {}
	for _, v in ipairs(res) do
		v = "@" .. v .. "." .. vim.bo.filetype
		table.insert(str, {" " .. v, v})
	end
	vim.api.nvim_echo(str, false, {})
end)
