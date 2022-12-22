local colors = require'nerdcontrast'.colors
local mode_color = {
	n = "Contrast",
	i = "Highlight",
	v = "Yellow",
	[''] = "Yellow",
	V = "Yellow",
	c = "LightBlue",
	t = "Red",
	no = "LightContrast",
	s = "LightCyan",
	S = "LightCyan",
	[''] = "LightCyan",
	ic = "Cyan",
	R = "Orange",
	Rv = "Orange",
}
local config = {
	force_inactive = {filetypes = {"^NvimTree", "^dap.*", "^packer", "^alpha", "^help", "^rnvimr"}},
	components = {
		active = {
			{
				{
					provider = '▊',
					update = {"ModeChanged"},
					hl = function() return {fg = colors[mode_color[vim.fn.mode()]][1]} end,
				},
				{
					provider = {name = "file_type", opts = {filetype_icon = true}},
					enabled = function() return vim.bo.filetype ~= "" end,
					update = {"FileType"},
					left_sep = ' ',
					right_sep = ' ',
				},
			},
			{
				{
					provider = "lsp_client_names",
					truncate_hide = true,
					icon = " ",
					update = {"FileType"},
					hl = {fg = colors["Grey2"][1]},
				},
			},
			{
				{provider = "diagnostic_errors", icon = " ", hl = {fg = colors["Red"][1]}, right_sep = ' '},
				{provider = "diagnostic_warnings", icon = " ", hl = {fg = colors["Orange"][1]}, right_sep = ' '},
				{provider = "diagnostic_hints", icon = " ", hl = {fg = colors["Yellow"][1]}, right_sep = ' '},
				{provider = "diagnostic_info", icon = " ", hl = {fg = colors["LightOlive"][1]}, right_sep = ' '},
				{
					provider = function()
						return vim.fn.line('.') .. ':' .. vim.fn.virtcol('.') .. '/' .. vim.fn.line('$')
					end,
					right_sep = ' ',
					hl = {fg = colors["Green"][1]},
				},
				{
					provider = function()
						local now = vim.fn.line('.')
						local sum = vim.fn.line('$')
						if now == 1 then
							return "Top"
						elseif now == sum then
							return "Bot"
						else
							return math.modf((now / sum) * 100) .. "%%"
						end
					end,
					right_sep = ' ',
					hl = {fg = colors["Cyan"][1]},
				},
			},
		},
		inactive = {
			{},
			{{provider = {name = "file_type", opts = {filetype_icon = true}}, update = {"FileType"}}},
			{},
		},
	},
}

--[[ function _G.navic()
	config.components.active[1][3] = {
		provider = require'nvim-navic'.get_location,
		enabled = require'nvim-navic'.is_available,
		hl = {fg = colors["Cyan"][1]}
	}
	require'feline'.setup(config)
	_G.navic = nil
end ]]

require'feline'.setup(config)
