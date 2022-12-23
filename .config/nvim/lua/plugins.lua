local packer = require "packer"
packer.init {disable_commands = true}
local use = packer.use
packer.reset()

vim.keymap.set("n", "<Leader>u", "<NOP>")
-- Packer can manage itself as an optional plugin
use {"wbthomason/packer.nvim", config = [[require'plugins'.sync()]], keys = {{"n", "<Leader>u"}}}

-- Nvim ui
use {
	"JosefLitos/nerdcontrast.nvim",
	config = function()
		local time = tonumber(os.date("%H"))
		local month = tonumber(os.date("%m"))
		if month > 6 then month = 12 - month end
		month = math.floor(month / 2)
		vim.o.background = (time > 7 - month and time < 16 + month) and "light" or "dark"
		vim.g.bg_none = vim.o.background == "dark"
		vim.cmd.colorscheme "nerdcontrast"
	end,
}
use {"kyazdani42/nvim-web-devicons", after = "nerdcontrast.nvim"}
use {"goolord/alpha-nvim", config = [[require "alpha-s"]], after = "nerdcontrast.nvim"}
use {"feline-nvim/feline.nvim", config = [[require "feline-s"]], after = "nerdcontrast.nvim"}
use {"romgrk/barbar.nvim", config = [[require "barbar-s"]], event = "User Initialized"}
-- Explorer
use {"kevinhwang91/rnvimr", config = [[require "rnvimr-s"]]}
use {
	"kyazdani42/nvim-tree.lua",
	config = [[require "nvimtree-s"]],
	keys = {{"n", "E"}, {"n", "<M-Tab>"}},
}
use {"ibhagwan/fzf-lua", event = "User Initialized", config = [[require "fzf-s"]]}

-- Autocomplete
use {
	"hrsh7th/nvim-cmp",
	config = [[require "cmp-s"]],
	event = "InsertEnter",
	requires = {
		{"L3MON4D3/LuaSnip", event = "User Initialized"},
		{"rafamadriz/friendly-snippets", event = "User Initialized"},
		{"hrsh7th/cmp-nvim-lsp", event = "User Initialized"},
		{after = "nvim-cmp", "saadparwaiz1/cmp_luasnip"},
		{after = "nvim-cmp", "hrsh7th/cmp-cmdline"},
		{after = "nvim-cmp", "hrsh7th/cmp-path"},
		{after = "nvim-cmp", "hrsh7th/cmp-calc"},
		{after = "nvim-cmp", "hrsh7th/cmp-emoji"},
		{after = "nvim-cmp", "hrsh7th/cmp-buffer"},
		{after = "nvim-cmp", "kdheepak/cmp-latex-symbols"},
		{after = "nvim-cmp", "windwp/nvim-autopairs", config = [[require "autopairs-s"]]},
	},
}
use {"folke/neodev.nvim", config = [[require 'lsp'(require 'lsp.lua-ls'())]], ft = "lua"}
use {"mfussenegger/nvim-jdtls", config = [[require "lsp.jdtls"]], ft = "java"}
use {"neovim/nvim-lspconfig", config = [[require "lsp"]], after = "cmp-nvim-lsp"}
use {
	"ray-x/lsp_signature.nvim",
	config = [[require'lsp_signature'.setup {floating_window = false, hint_prefix = " "}]],
	after = "nvim-lspconfig",
}
use {
	"danymat/neogen",
	config = [[
		local ng = require "neogen"
		ng.setup {snippet_engine = "luasnip"}
		vim.keymap.set({"n", "i"}, "<M-y>", ng.generate)
	]],
	after = "nvim-treesitter",
}
-- Formatting
use {
	"jose-elias-alvarez/null-ls.nvim",
	config = [[require "lsp.null-ls"]],
	after = "nvim-lspconfig",
	requires = {"nvim-lua/plenary.nvim", event = "User Initialized"},
}
-- Debugging
use {
	"rcarriga/nvim-dap-ui",
	config = [[require "dap-s"]],
	after = "nvim-dap",
	requires = {"mfussenegger/nvim-dap", ft = {"c", "cpp", "rust", "java"}},
}
-- Syntax highlighting
use {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	config = [[require "treesitter-s"]],
	requires = {"windwp/nvim-ts-autotag", after = "nvim-treesitter"},
	event = "User Initialized",
}
-- use {"nvim-treesitter/playground", config = [[require "playground-s"]], after = "nvim-treesitter"}
use {"JosefLitos/vim-i3config", event = "User Initialized"}

-- Nice To Have
use {
	"lukas-reineke/indent-blankline.nvim",
	config = [[require'indent_blankline'.setup {use_treesitter = true, use_treesitter_scope = true}]],
	event = "User Initialized",
}
use {"pierreglaser/folding-nvim", event = "User Initialized"}
use {"numToStr/Comment.nvim", config = [[require "comment-s"]], event = "User Initialized"}
use {"rrethy/vim-hexokinase", run = "make hexokinase", config = [[require "hexokinase-s"]]}
use "LunarVim/bigfile.nvim"
-- use {'lewis6991/gitsigns.nvim', config = [[require('gitsigns').setup()]]}
--[[ use {
		"rubixninja314/vim-mcfunction",
		ft = "mcfunction",
		config = function()
			vim.g.mcversion = "latest"
			vim.g.mcEnableBuiltinIDs = false
			vim.g.mcEnableBuiltinJSON = false
		end,
	} ]]

return packer
