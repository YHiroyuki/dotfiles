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


-- Lua関数の定義
local api = vim.api

function create_floating_window()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  local width = 40
  local height = 2
  local opts = {
    relative = 'editor',
    -- anchor = 'NW',
    width = width,
    height = height,
    row = row - 1 - (height + 2),
    col = 0,
    style = 'minimal',
    border = 'rounded'
  }
  local target_path = "/home/yhiroyuki/sample/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/"
  local buf = api.nvim_create_buf(false, true)
  local win = api.nvim_open_win(buf, true, opts)

  -- バッファで折り返しを無効にする
  api.nvim_win_set_option(win, 'wrap', false)

  api.nvim_buf_set_lines(buf, 0, -1, false, { "Create File or Directory:", target_path })

  api.nvim_buf_set_keymap(buf, 'i', '<CR>', '', {
    noremap = true,
    silent = true,
    callback = function()
      -- TODO: ここにディレクトリ作成の処理を書く
      api.nvim_win_close(win, true)
    end
  })

  -- ウィンドウでインサートモードを有効にし、テキストの末尾から入力開始
  api.nvim_win_set_cursor(win, { height, string.len(target_path) + 1 }) -- カーソルを最後の行の最後に移動
  vim.api.nvim_input('a')
end

vim.api.nvim_create_user_command('FloatingWindow', create_floating_window, {})

-- ターミナルウィンドウが開かれたときの設定
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end
})


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
