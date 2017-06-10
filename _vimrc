
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
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('Yggdroot/indentLine')
" NerdTree
call dein#add('scrooloose/nerdtree')
" unite
call dein#add('Shougo/unite.vim')
" uniteを使ってカラースキーマのチェックをする :Unite colorscheme -auto-preview
call dein#add('ujihisa/unite-colorscheme')
" 構文チェック
"call dein#add('scrooloose/syntastic')
" 補完
call dein#add('Syougo/neocomplete')
" python用補完
call dein#add('davidhalter/jedi-vim')

call dein#add('plasticboy/vim-markdown')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')

" ファイル検索するの楽にするやつ
call dein#add("ctrlpvim/ctrlp.vim")

" パイソンようのプラグイン
" call dein#add('klen/python-mode')

call dein#add('derekwyatt/vim-scala')

call dein#add('h1mesuke/vim-alignta')

call dein#add('airblade/vim-gitgutter')

call dein#add('thinca/vim-quickrun')
"call dein#add('superbrothers/vim-quickrun-markdown-gfm')
" -------colorscheme
" solarized カラースキーム
call dein#add('altercation/vim-colors-solarized')
" mustang カラースキーム
call dein#add('croaker/mustang-vim')
" wombat カラースキーム
call dein#add('jeffreyiacono/vim-colors-wombat')
" jellybeans カラースキーム
call dein#add('nanotech/jellybeans.vim')
" lucius カラースキーム
call dein#add('vim-scripts/Lucius')
" zenburn カラースキーム
call dein#add('vim-scripts/Zenburn')
" mrkn256 カラースキーム
call dein#add('mrkn/mrkn256.vim')
" railscasts カラースキーム
call dein#add('jpo/vim-railscasts-theme')
" pyte カラースキーム
call dein#add('therubymug/vim-pyte')
" molokai カラースキーム
call dein#add('tomasr/molokai')
call dein#add('romainl/Apprentice')


call dein#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


au BufNewFile,BufRead *.scala setf scala

" ステータスラインのデザイン
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }

"indentの可視化
" let g:indent_guides_auto_colors=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=236
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=235
" let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
set list listchars=tab:\¦\
let g:indentLine_fileTypeExclude = ['help', 'nerdtree']

au BufRead,BufNewFile *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1
"NERDTreeの設定
"隠しファイルをdefaultで表示
"let NERDTreeShowHidden = 1
"^qでNERDTREEを開く&閉じる
nmap <silent> <C-e> :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e> :NERDTreeToggle<CR>
"挿入モードの時はNERDTreeの処理をさせない
"imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
"引数なしの時NERDTREEを開く
"  autocmd vimenter * if !argc() | NERDTree | endif
"NERDTreeを開いた状態で閉じたらNERDTreeも閉じる
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == 'primary') | q | endif
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1

"unite設定
nmap U [unite]
nnoremap <silent> [unite]B :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]F :<C-u>Unite file<CR>
let g:unite_enable_start_insert=1


"let g:PyFlakeOnWrite = 1
"let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
"let g:PyFlakeDefaultComplexity=10
" syntastic
"let g:syntastic_python_checkers = ["flake8"]
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2

" いらないこかも
"autocmd FileType python setlocal completeopt-=preview

"" my function
"全角スペースの可視化
function! DoubleByteSpace()
    highlight DoubleByteSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

"" プレーンよう
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
endif
" 自動インデント
set autoindent
" 検索ハイライト
set hlsearch
" 下まで検索したら先頭に戻る
set wrapscan
" 大文字小文字を区別しない
"set ignorecase
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


let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 1
" let g:jedi#use_splits_not_buffers = left

autocmd QuickFixCmdPost *grep* cwindow
" autocmd BufWritePost *.py call Flake8()

" 全角スペースの可視化
if has('syntax')
    augroup DoubleByteSpace
        autocmd!
        autocmd ColorScheme * call DoubleByteSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('DoubleByteSpace', '　')
    augroup END
    call DoubleByteSpace()
endif

if has('mac') "setting for mac

    set t_Co=256
endif

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

if filereadable(glob("~/.vimrc.keymap"))
    source ~/.vimrc.keymap
endif

autocmd ColorScheme * highlight Normal ctermbg=none
colorscheme apprentice
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
"hi colorcolumn ctermbg=233
"hi LineNr ctermbg=235 ctermfg=120
hi VertSplit ctermbg=237 ctermfg=123
"hi CursorLineNr ctermfg=130
"hi SignColumn ctermbg=234 ctermfg=15
"hi StatusLine ctermfg=236 ctermbg=1
hi todo term=reverse cterm=reverse ctermfg=208 ctermbg=235 gui=reverse guifg=#ff8700 guibg=#262626
hi link   Include   Statement
hi link   Define    Statement
hi link   Macro     Statement
hi link   PreCondit Statement


let mapleader=';'
nmap <Leader>x :QuickRun python.pytest<CR>
nmap <Leader>q :QuickRun python.pylama<CR>
"nmap <Leader>; :source ~/.vimrc<CR>


let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<bs>', '<c-]>'],
  \ 'PrtDelete()':          ['<del>'],
  \ 'PrtDeleteWord()':      ['<c-w>'],
  \ 'PrtClear()':           ['<c-u>'],
  \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>'],
  \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>'],
  \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
  \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
  \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
  \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
  \ 'PrtHistory(-1)':       ['<c-j>'],
  \ 'PrtHistory(1)':        ['<c-k>'],
  \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
  \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
  \ 'AcceptSelection("t")': ['<c-t>'],
  \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
  \ 'ToggleFocus()':        ['<s-tab>'],
  \ 'ToggleRegex()':        ['<c-r>'],
  \ 'ToggleByFname()':      ['<c-d>'],
  \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
  \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
  \ 'PrtExpandDir()':       ['<tab>'],
  \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
  \ 'PrtInsert()':          ['<c-\>'],
  \ 'PrtCurStart()':        ['<c-a>'],
  \ 'PrtCurEnd()':          ['<c-e>'],
  \ 'PrtCurLeft()':         ['<c-h>', '<left>', '<c-^>'],
  \ 'PrtCurRight()':        ['<c-l>', '<right>'],
  \ 'PrtClearCache()':      ['<F5>'],
  \ 'PrtDeleteEnt()':       ['<F7>'],
  \ 'CreateNewFile()':      ['<c-y>'],
  \ 'MarkToOpen()':         ['<c-z>'],
  \ 'OpenMulti()':          ['<c-o>'],
  \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
  \ }

" let g:quickrun_config = {
" \   'markdown': {
" \     'type': 'markdown/gfm',
" \     'outputter': 'browser'
" \   }
" \ }
let g:quickrun_config = {
    \ '_': {
    \   'name': 'XXX.quickrun',
    \   'split': 'vsplit',
    \   'filetype': 'nose_result',
    \   'into': 1,
    \ },
    \ 'python.pytest': {
    \   'command': 'py.test',
    \   'cmdopt': '-s -v',
    \ },
    \ 'python.pylama': {
    \   'command': 'pylama',
    \   'split': '5split',
    \ },
    \}

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
