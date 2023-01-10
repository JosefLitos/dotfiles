map({"n", "i"}, "<M-b>", "<Cmd>w|cd %:h|term compiler %:p<CR>", {buffer = true})
map({"n", "i"}, "<M-r>", "<Cmd>w|!compiler %:p<CR><CR>", {buffer = true})
map({"n", "i"}, "<M-D>",
		"<Cmd>w|!g++ -std=c++17 -Wall -pedantic -g -fsanitize=address,leak %:p -o %:p:r.out<CR>",
		{buffer = true})
map({"n", "i"}, "<M-l>",
		"<Cmd>w|cd %:h|!gcc -I /usr/include/lua5.3 %:p -fPIC -O2 -shared -o %:p:r.so<CR><CR>",
		{buffer = true})
map({"n", "i"}, "<M-L>",
		"<Cmd>w|cd %:h|!gcc -I /usr/include/lua5.3 %:p -fPIC -O2 -shared -o %:p:r.so<CR>",
		{buffer = true})
