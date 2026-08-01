-- Angular Language Server
-- requires: npm install -g @angular/language-server
-- NOTE: If Angular LSP can't find TypeScript or Angular modules, add probe locations:
--   cmd = {
--     'ngserver', '--stdio',
--     '--tsProbeLocations', '<project-root>/node_modules',
--     '--ngProbeLocations', '<project-root>/node_modules',
--   }
-- The vim.lsp.Config API doesn't support dynamic cmd based on root_dir,
-- so probe locations must be hardcoded or omitted. Without them, ngserver
-- searches relative to the project root (works for standard Angular projects).
---@type vim.lsp.Config
return {
  cmd = { 'ngserver', '--stdio' },
  filetypes = { 'typescript', 'html', 'htmlangular', 'typescriptreact', 'typescript.tsx' },
  root_markers = { 'angular.json', 'project.json' },
}
