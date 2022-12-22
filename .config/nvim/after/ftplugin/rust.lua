vim.keymap.set({"n", "i"}, "<M-r>", "<C-s><Cmd>cd %:h<CR><Cmd>!cargo b -r<CR>", {buffer = true})
vim.keymap.set({"n", "i"}, "<M-D>", "<C-s><Cmd>cd %:h<CR><Cmd>!cargo b<CR>", {buffer = true})
