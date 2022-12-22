vim.keymap.set({"n", "i"}, "<M-b>", "<Cmd>w|cd %:h|term compiler %:p<CR><Cmd>setlocal nonu<CR>",
		{buffer = true})
vim.keymap.set({"n", "i"}, "<M-r>", "<Cmd>w|!compiler %:p<CR><CR>", {buffer = true})
vim.keymap.set({"n", "i"}, "<M-D>",
		"<Cmd>w|!g++ -std=c++17 -Wall -pedantic -g -fsanitize=address,leak %:p -o (echo %:p | sed 's/.c$/.out/')<CR>",
		{buffer = true})
