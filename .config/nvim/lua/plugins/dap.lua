local dap, dapui = require "dap", require "dapui"
dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
	name = 'lldb',
}
dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		command = '/usr/bin/codelldb', -- adjust as needed, must be absolute path
		args = {"--port", "${port}"},
	},
}
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		cwd = '${workspaceFolder}',
		program = function()
			local name = vim.api.nvim_buf_get_name(0)
			local exec = name:gsub("%.c", ".out")
			-- LSAN_OPTIONS=verbosity=1:log_threads=1 gdb...
			local f = io.open(name, "r")
			if f == nil then
				io.close(f)
			else
				os.execute("g++ -std=c++17 -Wall -pedantic -g -fsanitize=address,leak " .. name .. " -o " ..
						           exec)
			end
			return exec
		end,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		cwd = '${workspaceFolder}',
		program = function()
			os.execute("cargo b")
			return vim.api.nvim_buf_get_name(0):gsub("(/%w+)/src/.*$", "%1/target/debug%1")
		end,
	},
}

local function run()
	local config = dap.configurations[vim.o.filetype][1]
	if config.type == "codelldb" then
		config.args = {}
		config.stdio = {nil, nil, nil}
		vim.ui.input({prompt = "Args: "}, function(res)
			if res == "" then return end
			for arg in res:gmatch("[^ ]+") do table.insert(config.args, arg) end
			if config.args[#config.args - 1] == "<" then
				config.stdio = {config.args[#config.args], nil, nil}
				config.args[#config.args - 1] = nil
				config.args[#config.args] = nil
			end
			dap.run(config)
		end)
	end
end

dap.defaults.fallback.external_terminal = {command = "/usr/local/bin/term", args = {"-e"}}
-- dap.defaults.fallback.force_external_terminal = true
dap.defaults.fallback.focus_terminal = true
vim.fn.sign_define("DapBreakpoint", {text = "", texthl = "DiagnosticSignError", numhl = "Fg"})
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DiagnosticSignInfo",
	linehl = "Visual",
	numhl = "DiagnosticSignInfo",
})
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
	dap.repl.close()
end

dapui.setup({
	layouts = {
		{
			elements = {
				{id = "repl", size = 0.01},
				{id = "scopes", size = 0.44},
				{id = "watches", size = 0.25},
				{id = "stacks", size = 0.15},
				{id = "breakpoints", size = 0.15},
			},
			size = 0.25,
			position = "right",
		},
		{elements = {{id = "console", size = 1}}, size = 0.3, position = "bottom"},
	},
	mappings = {
		expand = {"<CR>", "<RightMouse>"},
		remove = "<Del>",
		edit = "<S-CR>",
		open = "O",
		toggle = "T",
	},
})

map("n", "<Leader>b", dap.toggle_breakpoint)
map("n", "<Leader>C", dap.clear_breakpoints)
map("n", "<Leader>G", dap.goto_)
map("n", "<Leader>r", dap.run_to_cursor)
map("n", "<M-e>", dapui.eval)
map("n", "<Leader>e", function()
	vim.ui.input({prompt = "Eval: ", default = vim.fn.expand("/nat")},
			function(res) dapui.eval(res) end)
end)
map("n", "<F6>", dap.continue)
map("n", "<F18>", run)
map("n", "<F7>", dap.step_into)
map("n", "<F8>", dap.step_over)
map("n", "<F9>", dap.step_out)
map("n", "<F10>", dap.terminate)
