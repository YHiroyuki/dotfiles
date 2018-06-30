
"ファイルタイプ用のプラグインとインデントを自動読み込みをonにする
filetype plugin indent on

"""" Plugin
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
" ステータスラインをいい感じに
call dein#add('itchyny/lightline.vim')
" インデントの可視化
call dein#add('Yggdroot/indentLine')
" ack
call dein#add('mileszs/ack.vim')
" unite
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
" 構文チェック
call dein#add('scrooloose/syntastic')
" 補完
call dein#add('Syougo/neocomplete')
"
call dein#add('thinca/vim-quickrun')
" markdown preview用
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
" 整形
call dein#add('h1mesuke/vim-alignta')
" 
call dein#add('editorconfig/editorconfig-vim')

" 言語用プラグイン
"" python
""" 補完
call dein#add('davidhalter/jedi-vim')
"" scala
call dein#add('derekwyatt/vim-scala')
"" golang
call dein#add('fatih/vim-go')

"" TODO
" 左に差分を表示してくれる
call dein#add('airblade/vim-gitgutter')

" NerdTree
" call dein#add('scrooloose/nerdtree')
" uniteを使ってカラースキーマのチェックをする :Unite colorscheme -auto-preview
" call dein#add('ujihisa/unite-colorscheme')
" call dein#add('Shougo/neosnippet')
" call dein#add('Shougo/neosnippet-snippets')
" call dein#add('plasticboy/vim-markdown')
" ファイル検索するの楽にするやつ
" call dein#add("ctrlpvim/ctrlp.vim")

call dein#add('YHiroyuki/atea')


call dein#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


au   BufNewFile,BufRead   *.scala   setf   scala
au   BufRead,BufNewFile   *.md      set    filetype=markdown
au   BufRead,BufNewFile   *.volt    set    filetype=htmldjango
autocmd QuickFixCmdPost *grep* cwindow

" ステータスラインのデザイン
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }

set list listchars=tab:\¦\
let g:indentLine_fileTypeExclude = ['help', 'nerdtree']

let g:vim_markdown_folding_disabled=1

"unite設定
nnoremap <Leader>b :<C-u>Unite buffer<CR>
nnoremap <Leader>f :<C-u>Unite file<CR>
nnoremap <Leader>p :<C-u>Unite file_rec<CR>
" let g:unite_enable_start_insert=1
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" TODO この子別ファイル化
"全角スペースの可視化
function! DoubleByteSpace()
    highlight DoubleByteSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction
if has('syntax')
    augroup DoubleByteSpace
        autocmd!
        autocmd ColorScheme * call DoubleByteSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('DoubleByteSpace', '　')
    augroup END
    call DoubleByteSpace()
endif


" 文字コード
scriptencoding utf-8
" 行番号表示
set number
set relativenumber
" ハイライト
syntax on
" 入力中のコマンド表示
set showcmd
" 80列目をハイライトで表示
set colorcolumn=80
" カーソルのある行に下線
set cursorline
" 行番号は6列分確保
set numberwidth=6
" tabを4スペースに
set expandtab
set tabstop=4
set shiftwidth=4
if has("autocmd")
    autocmd   FileType   c        setlocal   sw=4   sts=4   ts=4   et    colorcolumn=80
    autocmd   FileType   html     setlocal   sw=2   sts=2   ts=2   et    colorcolumn=80
    autocmd   FileType   ruby     setlocal   sw=2   sts=2   ts=2   et    colorcolumn=80
    autocmd   FileType   js       setlocal   sw=4   sts=4   ts=4   et    colorcolumn=80
    autocmd   FileType   python   setlocal   sw=4   sts=4   ts=4   et    colorcolumn=120
    autocmd   FileType   css      setlocal   sw=4   sts=4   ts=4   et    colorcolumn=80
    autocmd   FileType   scss     setlocal   sw=4   sts=4   ts=4   et    colorcolumn=80
    autocmd   FileType   php      setlocal   sw=4   sts=4   ts=4   et    colorcolumn=120
    autocmd   FileType   yaml     setlocal   sw=2   sts=2   ts=2   et
    autocmd   FileType   markdown setlocal   sw=2   sts=2   ts=2   et
    autocmd   FileType   go       setlocal   sw=4   sts=4   ts=4   noet  colorcolumn=120
    autocmd   FileType   json     setlocal   sw=2   sts=2   ts=2   et    colorcolumn=120
endif
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
set clipboard+=unnamed
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


"" python
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
" let g:jedi#use_splits_not_buffers = left
" いらないこかも(超いる子だった)
autocmd FileType python setlocal completeopt-=preview

" golang
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1


 "setting for mac
if has('mac')
    set t_Co=256
endif

" if filereadable(glob("~/.vimrc.local"))
"     source ~/.vimrc.local
" endif

" カラースキーマ
" source ~/src/github.com/YHiroyuki/atea/colors/atea.vim
colorscheme atea
hi link   Include   Statement
hi link   Define    Statement
hi link   Macro     Statement
hi link   PreCondit Statement

let mapleader = "\<Space>"
nmap <silent><Leader>e :tabedit $MYVIMRC<CR>
nmap <Leader>5 :<C-u>source $MYVIMRC<CR>
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
"挿入モード時にCtrl+h,j,k,lで移動出来るように変更
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-k> <Up>
imap <C-j> <Down>
" ackのnext prevy
noremap <C-n> :<C-u>cn<CR>zz
noremap <C-p> :<C-u>cN<CR>zz
noremap <C-c> :<C-u>cc<CR>zz

function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()
