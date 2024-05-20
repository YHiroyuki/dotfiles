-- カーソル移動時に中央に移動させる
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', 'g*', 'g*zz')
vim.keymap.set('n', 'g#', 'g#zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-n>', '<Cmd>cn<CR>zz')
vim.keymap.set('n', '<C-p>', '<Cmd>cp<CR>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
-- タブの移動
vim.keymap.set('n', '{', '<Cmd>tabprevious<CR>')
vim.keymap.set('n', '}', '<Cmd>tabnext<CR>')
-- 画面分割時の移動
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
-- ファイル作成
vim.keymap.set('n', '<leader>n', '<Cmd>split +enew<CR>')
vim.keymap.set('n', '<leader>t', '<Cmd>tabnew<CR>')
-- カッコのくくり
vim.keymap.set('n', '<leader>s\'', 'ciw\'\'<Esc>P')
vim.keymap.set('n', '<leader>s"', 'ciw""<Esc>P')
vim.keymap.set('n', '<leader>s`', 'ciw``<Esc>P')
vim.keymap.set('n', '<leader>s(', 'ciw()<Esc>P')
vim.keymap.set('n', '<leader>s{', 'ciw{}<Esc>P')
vim.keymap.set('n', '<leader>s[', 'ciw[]<Esc>P')



vim.keymap.set('n', '<Leader>/', "<Cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set('n', '<Leader><Leader>', "<Cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set('n', '<Leader>r', "<Cmd>lua vim.lsp.buf.references()<CR>")