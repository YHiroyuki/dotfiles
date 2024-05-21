vim.scriptencoding = "utf-8"
vim.g.mapleader = " "

require('options')

-- プラグイン周り
vim.opt['compatible'] = false -- この設定で正しいか不明
local dein_dir = vim.fn['expand']('~/.config/nvim/dein')
local dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'
if not vim.o.runtimepath:match('/dein.vim') then
  if vim.fn['isdirectory'](dein_repo_dir) == 0 then
    os.execute('git clone https://github.com/Shougo/dein.vim ' .. dein_repo_dir)
  end
  vim.o.runtimepath = vim.o.runtimepath .. ',' .. dein_repo_dir
end

if vim.fn['dein#load_state'](dein_dir) == 1 then
  vim.fn['dein#begin'](dein_dir)
  local plugin_path = vim.fn['expand']('~/.config/nvim/plugins/')

  vim.fn['dein#add']('morhetz/gruvbox')
  vim.fn['dein#load_toml'](plugin_path .. 'init.toml', { lazy = 0 })
  vim.fn['dein#load_toml'](plugin_path .. 'lazy.toml', { lazy = 1 })

  vim.fn['dein#end']()
  vim.fn['dein#save_state']()
end
if vim.fn['dein#check_install']() == 1 then
  vim.fn['dein#install']()
end
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')


require('keymap').setup()

require('colorscheme')


-- ファイルタイプごとの設定をautocmdで設定
local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", { pattern = "lua", command = "setlocal sw=2 sts=2 ts=2 expandtab colorcolumn=120" })
autocmd("FileType", { pattern = "html", command = "setlocal sw=2 sts=2 ts=2 et colorcolumn=80" })
autocmd("FileType", { pattern = "php", command = "setlocal sw=4 sts=4 ts=4 et colorcolumn=80" })

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
