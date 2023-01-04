local exec = require'nvim-tree.actions.dispatch'.dispatch
require'nvim-tree'.setup {
	hijack_directories = {enable = false},
	disable_netrw = true,
	respect_buf_cwd = true,
	ignore_ft_on_setup = {"alpha"},
	update_focused_file = {enable = true, update_root = true},
	sync_root_with_cwd = true,
	filters = {dotfiles = true, custom = {".git", "node_modules", ".cache"}},
	renderer = {
		indent_markers = {enable = true},
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {default = "", open = "", empty = "", empty_open = "", symlink = ""},
				git = {unstaged = "", staged = "✓", unmerged = "", renamed = "➜", untracked = ""},
			},
			show = {git = false},
		},
	},
	actions = {open_file = {quit_on_open = true, window_picker = {enable = false}}},
	on_attach = function(bufnr)
		local function map(key, fn) _G.map("n", key, function() exec(fn) end, {buffer = bufnr}) end
		map("h", "dir_up")
		map("<Left>", "dir_up")
		map("l", "edit")
		map("<Right>", "edit")
		map("<CR>", "edit")
		map("<", "prev_sibling")
		map(">", "next_sibling")
		map("-", "close_node")
		map("e", "expand_all")
		map("<M-e>", "collapse_all")
		map("<C-h>", "toggle_dotfiles")
		map("<BS>", "toggle_dotfiles")
		map("<F5>", "refresh")
		map("n", "create")
		map("<Del>", "remove")
		map("D", "remove")
		map("X", "cut")
		map("C", "copy")
		map("V", "paste")
		map("R", "rename")
		map("q", "close")
		map("cd", "cd")
		map("O", "cd")
		map("<S-CR>", "cd")
		_G.map("n", "<M-Tab>", vim.api.nvim_replace_termcodes("<C-w><C-l>", true, true, true),
				{buffer = bufnr})
	end,
	remove_keymaps = true,
}

map("n", "E", "<Cmd>NvimTreeToggle<CR>")
map("n", "<M-Tab>", "<Cmd>NvimTreeFocus<CR>")
