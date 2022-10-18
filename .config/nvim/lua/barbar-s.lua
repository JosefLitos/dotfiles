require'bufferline'.setup {
	animation = false,
	maximum_padding = 0,
	minimum_padding = 0,
	icon_close_tab = '',
}

-- Moving between
nmap("n", "<M-S-lt>", "<Cmd>BufferMovePrevious<CR>")
nmap("n", "<M-S->>", "<Cmd>BufferMoveNext<CR>")
nmap("", "<M-,>", "<Cmd>BufferPrevious<CR>")
nmap("i", "<M-,>", "<C-o><Cmd>BufferPrevious<CR>")
nmap("t", "<M-,>", "<Esc><Cmd>BufferPrevious<CR>i")
nmap("", "<M-.>", "<Cmd>BufferNext<CR>")
nmap("i", "<M-.>", "<C-o><Cmd>BufferNext<CR>")
nmap("t", "<M-.>", "<Esc><Cmd>BufferNext<CR>i")
nmap("", "<S-Tab>", "<Cmd>BufferPrevious<CR>")
nmap("", "<Tab>", "<Cmd>BufferNext<CR>")
-- Direct selection
nmap({"", "i"}, "<M-1>", "<Cmd>BufferGoto 1<CR>")
nmap({"", "i"}, "<M-2>", "<Cmd>BufferGoto 2<CR>")
nmap({"", "i"}, "<M-3>", "<Cmd>BufferGoto 3<CR>")
nmap({"", "i"}, "<M-4>", "<Cmd>BufferGoto 4<CR>")
nmap({"", "i"}, "<M-5>", "<Cmd>BufferGoto 5<CR>")
nmap({"", "i"}, "<M-6>", "<Cmd>BufferGoto 6<CR>")
nmap({"", "i"}, "<M-7>", "<Cmd>BufferGoto 7<CR>")
nmap({"", "i"}, "<M-8>", "<Cmd>BufferGoto 8<CR>")
nmap({"", "i"}, "<M-9>", "<Cmd>BufferGoto 9<CR>")
-- Closing
nmap("", "<C-w>", "<Cmd>BufferClose<CR>")
nmap("i", "<C-w>", "<C-o><Cmd>BufferClose<CR>")
nmap({"", "i"}, "<C-S-W>", "<Cmd>BufferClose!<CR>")
nmap("t", "<C-d>", "<C-d><Esc><Cmd>BufferClose!<CR>a")
