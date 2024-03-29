local M = {
	'SmiteshP/nvim-navbuddy',
	dependencies = { 'SmiteshP/nvim-navic', 'MunifTanjim/nui.nvim' },
	keys = '<A-t>',
}
function M.config()
	local nb = require 'nvim-navbuddy'
	local act = require 'nvim-navbuddy.actions'
	nb.setup {
		icons = {
			File = '󰈔 ',
			Module = '󰅩 ',
			Namespace = '󰅩 ',
			Package = '󰅩 ',
			Class = ' ',
			Method = '󰆧 ',
			Property = ' ',
			Field = ' ',
			Constructor = ' ',
			Enum = ' ',
			Interface = ' ',
			Function = '󰊕 ',
			Variable = ' ',
			Constant = '󰏿 ',
			String = '󰉾 ',
			Number = '󰎠 ',
			Boolean = '◩ ',
			Array = '󰅪 ',
			Object = '󰅩 ',
			Key = ' ',
			Null = '󰟢 ',
			EnumMember = ' ',
			Struct = ' ',
			Event = ' ',
			Operator = ' ',
			TypeParameter = ' ',
			Macro = ' ',
		},
		lsp = { auto_attach = true },
		mappings = {
			['<Left>'] = act.parent(),
			['<Right>'] = act.children(),
		},
		source_buffer = {
			reorient = 'none', --[[ follow_node = false ]]
		},
	}
	map('n', '<A-t>', nb.open)
	map('i', '<A-t>', '<Esc><A-t>', { remap = true })
end
return M
