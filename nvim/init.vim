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

nmap     <Leader>5 <Cmd>source $MYVIMRC<CR>
nmap     <Leader>n <Cmd>split +enew<CR>
nmap     <Leader>t <Cmd>tabnew<CR>
cnoremap %%%       <C-R>=expand("<cword>")<CR>
nnoremap <leader>s :Ack %%%<CR>
nnoremap <leader>l <C-w>x

nnoremap <Leader>s" ciw""<Esc>P
nnoremap <Leader>s' ciw''<Esc>P
nnoremap <Leader>s` ciw``<Esc>P
nnoremap <Leader>s( ciw()<Esc>P
nnoremap <Leader>s{ ciw{}<Esc>P
nnoremap <Leader>s[ ciw[]<Esc>P

nnoremap x "_x
nnoremap s "_s

setlocal iskeyword+=-

"ファイルタイプ用のプラグインとインデントを自動読み込みをonにする
filetype plugin indent on

" 文字コード
scriptencoding utf-8
" 行番号表示
set number
set relativenumber
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
set clipboard+=unnamedplus
"タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%,space:.
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

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  let s:colors_toml = g:rc_dir . '/colors.toml'
  let s:ddu_toml    = g:rc_dir . '/ddu.toml'
  let s:fzf_toml    = g:rc_dir . '/fzf.toml'
  let s:ddc_toml    = g:rc_dir . '/ddc.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,        {'lazy': 0})
  call dein#load_toml(s:lazy_toml,   {'lazy': 1})
  call dein#load_toml(s:colors_toml, {'lazy': 0})
  "call dein#load_toml(s:ddu_toml,    {'lazy': 1})
  call dein#load_toml(s:ddc_toml,    {'lazy': 1})
  call dein#load_toml(s:fzf_toml,    {'lazy': 1})

  " localで試す時に使うTOML
  let s:local_toml  = g:rc_dir . '/local/local.toml'
  if filereadable(expand(s:local_toml))
    call dein#load_toml(s:local_toml, {'lazy': 0})
  endif

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" ack
set wildignore+=*.a,vendor/**
let g:ackprg = 'ag --nogroup --nocolor --column'
ca Ack Ack!
ca AckFromSearch AckFromSearch!

" scheme
colorscheme gruvbox

" TODO 場所検討中
" SignColumnを背景色と同じにしたかったから書き換え
if g:colors_name == 'gruvbox'
  highlight CursorLine gui=underline
  highlight SignColumn ctermbg=None guibg=None
  highlight link GitGutterAdd           GruvboxGreen
  highlight link GitGutterChange        GruvboxAqua
  highlight link GitGutterDelete        GruvboxRed
  highlight link GitGutterChangeDelete  GruvboxAqua
  highlight link FloatBorder            GruvboxAqua
  highlight link Defx_git_Modified      GruvboxAqua
  highlight link Defx_git_Untracked     GruvboxGreen
  highlight TabLineFill ctermfg=142 ctermbg=237
endif

function! s:getGruvColor(group)
  let guiColor = synIDattr(hlID(a:group), "fg", "gui") 
  let termColor = synIDattr(hlID(a:group), "fg", "cterm") 
  return [ guiColor, termColor ]
endfunction
let s:bg0  = s:getGruvColor('GruvboxBg0')
let s:bg1  = s:getGruvColor('GruvboxBg1')
let s:bg2  = s:getGruvColor('GruvboxBg2')
let s:bg4  = s:getGruvColor('GruvboxBg4')
let s:fg1  = s:getGruvColor('GruvboxFg1')
let s:fg4  = s:getGruvColor('GruvboxFg4')

let s:yellow = s:getGruvColor('GruvboxYellow')
let s:blue   = s:getGruvColor('GruvboxBlue')
let s:aqua   = s:getGruvColor('GruvboxAqua')
let s:orange = s:getGruvColor('GruvboxOrange')
let s:green = s:getGruvColor('GruvboxGreen')

let s:p = {'normal':{}, 'inactive':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'tabline':{}, 'terminal':{}}
let s:p.normal.left = [ [ s:bg0, s:fg4, 'bold' ], [ s:fg4, s:bg2 ] ]
let s:p.normal.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
let s:p.normal.middle = [ [ s:fg4, s:bg1 ] ]
let s:p.inactive.right = [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
let s:p.inactive.left =  [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
let s:p.inactive.middle = [ [ s:bg4, s:bg1 ] ]
let s:p.insert.left = [ [ s:bg0, s:blue, 'bold' ], [ s:fg1, s:bg2 ] ]
let s:p.insert.right = [ [ s:bg0, s:blue ], [ s:fg1, s:bg2 ] ]
let s:p.insert.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.terminal.left = [ [ s:bg0, s:green, 'bold' ], [ s:fg1, s:bg2 ] ]
let s:p.terminal.right = [ [ s:bg0, s:green ], [ s:fg1, s:bg2 ] ]
let s:p.terminal.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.replace.left = [ [ s:bg0, s:aqua, 'bold' ], [ s:fg1, s:bg2 ] ]
let s:p.replace.right = [ [ s:bg0, s:aqua ], [ s:fg1, s:bg2 ] ]
let s:p.replace.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.visual.left = [ [ s:bg0, s:orange, 'bold' ], [ s:bg0, s:bg4 ] ]
let s:p.visual.right = [ [ s:bg0, s:orange ], [ s:bg0, s:bg4 ] ]
let s:p.visual.middle = [ [ s:fg4, s:bg1 ] ]
let s:p.tabline.left = [ [ s:fg4, s:bg2 ] ]
let s:p.tabline.tabsel = [ [ s:bg0, s:aqua, 'bold' ] ]
let s:p.tabline.middle = [ [ s:bg0, s:bg0 ] ]
let s:p.tabline.right = [ [ s:bg0, s:orange ] ]
let s:p.normal.error = [ [ s:bg0, s:orange ] ]
let s:p.normal.warning = [ [ s:bg2, s:yellow ] ]

let g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(s:p)

" 検索などをした時に画面中央に表示
nmap n nzz
nmap N Nzz
nmap * *zz
"nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap { <Cmd>tabprevious<CR>
nmap } <Cmd>tabnext<CR>
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
if filereadable(expand('~/.config/nvim/local/local.vim'))
  source ~/.config/nvim/local/local.vim
endif

" プロジェクトルートに変更する
autocmd VimEnter * ++once call s:ensure_git_root_dir()
function! s:ensure_git_root_dir() abort
  let cmd = 'git rev-parse --show-superproject-working-tree --show-toplevel 2>/dev/null | head -1'
  let root = system(cmd)->trim()->expand()
  if isdirectory(root) && root != getcwd()
    execute 'cd' root
  endif
endfunction

command! -nargs=* Terminal split | wincmd j | resize 10 | terminal <args>
autocmd TermOpen * startinsert


let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-J> copilot#Accept()

