require'bufferline'.setup {
	animation = false,
	maximum_padding = 0,
	minimum_padding = 0,
	icon_close_tab = ' ',
	icon_close_tab_modified = ' ●',
	icon_separator_active = '▊',
}

-- Moving between
map("n", "<M-S-,>", "<Cmd>BufferMovePrevious<CR>")
map("n", "<M-S-.>", "<Cmd>BufferMoveNext<CR>")
map({"", "i"}, "<M-,>", "<Cmd>BufferPrevious<CR>")
map("t", "<M-,>", "<Esc><Cmd>BufferPrevious<CR>i")
map({"", "i"}, "<M-.>", "<Cmd>BufferNext<CR>")
map("t", "<M-.>", "<Esc><Cmd>BufferNext<CR>i")
map("", "<S-Tab>", "<Cmd>BufferPrevious<CR>")
map("", "<Tab>", "<Cmd>BufferNext<CR>")
-- Direct selection
map({"", "i"}, "<M-1>", "<Cmd>BufferGoto 1<CR>")
map({"", "i"}, "<M-2>", "<Cmd>BufferGoto 2<CR>")
map({"", "i"}, "<M-3>", "<Cmd>BufferGoto 3<CR>")
map({"", "i"}, "<M-4>", "<Cmd>BufferGoto 4<CR>")
map({"", "i"}, "<M-5>", "<Cmd>BufferGoto 5<CR>")
map({"", "i"}, "<M-6>", "<Cmd>BufferGoto 6<CR>")
map({"", "i"}, "<M-7>", "<Cmd>BufferGoto 7<CR>")
map({"", "i"}, "<M-8>", "<Cmd>BufferGoto 8<CR>")
map({"", "i"}, "<M-9>", "<Cmd>BufferGoto 9<CR>")
-- Closing
map({"", "i"}, "<C-w>", "<Cmd>BufferClose<CR>")
map({"", "i"}, "<C-S-W>", "<Cmd>BufferClose!<CR>")
map("t", "<C-S-D>", "<C-d><Esc><Cmd>BufferClose!<CR>a")
