return {
	settings = {
		Lua = {
			telemetry = {enable = false},
			runtime = {version = "LuaJIT"},
			diagnostics = {globals = {"vim"}},
			workspace = {checkThirdParty = false},
		},
	},
	before_init = require'neodev.lsp'.before_init,
}
