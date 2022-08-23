call ddu#custom#patch_global({
\   'ui': 'ff',
\   'uiParams': {
\     'ff': {
\       'split': 'floating',
\       'floatingBorder': 'single',
\     },
\   },
\   'sources': [
\     {'name': 'file', 'params': {}},
\     {'name': 'register'},
\     {'name': 'buffer'},
\   ],
\   'sourceOptions': {
\     '_': {
\       'matchers': ['matcher_substring'],
\       'ignoreCase': v:true,
\     },
\   },
\   'kindOptions': {
\     'file': {
\       'defaultAction': 'open',
\     },
\     'buffer': {
\       'defaultAction': 'open',
\     },
\   },
\   'filterParams': {
\     'matcher_substring': {'highlightMatched': 'Search',},
\   },
\ })

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>    <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i       <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q       <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent> <C-n>   j
  nnoremap <buffer><silent> <C-p>   k
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>    <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>    <Cmd>close<CR>
  nnoremap <buffer><silent> q       <Cmd>close<CR>
endfunction