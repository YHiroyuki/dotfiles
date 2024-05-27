vim.scriptencoding = "utf-8"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = require('plugins')
require('lazy').setup(plugins)


local options = {
  syntax = "on",
  number = true,
  relativenumber = false,
  showcmd = true,
  cursorline = true,
  numberwidth = 6,
  autoindent = true,
  hlsearch = true,
  wrapscan = true,
  ignorecase = true,
  smartcase = true,
  clipboard = "unnamedplus",
  backup = false,
  writebackup = false,
  swapfile = false,
  expandtab = true,
  shiftwidth = 4,
  tabstop = 4,
  backspace = "indent,eol,start",
  list = true,
  listchars = "tab:>.,trail:_,extends:>,precedes:<,nbsp:%,space:.",
  wildmenu = true,
  laststatus = 2,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  signcolumn = "yes:1",
  compatible = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end


-- autocmd
local autocmd = vim.api.nvim_create_autocmd
-- keymap
local keymap = vim.keymap

-- filetype
local file_type_settings = {
  { pattern = "lua",  command = "setlocal sw=2 sts=2 ts=2 expandtab colorcolumn=120" },
  { pattern = "html", command = "setlocal sw=2 sts=2 ts=2 et colorcolumn=80" },
  { pattern = "php",  command = "setlocal sw=4 sts=4 ts=4 et colorcolumn=120" },
}
for _, setting in ipairs(file_type_settings) do
  autocmd("FileType", setting)
end

-- キーマップ
--- カーソル移動時に中央に移動させる
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
--- タブの移動
vim.keymap.set('n', '{', '<Cmd>tabprevious<CR>')
vim.keymap.set('n', '}', '<Cmd>tabnext<CR>')
--- 画面分割時の移動
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
--- ファイル作成
vim.keymap.set('n', '<leader>n', '<Cmd>split +enew<CR>')
vim.keymap.set('n', '<leader>t', '<Cmd>tabnew<CR>')
--- カッコのくくり
vim.keymap.set('n', '<leader>s\'', 'ciw\'\'<Esc>P')
vim.keymap.set('n', '<leader>s"', 'ciw""<Esc>P')
vim.keymap.set('n', '<leader>s`', 'ciw``<Esc>P')
vim.keymap.set('n', '<leader>s(', 'ciw()<Esc>P')
vim.keymap.set('n', '<leader>s{', 'ciw{}<Esc>P')
vim.keymap.set('n', '<leader>s[', 'ciw[]<Esc>P')
--- lsp
vim.keymap.set('n', '<Leader>/', "<Cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set('n', '<Leader><Leader>', "<Cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set('n', '<Leader>r', "<Cmd>lua vim.lsp.buf.references()<CR>")


-- terminalを開く時の制御
local function open_terminal()
  local term_bufnr = nil
  -- 現在のバッファのリストを取得
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype == 'terminal' then
      term_bufnr = bufnr
      break
    end
  end

  if term_bufnr then
    -- 既存のターミナルバッファを開く
    vim.cmd('buffer ' .. term_bufnr)
  else
    -- 新しいターミナルバッファを作成
    vim.cmd('terminal')
  end
end
vim.api.nvim_create_user_command('Terminal', open_terminal, {})


-- ダブルバイトスペースを強調表示
local function DoubleByteSpace()
  vim.api.nvim_set_hl(0, 'DoubleByteSpace', { bg = 'darkgray' })
end
if vim.fn.has('syntax') == 1 then
  vim.api.nvim_create_augroup('DoubleByteSpace', { clear = true })

  vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
    group = 'DoubleByteSpace',
    callback = DoubleByteSpace,
  })

  vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufRead' }, {
    group = 'DoubleByteSpace',
    callback = function()
      vim.fn.matchadd('DoubleByteSpace', '　')
    end,
  })

  DoubleByteSpace()
end


require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = {
        enable = false
      }
    }
  }
}
-- フォーマットを実行するカスタムコマンドを作成
vim.api.nvim_create_user_command(
  'Format',
  function()
    vim.lsp.buf.format({ async = true })
  end,
  { desc = "Format the current buffer using LSP" }
)
