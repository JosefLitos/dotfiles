map({ 'n', 'i' }, '<A-b>', '<Cmd>w|cd %:h|term compiler %:p<CR>', { buffer = true })
map({ 'n', 'i' }, '<A-r>', '<Cmd>w|make||!compiler %:p<CR><CR>', { buffer = true })
map({ 'n', 'i' }, '<C-s>', "<Cmd>w|!rm '%:r'.o '%:r'.out<CR><CR>", { buffer = true })
map(
	{ 'n', 'i' },
	'<A-B>',
	"<C-s><Cmd>!make debug||gcc -Wall -pedantic -g -fsanitize=address,leak,undefined -DDEBUG '%:p' -o '%:r'.out<CR>",
	{ buffer = true, remap = true }
)
map({ 'n', 'i' }, '<A-T>', "<C-s><Cmd>!cd '%:h' && make test<CR>", { buffer = true, remap = true })
map({ 'n', 'i' }, '<A-M>', "<Cmd>w|!cd '%:h' && make all<CR>", { buffer = true })

map({ 'n', 'i' }, '<A-R>', function()
	local name = vim.api.nvim_buf_get_name(0)
	local out = name:gsub('%.c$', '.out')
	if not exists(out) then vim.fn.glob(name:gsub('/[^/]*$', '/*.out')) end
	if not exists(out) then return vim.notify 'No executable found' end
	vim.cmd.term(out)
end, { buffer = true })

if vim.g.loaded then
	if vim.g.loaded['c'] then return end
	vim.g.loaded['c'] = true
end
vim.g.loaded = { ['c'] = true }

withMod('dap', function(dap)
	dap.configurations.c = {
		{
			name = 'Launch',
			type = 'codelldb',
			request = 'launch',
			cwd = '${workspaceFolder}',
			program = function()
				if exists 'main.out' then return 'main.out' end
				local name = vim.api.nvim_buf_get_name(0)
				return name:gsub('%.c$', '.out')
				-- LSAN_OPTIONS=verbosity=1:log_threads=1 gdb...
			end,
		},
	}
	dap.configurations.cpp = dap.configurations.c
end)

withMod('mylsp', function(ml)
	ml.setup 'clangd'
	vim.cmd.LspStart 'clangd'
end)
