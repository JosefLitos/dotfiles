local nls = require "null-ls"

-- local h = require("null-ls.helpers")
nls.setup {
	single_file_support = true,
	sources = {
		-- nls.builtins.formatting.latexindent.with {
		-- 	extra_args = {"-l", "~/.config/latexindent.yaml", "-g", "/dev/null"},
		-- },
		nls.builtins.formatting.lua_format.with {
			extra_args = function()
				return {
					"--column-limit=" .. vim.bo.textwidth,
					(vim.bo.expandtab and "--no" or "-") .. "-use-tab",
					"--tab-width=" .. vim.bo.tabstop,
					"--indent-width=" .. (vim.bo.expandtab and vim.o.shiftwidth or 1),
					"--continuation-indent-width=2",
					"--chop-down-table",
					"--no-align-table-field",
					"--no-align-parameter",
					"--no-align-args",
					"--extra-sep-at-table-end",
				}
			end,
		},
		nls.builtins.formatting.prettier.with {
			extra_args = function()
				return {
					"--print-width=" .. vim.bo.textwidth,
					(vim.bo.expandtab or "--use-tabs"),
					"--tab-width=" .. vim.bo.tabstop,
					"--no-semi",
					"--prose-wrap=always",
				}
			end,
		},
		nls.builtins.formatting.shfmt.with {
			extra_args = function()
				return {"-ci", "-s", "-sr", "-i", (vim.bo.expandtab and vim.bo.tabstop or 0)}
			end,
		},
		nls.builtins.formatting.clang_format.with {
			extra_args = function(client)
				if vim.loop.fs_stat(client.cwd .. "/.clang_format") then return {"--style", "file"} end
				return {
					"--style",
					string.format([[{
AllowAllParametersOfDeclarationOnNextLine: true,
AllowShortIfStatementsOnASingleLine: "AllIfsAndElse",
AllowShortLambdasOnASingleLine: "All",
AllowShortLoopsOnASingleLine: true,
AllowShortBlocksOnASingleLine: "Empty",
AllowShortFunctionsOnASingleLine: "None",
BreakBeforeBraces: "Attach",
AlignOperands: "DontAlign",
IndentCaseBlocks: false,
IndentCaseLabels: false,
SortJavaStaticImport: "After",
SpaceAfterCStyleCast: true,
JavaImportGroups: [ "java" ]
IndentWidth: %d, TabWidth: %d, UseTab: %s, ColumnLimit: %d}]], vim.bo.shiftwidth, vim.bo.tabstop,
							vim.bo.expandtab and "Never" or "ForIndentation", vim.bo.textwidth),
				}
			end,
		},
		-- nls.builtins.code_actions.shellcheck,
		-- nls.builtins.diagnostics.eslint,
		nls.builtins.code_actions.eslint,
		nls.builtins.formatting.yapf,
	},
}
