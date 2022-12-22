local map = vim.keymap.set
vim.g.mapleader = " "

-- Better indenting
map("n", "<C-S-lt>", "<<")
map("i", "<C-S-lt>", "<C-d>")
map("i", "<C-S-T>", "<C-d>")
map("n", "<C-S-,>", ">>")
map("i", "<C-S-.>", "<C-t>")
-- Folding
map("n", "-", "za")
map("i", "<C-S-_>", "<Esc>zcja")
map("n", "=", "zi")
map("n", "_", "zM")
map("n", "+", "zR")

-- Clipboard management
map("n", "<C-x>", "dd")
map("x", "<C-x>", "d")
map("i", "<C-x>", "<C-o>dd")
map("n", "<C-c>", "Y")
map("x", "<C-c>", "y")
map("i", "<C-c>", "<C-o>Y")
map("n", "<C-v>", "p")
map("x", "<C-v>", "\"ddP")
map("i", "<C-v>", "<Esc>pa")
map("i", "<C-S-V>", "<Esc>Pa")
map("n", "f", "p")
map("n", "F", "P")

-- Text management
map({"", "i"}, "<C-s>", "<Cmd>w<CR>")
map({"n", "i"}, "<M-S-Up>", "<Cmd>m-2<CR>")
map({"n", "i"}, "<M-S-Down>", "<Cmd>m+<CR>")
map("n", "<C-S-Up>", "md\"dY\"dp`d")
map("i", "<C-S-Up>", "<Esc>md\"dY\"dp`da")
map("n", "<C-S-Down>", "md\"dY\"dP`d")
map("i", "<C-S-Down>", "<Esc>md\"dY\"dP`da")
map("n", "<C-a>", "<Esc>mdggVG")
map("i", "<C-a>", "<Esc>mdggi<C-o>VG")
map({"n", "i"}, "<C-S-A>", "<Esc>mdggVGy`da")
map("i", "<C-u>", "<C-v>u")
map("i", "<C-S-U>", "<C-v>U")
map("i", "<C-BS>", "<C-W>")
map("i", "<S-Enter>", "<C-o>o")
map("i", "<C-Enter>", "<C-o>O")
map("i", "<M-Enter>", "<Esc>mdO<Esc>`da")
map("i", "<M-S-Enter>", "<Esc>mdo<Esc>`da")
map("n", "<M-a>", "<C-a>") -- increase value
map("i", "<M-a>", "<C-o><C-a>") -- increase value
map("n", "<M-A>", "<C-x>") -- decrease value
map("i", "<M-A>", "<C-o><C-x>") -- decrease value
map("n", "C", "vg~") -- toggle text case; gu for lowercase, gU for UPPERCASE
map("x", "C", "g~")
map("i", "<M-t>", "<C-o>vg~")

-- Deleting text
map("n", "<C-d>", "\"_dd")
map("i", "<C-d>", "<C-o>\"_dd")
map("i", "<C-Del>", "<C-o>\"_de")
map("", "<Del>", "\"_x")

-- Undotree
map("n", "r", "<Cmd>redo<CR>")
map({"", "i"}, "<C-z>", "<Cmd>undo<CR>")
map({"", "i"}, "<C-y>", "<Cmd>redo<CR>")

-- Moving around
map("", "K", "{")
map("i", "<M-K>", "<C-o>{")
map("", "J", "}")
map("i", "<M-J>", "<C-o>}")
map({"", "i"}, "<C-h>", "<C-Left>")
map({"", "i"}, "<C-j>", "<PageDown>")
map({"", "i"}, "<C-k>", "<PageUp>")
map({"", "i"}, "<C-l>", "<C-Right>")
map({"", "i"}, "<M-S-H>", "<Home>")
map("", "<M-S-J>", "L")
map("i", "<M-S-J>", "<C-o>L")
map("", "<M-S-K>", "H")
map("i", "<M-S-K>", "<C-o>H")
map({"", "i"}, "<M-S-L>", "<End>")
map("i", "<M-h>", "<Left>")
map("i", "<M-j>", "<Down>")
map("i", "<M-k>", "<Up>")
map("i", "<M-l>", "<Right>")
map("i", "<M-m>", "<C-o>m")
map("i", "<C-g>", "<C-o>`")
-- With arrows
map({"", "i"}, "<C-Up>", "<PageUp>")
map("", "<S-Up>", "K")
map({"", "i"}, "<C-Down>", "<PageDown>")
map("", "<S-Down>", "J")
map("i", "<S-Left>", "<Left><C-o>v")
map("i", "<S-Down>", "<C-o>v<Down>")
map("i", "<S-Up>", "<C-o>v<Up>")
map("i", "<S-Right>", "<C-o>v")
map("i", "<S-Home>", "<Left><C-o>v^")
map("i", "<S-End>", "<C-o>v$")

