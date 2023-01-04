local function mkWin(buf, opts, prompt)
	local mode = vim.api.nvim_get_mode().mode
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "Select"
	opts = vim.tbl_extend("force", {relative = "cursor", border = "rounded"}, opts)

	local promptWin = nil
	if prompt ~= "" then
		prompt = "[" .. prompt:gsub(" $", "") .. "]"
		if opts.width < #prompt then
			opts.width = #prompt
		else
			if (opts.width - #prompt) % 2 ~= 0 then opts.width = opts.width + 1 end
		end

		local promptBuf = vim.api.nvim_create_buf(false, true)
		vim.bo[promptBuf].buftype = "nofile"
		vim.bo[promptBuf].bufhidden = "wipe"
		vim.api.nvim_buf_set_lines(promptBuf, 0, -1, true, {prompt})
		vim.bo[promptBuf].modifiable = false

		promptWin = vim.api.nvim_open_win(promptBuf, false, {
			relative = "cursor",
			row = opts.row,
			col = opts.col + (opts.width - #prompt) / 2 + 1,
			width = #prompt,
			height = 1,
			border = "none",
			zindex = 999,
		})
		vim.wo[promptWin].number = false
		vim.wo[promptWin].cursorline = false
		vim.wo[promptWin].cursorcolumn = false
		vim.wo[promptWin].winhighlight = "Search:NONE,Normal:FloatBorder"
		vim.api.nvim_buf_add_highlight(promptBuf, -1, "FloatTitle", 0, 1, #prompt - 1)
	end

	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.wo[win].winhighlight = "Search:NONE,Pmenu:Normal,MatchParen:NONE"
	vim.wo[win].number = false
	vim.wo[win].cursorcolumn = false
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = buf,
		once = true,
		callback = function()
			if promptWin then vim.api.nvim_win_close(promptWin, true) end
			if mode == "i" then
				vim.cmd.startinsert()
			else
				vim.cmd.stopinsert()
			end
			vim.api.nvim_win_close(win, true)
		end,
	})

	return win
end

vim.ui.input = function(opts, on_confirm)
	local mode = vim.api.nvim_get_mode().mode
	local default = opts.default or ""
	local prompt = opts.prompt and opts.prompt:gsub(": *$", "") or ""
	local buf = vim.api.nvim_create_buf(false, true)
	local width = #prompt > #default and #prompt + 2 or #default
	local win = mkWin(buf, {
		row = -3, -- render window at `row` lines from cursor position
		col = -width / 2,
		width = width + (#default > 25 and 15 or 5),
		height = 1,
	}, prompt)
	vim.wo[win].cursorline = false
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, {default})
	vim.cmd.startinsert {bang = true}

	local function callback(confirmed)
		if mode ~= "i" then vim.api.nvim_input("<right>") end
		local text = confirmed and vim.api.nvim_buf_get_lines(buf, 0, -1, true)[1]
		vim.api.nvim_win_close(win, true)
		if confirmed then
			on_confirm(text)
		else
			on_confirm(opts.cancelreturn == nil and "" or opts.cancelreturn)
		end
	end
	map("i", "<C-q>", callback, {buffer = buf})
	map("i", "<Esc>", callback, {buffer = buf})
	map("i", "<CR>", function() callback(true) end, {buffer = buf})
end

vim.ui.select = function(items, opts, on_choice)
	opts.prompt = opts.prompt and opts.prompt:gsub(": *$", "") or "Select one of"
	opts.format_item = opts.format_item or tostring
	local callback
	local buf = vim.api.nvim_create_buf(false, true)
	local width = #opts.prompt
	local lines = {}
	for i, item in ipairs(items) do
		lines[i] = "[" .. i .. "] " .. opts.format_item(item)
		if #lines[i] > width then width = #lines[i] end
		map("n", tostring(i), function() callback(i) end, {buffer = buf})
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
	vim.bo[buf].modifiable = false
	vim.cmd.stopinsert()

	local win = mkWin(buf, {row = 1, col = -2, width = width, height = #items}, opts.prompt)
	vim.api.nvim_win_set_cursor(win, {1, 1})
	vim.api.nvim_create_autocmd("CursorMoved", {
		buffer = buf,
		callback = function()
			local cursor = vim.api.nvim_win_get_cursor(win)
			if cursor[2] ~= 1 then vim.api.nvim_win_set_cursor(win, {cursor[1], 1}) end
		end,
	})
	vim.cmd.stopinsert()

	vim.cmd [[
		syn match SelectNum /-\?\d\+/
		syn match SelectId /\d\+/ contained 
		syn match SelectOpt /^\[\d\+\] / contains=SelectId
		syn region SelectString start=/"/ skip=/'/ end=/"/ contained
		syn region SelectString start=/'/ skip=/"/ end=/'/ contained
		syn match SelectVar /\w\+/ contained
		syn region SelectVarDelim start="`" end="`" contains=SelectVar
		hi def link SelectNum Number
		hi def link SelectId Repeat
		hi def link SelectOpt Delimiter
		hi def link SelectString String
		hi def link SelectVar Variable
		hi def link SelectVarDelim Delimiter
	]]

	callback = function(i)
		vim.api.nvim_win_close(win, true)
		on_choice(i and items[i], i)
	end
	map("n", "q", callback, {buffer = buf})
	map("n", "<Esc>", callback, {buffer = buf})
	map("n", "<CR>", function() callback(vim.api.nvim_win_get_cursor(win)[1]) end,
			{buffer = buf})
end

vim.lsp.util.convert_input_to_markdown_lines = function(input, contents)
	contents = contents or {}
	local str = input.value or input
	if input.kind or type(input) == "string" then
		str = str:gsub("%s+(```\n)", "%1"):gsub("([ \n\t])`([^`\n]+%s[^`\n]+)`%s*",
				"%1\n```" .. vim.bo.filetype .. "\n%2```\n")
		if vim.bo.filetype ~= "java" then str = str:gsub("{(%a+)}", "*`%1`*") end
		if vim.bo.filetype == "lua" then
			str = str:gsub("|([^| \t\n]+)|", "[%1]"):gsub("\n    %s+", "\n  "):gsub("@%*(.-)%*", "***@%1***")
					:gsub("<pre>(.-)</pre>", "```" .. vim.bo.filetype .. "%1```"):gsub("\n  %- ([%a_]+):",
							"\n   - `%1`:")
		end
	elseif input.language then
		str = string.format("```%s\n%s```", input.language, str)
	else
		for _, v in ipairs(input) do contents = vim.lsp.util.convert_input_to_markdown_lines(v, contents) end
		return contents
	end
	local i = #contents + 1
	if vim.bo.filetype == "java" then
		local code = false
		for _, v in ipairs(vim.split(str, "\n")) do
			if #v > 4 then
				local _, idx = v:find("^>?    ")
				if idx and (code or not v:find(" +*", idx + 1)) then
					v = v:sub(idx + 1)
					if not code then
						contents[i] = "```java"
						i = i + 1;
						code = true
					end
				elseif code then
					code = false
					contents[i - 1] = contents[i - 1] .. "```"
				end
				contents[i] = v;
				i = i + 1;
			end
		end
	else
		for _, v in ipairs(vim.split(str, "\n")) do
			if #v > 2 then
				if v == "---" and contents[i - 1]:find("```", 1, true) == nil then
					contents[i] = ""
					i = i + 1
				end
				contents[i] = v;
				i = i + 1;
			end
		end
	end
	return contents
end

vim.lsp.util.stylize_markdown = function(buf, contents, _opts)
	vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
	vim.api.nvim_buf_set_lines(buf, 0, 0, false, contents)
	return contents
end
