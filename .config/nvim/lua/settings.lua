vim.cmd([[
set tw=100 noet ts=2 sw=2 sts=2
set wrap undofile noswapfile
set cc=0 cul cuc nu nornu
set lbr bri ai si fdc=0 fdl=100 nofen
set iskeyword+=- shortmess+=ca
]])
vim.o.laststatus = 3
vim.o.signcolumn = "no"
vim.o.incsearch = true
vim.o.title = true
vim.o.titlestring = "Nvim - %{expand('%:t')}"
vim.o.mouse = "a" -- Enable mouse
vim.o.clipboard = "unnamedplus" -- Enable clipboard
vim.o.showtabline = 2 -- Always show buffers
vim.o.hidden = true -- Keep multiple buffers in memory
vim.o.showmode = false
vim.o.whichwrap = "<,>,[,],h,l" -- move to next line with these
vim.o.cmdheight = 1
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.backup = false
vim.o.writebackup = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.smarttab = true
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 500 -- By default timeoutlen is 1000 ms
vim.o.scrollback = 300
vim.o.synmaxcol = 127
vim.o.history = 5000
vim.o.shada = "'100,<50,s10,/100,:100,h,rterm:,rjdt:,r/usr/share/nvim/runtime/"
vim.g.rust_recommended_style = 0

vim.fn.matchadd("Todo", "TODO")
vim.fn.matchadd("Todo", "Note")
vim.fn.matchadd("Todo", "WARN")
vim.fn.matchadd("Todo", "IMPORTANT")
vim.fn.matchadd("Todo", "Optional")