-- Closing
map({"", "i"}, "<C-q>", "<Cmd>q<CR>")
map({"", "i"}, "<C-S-Q>", "<Cmd>q!<CR>")
map("t", "<C-Esc>", "<C-\\><C-n>")

-- Tab management through nvim, Buffers in barbar-s.lua
map("", "<C-t>", "<Cmd>tabnew %<CR>")
map("", "<C-Tab>", "<Cmd>tabnext<CR>")
map("", "<C-S-Tab>", "<Cmd>tabprevious<CR>")
map({"", "i"}, "<C-.>", "<Cmd>tabnext<CR>")
map({"", "i"}, "<C-,>", "<Cmd>tabprevious<CR>")
map({"", "i"}, "<M-C-w>", "<Cmd>tabclose<CR>")
map({"", "i"}, "<C-1>", "<Cmd>tabnext 1<CR>")
map({"", "i"}, "<C-2>", "<Cmd>tabnext 2<CR>")
map({"", "i"}, "<C-3>", "<Cmd>tabnext 3<CR>")
map({"", "i"}, "<C-4>", "<Cmd>tabnext 4<CR>")
map({"", "i"}, "<C-5>", "<Cmd>tabnext 5<CR>")
map({"", "i"}, "<C-6>", "<Cmd>tabnext 6<CR>")
map({"", "i"}, "<C-7>", "<Cmd>tabnext 7<CR>")
map({"", "i"}, "<C-8>", "<Cmd>tabnext 8<CR>")
map({"", "i"}, "<C-9>", "<Cmd>tabnext 9<CR>")

-- Switching splits
map("n", "<Leader>v", "<Cmd>split<CR>")
map("n", "<Leader>h", "<Cmd>vsplit<CR>")
map("n", "<C-S-H>", "<C-w>h")
map("i", "<C-S-H>", "<C-o><C-w>h")
map("t", "<C-S-H>", "<C-\\><C-o><C-w>h")
-- <C-S-J> shows as <S-NL>
map("n", "<S-NL>", "<C-w>j")
map("i", "<S-NL>", "<C-o><C-w>j")
map("t", "<S-NL>", "<C-\\><C-o><C-w>j")
map("n", "<C-S-K>", "<C-w>k")
map("i", "<C-S-K>", "<C-o><C-w>k")
map("t", "<C-S-K>", "<C-\\><C-o><C-w>k")
map("n", "<C-S-L>", "<C-w>l")
map("i", "<C-S-L>", "<C-o><C-w>l")
map("t", "<C-S-L>", "<C-\\><C-o><C-w>l")

-- Resize windows
map("n", "<M-j>", "<Cmd>resize -2<CR>")
map("n", "<M-k>", "<Cmd>resize +2<CR>")
map("n", "<M-h>", "<Cmd>vertical resize -2<CR>")
map("n", "<M-l>", "<Cmd>vertical resize +2<CR>")

map("n", "S", "<Cmd>cd %:h<CR><Cmd>term<CR><Cmd>setlocal nonu scrollback=100<CR>i")
map("n", "cd", "<Cmd>cd %:h<CR>")

-- Refresh and reload
map({"n", "i"}, "<F5>", "<Cmd>e<CR>")
map({"n", "i"}, "<F17>", "<Cmd>e!<CR>")
map("n", "<Leader>l", "<Cmd>luafile %<CR>")
map("n", "<Leader>/", "<Cmd>noh<CR>") -- clears all highlights/searches

-- Dark/Light theme toggle
map("n", "<Leader>t", function()
	vim.o.background = vim.o.background == "light" and "dark" or "light"
	vim.g.bg_none = vim.o.background == "dark"
	vim.cmd.colorscheme "nerdcontrast"
end)

-- Ignore key
map({"", "!"}, "<kInsert>", "<NOP>")
map("", "q", "<NOP>")
