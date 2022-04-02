"
if has('mac') "setting for mac
  set t_Co=256
endif

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" ハイライト
syntax on
" leaderのキーを変更
let mapleader = "\<Space>"

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

nmap <Leader>5 :<C-u>source $MYVIMRC<CR>
nmap <Leader>n :<C-u>split +enew<CR>
nmap <Leader>t :<C-u>tabnew<CR>
cnoremap %%% <C-R>=expand("<cword>")<CR>
nnoremap <leader>s :Ack %%%<CR>
nnoremap <leader>l <C-w>x

nnoremap <Leader>s" ciw""<Esc>P
nnoremap <Leader>s' ciw''<Esc>P
nnoremap <Leader>s` ciw``<Esc>P
nnoremap <Leader>s( ciw()<Esc>P
nnoremap <Leader>s{ ciw{}<Esc>P
nnoremap <Leader>s[ ciw[]<Esc>P

setlocal iskeyword+=-

"ファイルタイプ用のプラグインとインデントを自動読み込みをonにする
filetype plugin indent on

" 文字コード
scriptencoding utf-8
" 行番号表示
set number
set relativenumber
nnoremap <Leader><Leader> <Cmd>set rnu!<CR>
" ターミナルモードで行番号を消す
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
" 入力中のコマンド表示
set showcmd
" カーソルのある行に下線
set cursorline
" 行番号は6列分確保
set numberwidth=6
" tabを4スペースに
set expandtab
set tabstop=4
set shiftwidth=4
" 自動インデント
set autoindent
" 検索ハイライト
set hlsearch
" 下まで検索したら先頭に戻る
set wrapscan
" 大文字小文字を区別しない
set ignorecase
" 大文字が含まれている場合は区別する
set smartcase
" バックスペースで改行とかも消せるように
set backspace=indent,eol,start
" クリップボードとの共有だっけ
" set clipboard=unnamed
set clipboard+=unnamedplus
"タブ、空白、改行の可視化
set list
"set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%
" swap,backupファイルをoff
set nowritebackup
set nobackup
set noswapfile
" コマンドの保管
set wildmenu
" ステータスラインを２行で表示
set laststatus=2
set splitbelow
set splitright

" python3のパス指定(brewでinstallしたものを指定)
let g:python3_host_prog = '/usr/local/bin/python3'

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = expand('~/.config/nvim/dein')

" Required:
" // FIXME
set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)


  " Let dein manage dein
  " Required:
  " // FIXME
  " call dein#add('/Users/wp-pc-2020-154/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  let s:colors_toml = g:rc_dir . '/colors.toml'
  let s:ddu_toml    = g:rc_dir . '/ddu.toml'
  let s:ddc_toml    = g:rc_dir . '/ddc.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,        {'lazy': 0})
  call dein#load_toml(s:lazy_toml,   {'lazy': 1})
  call dein#load_toml(s:colors_toml, {'lazy': 0})
  call dein#load_toml(s:ddu_toml,    {'lazy': 1})
  call dein#load_toml(s:ddc_toml,    {'lazy': 1})

  " localで試す時に使うTOML
  let s:local_toml  = g:rc_dir . '/local.toml'
  if filereadable(expand(s:local_toml))
    call dein#load_toml(s:local_toml, {'lazy': 0})
  endif

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
" lightlineのwombatを書き換えたかった

" let g:lightline#colorscheme#custom#palette = lightline#colorscheme#flatten(s:p)
"
" ack
set wildignore+=*.a,vendor/**
let g:ackprg = 'ag --nogroup --nocolor --column'
ca Ack Ack!
ca AckFromSearch AckFromSearch!

" scheme
colorscheme gruvbox

" TODO できるかわからんけどカラースキーマによって変える
" SignColumnを背景色と同じにしたかったから書き換え
if g:colors_name == 'gruvbox'
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight link GitGutterAdd GruvboxGreen
  highlight link GitGutterChange GruvboxAqua
  highlight link GitGutterChangeDelete GruvboxAqua
  highlight link GitGutterDelete GruvboxRed
  highlight link FloatBorder GruvboxAqua
endif

" 検索などをした時に画面中央に表示
nmap n nzz
nmap N Nzz
nmap * *zz
"nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap { gT
nmap } gt
" 半ページ送りの時画面中央に表示
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
" 画面分割時の移動をCtrl+j,k,h,lに
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
"挿入モード時にMac標準の前後移動と同じことができるように
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-l> <Right>
"
noremap <C-n> :cn<CR>zz
noremap <C-p> :cp<CR>zz
noremap <C-o> <C-o>zz
noremap <C-i> <C-i>zz
"
noremap tn :tabnext<CR>
noremap tp :tabprevious<CR>

" 全角スペースの可視化
function! DoubleByteSpace()
  highlight DoubleByteSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

" 全角スペースの可視化
if has('syntax')
  augroup DoubleByteSpace
    autocmd!
    autocmd ColorScheme * call DoubleByteSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('DoubleByteSpace', '　')
  augroup END
  call DoubleByteSpace()
endif

"
if has("autocmd")
  autocmd FileType  c        setlocal  sw=4  sts=4  ts=4  et    colorcolumn=80
  autocmd FileType  html     setlocal  sw=2  sts=2  ts=2  et    colorcolumn=80
  autocmd FileType  ruby     setlocal  sw=2  sts=2  ts=2  et    colorcolumn=80
  autocmd FileType  js       setlocal  sw=4  sts=4  ts=4  et    colorcolumn=80
  autocmd FileType  python   setlocal  sw=4  sts=4  ts=4  et    colorcolumn=120
  autocmd FileType  css      setlocal  sw=4  sts=4  ts=4  et    colorcolumn=80
  autocmd FileType  scss     setlocal  sw=4  sts=4  ts=4  et    colorcolumn=80
  autocmd FileType  php      setlocal  sw=4  sts=4  ts=4  et    colorcolumn=120
  autocmd FileType  vim      setlocal  sw=2  sts=2  ts=2  et
  autocmd FileType  yaml     setlocal  sw=2  sts=2  ts=2  et
  autocmd FileType  markdown setlocal  sw=2  sts=2  ts=2  et
  autocmd FileType  go       setlocal  sw=4  sts=4  ts=4  noet  colorcolumn=120
  autocmd FileType  json     setlocal  sw=2  sts=2  ts=2  et    colorcolumn=120
  autocmd FileType  toml     setlocal  sw=2  sts=2  ts=2  et    colorcolumn=120
endif

"
let g:vim_json_syntax_conceal = 0

" go
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_term_mode = "vsplit"
let g:go_fmt_command = "goimports"

" ちょっと面白そう
"" 行を移動
"nnoremap <C-Up> "zdd<Up>"zP
"nnoremap <C-Down> "zdd"zp
"" 複数行を移動
"vnoremap <C-Up> "zx<Up>"zP`[V`]
"vnoremap <C-Down> "zx"zp`[V`]

" GitHubに公開してはいけないTokenや新しいプラグインを試す時に使う設定ファイルを読み込む
if filereadable(expand('~/.config/nvim/local.vim'))
  source ~/.config/nvim/local.vim
endif
