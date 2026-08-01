---@type vim.lsp.Config
return {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = { 'html', 'htmlangular', 'css', 'scss', 'typescript', 'typescriptreact' },
  root_markers = { '.git' },
}
