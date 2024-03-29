-- Text management
map({ '', 'i' }, '<C-s>', '<Cmd>w<CR>')
map({ 'n', 'i' }, '<A-S-Up>', '<Cmd>m-2<CR>')
map({ 'n', 'i' }, '<A-K>', '<Cmd>m-2<CR>')
map({ 'n', 'i' }, '<A-S-Down>', '<Cmd>m+<CR>')
map({ 'n', 'i' }, '<A-J>', '<Cmd>m+<CR>')
map('n', '<C-S-Up>', 'md"dY"dp`d')
map('n', '<C-S-k>', 'md"dY"dp`d')
map('i', '<C-S-Up>', '<C-c>md"dY"dp`da')
map('i', '<C-S-k>', '<C-c>md"dY"dp`da')
map('n', '<C-S-Down>', 'md"dY"dP`d')
map('n', '<C-S-j>', 'md"dY"dP`d')
map('i', '<C-S-Down>', '<C-c>md"dY"dP`da')
map('i', '<C-S-j>', '<C-c>md"dY"dP`da')
map('n', '<C-a>', 'ggVG')
map('i', '<C-a>', '<C-o>gg<C-o>VG')
map({ 'n', 'i' }, '<C-S-A>', '<C-c>mdggVGy`da')
map('i', '<C-u>', '<C-v>u')
map('i', '<C-S-U>', '<C-v>U')
map('i', '<S-Enter>', '<C-o>o')
map('i', '<C-Enter>', '<C-o>O')
map('i', '<A-Enter>', '<C-o>md<C-o>O<C-o>`d')
map('i', '<A-S-Enter>', '<C-o><C-o>mdo<C-o>`d')
map('c', '<C-/>', function() vim.api.nvim_feedkeys(vim.fn.getreg('/', 1), 'n', false) end)
-- Clipboard management
map('n', '<C-x>', 'dd')
map('x', '<C-x>', 'd')
map('i', '<C-x>', '<C-o>dd')
map('n', '<C-c>', 'Y', { silent = true })
map('x', '<C-c>', 'y', { silent = true })
map('i', '<C-c>', '<C-o>Y', { silent = true })
map('i', '<C-v>', '<C-c>pa')
map('i', '<A-V>', '<C-r>"')
map('i', '<C-S-V>', '<C-o>gP')
map('n', '<C-v>', 'p')
map('v', '<C-v>', '"ddP')
map('', 'c', '"dc')
-- Deleting text
map('n', '<C-d>', '"ddd')
map('i', '<C-d>', '<C-o>"ddd')
map({ 'i', 'c' }, '<C-BS>', '<C-w>')
local function delExtended(keybind)
	return function()
		vim.bo.isk = vim.bo.isk .. ',.,*'
		vim.api.nvim_feedkeys(vim.keycode(keybind), 'n', false)
		vim.schedule(function() vim.bo.isk = vim.bo.isk:gsub(',%.,%*$', '') end)
	end
end
map('i', '<A-BS>', delExtended '<C-w>')
map('i', '<C-S-BS>', '<C-o>"ddB')
map('i', '<C-Del>', '<C-o>"ddw')
map('i', '<A-Del>', delExtended '<C-o>"ddw')
map('i', '<C-S-Del>', '<C-o>"ddE')
map('', '<Del>', '"_x')
-- -- inc/dec
-- map('n', '<A-a>', '<C-a>')
-- map('i', '<A-a>', '<C-o><C-a>')
-- map('n', '<A-A>', '<C-x>')
-- map('i', '<A-A>', '<C-o><C-x>')
-- indent
map('i', '<C-S-.>', '<C-t>')
-- undo/redo
map({ '', 'i' }, '<C-z>', '<Cmd>undo<CR>')
map({ '', 'i' }, '<C-y>', '<Cmd>redo<CR>')

-- Moving around
map('i', '<S-Left>', '<C-o>ms<Left><C-o>v')
map('i', '<S-Down>', '<C-o>ms<C-o>v<Down>')
map('i', '<S-Up>', '<C-o>ms<C-o>v<Up>')
map('i', '<S-Right>', '<C-o>ms<C-o>v')
map('i', '<A-`>', '<C-o>`') -- quick mark jump
map({ '', 'i', 't' }, '<C-Up>', '<PageUp>')
map({ '', 'i', 't' }, '<C-Down>', '<PageDown>')
map({ '', 'i', 't' }, '<C-h>', '<C-Left>')
map({ '', 'i', 't' }, '<C-k>', '<PageUp>')
map({ '', 'i', 't' }, '<C-j>', '<PageDown>')
map({ '', 'i', 't' }, '<C-l>', '<C-Right>')
map({ 'i', 't' }, '<A-h>', '<Left>')
map({ 'i', 't' }, '<A-j>', '<Down>', { remap = true })
map({ 'i', 't' }, '<A-k>', '<Up>', { remap = true })
map({ 'i', 't' }, '<A-l>', '<Right>')
map('n', '<A-h>', '<C-w>h')
map('i', '<A-H>', '<C-o><C-w>h')
map('t', '<A-H>', '<C-\\><C-o><C-w>h')
map('n', '<A-j>', '<C-w>j')
map('n', '<A-k>', '<C-w>k')
map('n', '<A-l>', '<C-w>l')
map('i', '<A-L>', '<C-o><C-w>l')
map('t', '<A-L>', '<C-\\><C-o><C-w>l')
map('v', '<Tab>', 'o')

