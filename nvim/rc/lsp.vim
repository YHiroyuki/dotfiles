echo "hoge"
lua << EOF
 local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  local set = vim.keymap.set
   set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
   set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
   set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
   set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
   set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
   set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
   set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
   set('n', 'gx', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
   set('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
   set('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
   set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
   end
 vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

 require("mason").setup()
 require("mason-lspconfig").setup()
 require("mason-lspconfig").setup_handlers {
   function(server_name) -- default handler (optional)
     require("lspconfig")[server_name].setup {
       on_attach = on_attach,
     }
   end
 }
EOF
