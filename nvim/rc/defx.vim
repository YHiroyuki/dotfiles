call defx#custom#option('_', {
\   'winwidth': 40,
\   'winheight': 15,
\   'split': 'vertical',
\   'direction': 'topleft',
\   'show_ignored_files': 1,
\   'buffer_name': '',
\   'toggle': 1,
\   'columns': 'git:indent:icons:filename:mark',
\ })
call defx#custom#column('git', 'indicators', {
\   'Modified'  : '✹',
\   'Staged'    : '✚',
\   'Untracked' : '✭',
\   'Renamed'   : '➜',
\   'Unmerged'  : '═',
\   'Ignored'   : '☒',
\   'Deleted'   : '✖',
\   'Unknown'   : '?'
\ })
call defx#custom#column('git', 'column_length', 2)
" call defx#custom#column('git', 'show_ignored', v:true)

function! DefxExtendOpen(context) abort
  echo a:context.targets[0]
endfunction

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  set nonumber
  set norelativenumber
  " Define mappings
  " 移動
  nnoremap <silent><buffer><expr> 1 defx#do_action('call', 'DefxExtendOpen')
  nnoremap <silent><buffer><expr> h defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> l defx#do_action('open_tree')
  nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
  " 描画
  nnoremap <silent><buffer><expr> 5 defx#do_action('redraw')
  nnoremap <silent><buffer><expr> i defx#do_action('toggle_ignored_files')
  " ファイル操作
  nnoremap <silent><buffer><expr> c  defx#do_action('copy')
  nnoremap <silent><buffer><expr> m  defx#do_action('move')
  nnoremap <silent><buffer><expr> p  defx#do_action('paste')
  nnoremap <silent><buffer><expr> nd defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> nf defx#do_action('new_file')
  nnoremap <silent><buffer><expr> r  defx#do_action('rename')
  nnoremap <silent><buffer><expr> d  defx#do_action('remove')
  " extra
  nnoremap <silent><buffer><expr> <CR>  defx#do_action('drop')
  nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> ~     defx#do_action('cd')
  nnoremap <silent><buffer><expr> ..    defx#do_action('cd', '..')
  nnoremap <silent><buffer><expr> q     defx#do_action('quit')
  nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
  nnoremap <silent><buffer><expr> cd    defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> x     defx#is_directory() ?
\                                       defx#do_action('open_tree', 'recursive:10') :
\                                       defx#do_action('preview')
endfunction