-- Window actions
-- leaving
map({ '', 'i' }, '<C-q>', '<Cmd>q<CR>')
map({ '', 'i' }, '<C-S-Q>', '<Cmd>q!<CR>')
map('t', '<C-Esc>', '<C-\\><C-n>')
map('t', '<S-Esc>', '<C-\\><C-o>')
-- splits
map('n', '<Leader>v', '<Cmd>split<CR>')
map('n', '<Leader>h', '<Cmd>vsplit<CR>')
-- reload
map({ 'n', 'i' }, '<F5>', '<Cmd>e<CR>')
map({ 'n', 'i' }, '<F17>', '<Cmd>e!<CR>')

-- Extra
map('n', '\\', '.')
map('n', '<Leader>/', '<Cmd>noh<CR>') -- clears all highlights/searches
map('n', '<A-C>', '<Cmd>Inspect<CR>')
map('n', 'S', '<Cmd>term<CR>a')
map('n', 'cd', '<Cmd>cd %:h<CR>')
map('', '<C-t>', '<Cmd>tabnew %<CR>')
map('n', '<Leader>m', function() vim.wo.conceallevel = (vim.wo.conceallevel + 2) % 4 end)
map('n', '<Leader>l', function() -- load and execute lua code in current buffer
	local name = vim.api.nvim_buf_get_name(0)
	local path = name:gsub('.-/lua/(.+)%.lua', '%1', 1):gsub('/init$', '', 1):gsub('/', '.')
	if not exists(name) then
		function _G.bench(cfg, ...)
			local arg = type(cfg) == 'table' and cfg.arg or cfg
			cfg = type(cfg) == 'table' and cfg or {}
			local tries = cfg.tries or 1000000
			local dur = cfg.dur or cfg.duration or 1
			local warmup = cfg.warmup or 5
			local time = {}
			local s = os.time()
			while os.time() - s < warmup do
				for _, f in ipairs { ... } do
					f(arg)
				end
			end
			for _, f in ipairs { ... } do
				local s = os.clock()
				for i = 1, tries do
					f(arg)
				end
				time[#time + 1] = { os.clock() - s }
				local c = 0
				local s = os.time()
				while os.time() - s < dur do
					f(arg)
					c = c + 1
				end
				time[#time][2] = c
			end
			vim.notify(vim.inspect(time))
		end
	end
	local res = loadstring(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n'))()
	local old = package.loaded[path]
	if not exists(name) then
		_G.bench = nil
	else
		package.loaded[path] = res
	end
	if vim.startswith(path, 'nerdcontrast') then
		local nc = require 'nerdcontrast'
		if path:match '%.palette%.' then
			nc.setConfig { [vim.o.bg] = { palette = { base = res } } }
			vim.o.background = path:match 'light' or 'dark'
		elseif path:match '%.theme%.' then
			nc.setup { [vim.o.bg] = { theme = { base = res } } }
		else
			for k, _ in pairs(res) do
				nc.deps[k] = nil
			end
			nc.hi(res)
		end
	elseif vim.startswith(path, 'reform') then
		if not path:find 'util' then
			res.setup(path == 'reform' and old.config or require('reform').config[path:sub(8)])
		else
			res.debug = old.debug
		end
	elseif vim.startswith(path, 'plugins') then
		if type(res[1]) == 'string' then res = { res } end
		for _, cfg in ipairs(res) do
			if type(cfg.config) == 'function' then cfg.config() end
		end
	elseif vim.startswith(path, 'vim.') then
		local dst = vim
		path = path:sub(5)
		while path:find '%.' do
			dst = dst[path:match '^[^.]+']
			path = path:gsub('^[^.]+%.', '', 1)
		end
		dst[path] = res
	end
end)
map('x', '<Tab>', function()
	local from, to = vim.fn.line 'v', vim.api.nvim_win_get_cursor(0)[1]
	if from > to then
		local x = to
		to = from
		from = x
	end
	local lines = vim.api.nvim_buf_get_lines(0, from - 1, to, true)
	for i, line in ipairs(lines) do
		local indent = line:match '^%s'
		if not indent then
			indent = vim.bo.et and string.rep(' ', vim.bo.sw) or '\t'
		elseif indent == ' ' then
			indent = string.rep(' ', vim.bo.sw)
		end
		lines[i] = indent .. line
	end
	vim.api.nvim_buf_set_lines(0, from - 1, to, true, lines)
end)
map('x', '<S-Tab>', function()
	local from, to = vim.fn.line 'v', vim.api.nvim_win_get_cursor(0)[1]
	if from > to then
		local x = to
		to = from
		from = x
	end
	local lines = vim.api.nvim_buf_get_lines(0, from - 1, to, true)
	for i, line in ipairs(lines) do
		local indent = line:match '^%s'
		if not indent then return end
		lines[i] = line:sub((indent == ' ' and vim.bo.sw or 1) + 1)
	end
	vim.api.nvim_buf_set_lines(0, from - 1, to, true, lines)
end)
