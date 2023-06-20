call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', [
\   'nvim-lsp',
\   'around',
\   'cmdline-history'
\ ])
call ddc#custom#patch_global('sourceOptions', {
\   '_': {
\     'matchers': ['matcher_fuzzy'],
\     'sorters': ['sorter_rank'],
\     'converters': ['converter_remove_overlap'],
\   },
\   'around': {'mark': 'Around'},
\   'nvim-lsp': {'mark': 'LSP', 'forceCompletionPattern': '\.\w*|:\w*|->\w*'},
\   'cmdline-history': {'mark': 'history'}
\ })
call ddc#custom#patch_global('sourceParams', {
\   'nvim-lsp': { 'kindLabels': { 'Class': 'c' } },
\ })
call ddc#enable()
call ddc#custom#patch_global('filterParams', {
\   'matcher_fuzzy': {
\     'splitMode': 'word'
\   }
\ })

inoremap <C-n>               <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>               <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-e>               <Cmd>call pum#map#cancel()<CR>
" inoremap <silent><expr> <CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
" inoremap <silent><expr> <CR> <Cmd>call pum#map#confirm()<CR>
inoremap <C-y>               <Cmd>call pum#map#confirm()<CR>
nnoremap <Leader>/           <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader><Leader>    <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>r           <Cmd>lua vim.lsp.buf.references()<CR>
