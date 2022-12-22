local function buttons(name, btns)
	local home = os.getenv("HOME")
	local group = {
		type = "group",
		val = {
			{type = "text", val = "  " .. name, opts = {hl = "LightHighlight"}},
			{type = "padding", val = 1},
		},
	}
	for i, val in ipairs(btns) do
		val[2] = val[2]:gsub(home, "~")
		local path = val[2]:match(".*/")
		local cmd = "e " .. val[2] .. " | cd " .. path
		local hlStart = 1
		local hlPath = -2
		local hlFt = #val[2]
		local hlCol = "Brown"
		if not val[3] then
			val[3] = val[2]:gsub(".*/nvim/lua/", " ")
			if val[3] == val[2] then
				val[3] = val[2]:gsub(".*/.config/", " ")
				if val[3] == val[2] then
					val[3] = val[2]:gsub(".*/packer/[^/]+/[^/]+/lua/", " ")
					if val[3] == val[2] then
						hlCol = "FloatTitle"
						hlStart = val[3]:find("/") - 2
					else
						hlCol = "Yellow"
					end
				else
					hlCol = "Brown"
				end
			else
				hlCol = "Cyan"
			end
			local filename = val[2]:match("[^/]*$")
			hlPath = #val[3] - #filename - 2
			hlFt = filename:find("[^.]*$")
			if hlFt == 1 then
				hlFt = #val[3]
			else
				hlFt = hlPath + hlFt - 1
			end
		end
		local tbl = {
			type = "button",
			val = val[3] or val[2],
			on_press = function() vim.api.nvim_command(cmd) end,
			opts = {
				keymap = {"n", val[1], ":" .. cmd .. "<CR>", {silent = true, nowait = true}},
				position = "left",
				shortcut = "   [" .. val[1] .. (#val[1] == 1 and "]   " or "]  "),
				cursor = 1,
				align_shortcut = "left",
				hl_shortcut = {
					{"Operator", 3, 4},
					{"Command", 4, #val[1] + 4},
					{"Operator", #val[1] + 4, #val[1] + 5},
				},
				hl = {
					{hlCol, -2, hlStart},
					{"Fg4", hlStart, hlPath},
					{"Red", hlFt - 1, hlFt},
					{"Fg3", hlFt, #val[3] - 2},
				},
			},
		}
		group.val[i + 2] = tbl
	end
	group.val[#btns + 3] = {type = "padding", val = 1}
	return group
end

local function oldfiles(max)
	local oldfiles = {}
	for _, v in ipairs(vim.v.oldfiles) do
		if #oldfiles == max then break end
		if vim.loop.fs_stat(v) and not v:match("%.git/") then
			oldfiles[#oldfiles + 1] = {"" .. #oldfiles, v}
		end
	end
	return buttons("Recent", oldfiles)
end

local alpha = require "alpha"
alpha.setup({
	layout = {
		{type = "text", val = "   NeoVim", opts = {hl = {{"Neo", 3, 6}, {"Vim", 6, 9}}}},
		{type = "padding", val = 1},
		{type = "group", val = function() return {oldfiles(10)} end},
		buttons("Bookmarks", {
			{"D", "~/Documents/"},
			{"dj", "~/Documents/PG/JavaProjects/"},
			{"ds", "~/Documents/PG/litosjos/"},
			{"N", "~/.local/share/nvim/site/pack/packer/start/nerdcontrast.nvim/lua/nerdcontrast.lua"},
		}),
		buttons("Configs", {
			{"dc", "~/dotfiles/.config/"},
			{"vi", "~/.config/nvim/lua/"},
			{"ic", "~/.config/sway/"},
			{"ib", "~/.config/i3blocks/"},
			{"fc", "~/.config/fish/config.fish"},
			{"ra", "~/.config/ranger/rc.conf"},
		}),
		{
			type = "group",
			val = function()
				vim.keymap.set("n", "q", alpha.start, {buffer = true})
				vim.keymap.set("n", "<Esc>", "q", {remap = true, buffer = true})
				vim.keymap.set("n", "<Right>", "<CR>", {remap = true, buffer = true})
				return {}
			end,
		},
	},
})

vim.keymap.set({"", "i"}, "<C-n>", alpha.start)
