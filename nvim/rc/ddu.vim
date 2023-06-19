" ddu-ffは使って無い気がする
" call ddu#custom#patch_global({
" \   'ui': 'ff',
" \   'uiParams': {
" \     'ff': {
" \       'split': 'floating',
" \       'floatingBorder': 'single',
" \     },
" \   },
" \   'sources': [
" \     {'name': 'file', 'params': {}},
" \     {'name': 'register'},
" \     {'name': 'buffer'},
" \   ],
" \   'sourceOptions': {
" \     '_': {
" \       'matchers': ['matcher_substring'],
" \       'ignoreCase': v:true,
" \     },
" \   },
" \   'kindOptions': {
" \     'file': {
" \       'defaultAction': 'open',
" \     },
" \     'buffer': {
" \       'defaultAction': 'open',
" \     },
" \   },
" \   'filterParams': {
" \     'matcher_substring': {'highlightMatched': 'Search',},
" \   },
" \ })

call ddu#custom#patch_global({
\   'ui': 'filer',
\   'sources': [
\     {
\       'name': 'file',
\       'params': {},
\     },
\   ],
\   'sourceOptions': {
\     '_': {
\       'columns': ['extra_filename'],
\     },
\   },
\   'kindOptions': {
\     'file': {
\       'defaultAction': 'open',
\     },
\   },
\   'uiParams': {
\     'filer': {
\       'winWidth': 40,
\       'split': 'vertical',
\       'splitDirection': 'topleft',
\       'sort': "filename",
\       'sortTreesFirst': v:true,
\     }
\   },
\ })

" autocmd FileType ddu-ff call s:ddu_my_settings()
" function! s:ddu_my_settings() abort
"   nnoremap <buffer><silent> <CR>    <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
"   nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
"   nnoremap <buffer><silent> i       <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
"   nnoremap <buffer><silent> q       <Cmd>call ddu#ui#ff#do_action('quit')<CR>
"   nnoremap <buffer><silent> <C-n>   j
"   nnoremap <buffer><silent> <C-p>   k
" endfunction
" 
" autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
" function! s:ddu_filter_my_settings() abort
"   inoremap <buffer><silent> <CR>    <Esc><Cmd>close<CR>
"   nnoremap <buffer><silent> <CR>    <Cmd>close<CR>
"   nnoremap <buffer><silent> q       <Cmd>close<CR>
" endfunction

autocmd TabEnter,CursorHold,FocusGained <buffer>
	\ call ddu#ui#filer#do_action('checkItems')

autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort
  nnoremap <buffer><silent><expr> <CR>
    \ ddu#ui#get_item()->get('isTree', v:false) ?
    \ "<Cmd>call ddu#ui#filer#do_action('expandItem', {'mode': 'toggle'})<CR>" :
    \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open'})<CR>"

  nnoremap <buffer><silent> <Esc>
    \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>

  nnoremap <buffer><silent> q
    \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>

  "nnoremap <buffer><silent> ..
  "  \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>

  nnoremap <buffer><silent> c
    \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'copy'})<CR>

  nnoremap <buffer><silent> p
    \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'paste'})<CR>

  nnoremap <buffer><silent> d
    \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'delete'})<CR>

  nnoremap <buffer><silent> r
    \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'rename'})<CR>

  nnoremap <buffer><silent> mv
    \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'move'})<CR>

  nnoremap <buffer><silent> t
    \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newFile'})<CR>

  nnoremap <buffer><silent> mk
    \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newDirectory'})<CR>

  nnoremap <buffer><silent> yy
    \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'yank'})<CR>
endfunction

nmap <silent> ;d <Cmd>call ddu#start({
\   'name': 'filer',
\   'searchPath': expand('%'),
\   'resume': v:true,
\ })<CR>

