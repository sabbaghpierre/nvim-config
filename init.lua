vim.loader.enable()

-- Use Homebrew curl on macOS to avoid SSL errors with system LibreSSL
if vim.fn.has('mac') == 1 then
  vim.env.PATH = '/opt/homebrew/opt/curl/bin:' .. vim.env.PATH
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.live_server = {
  port = 8080,
  browser = false,
}
require('plugins')
require('configs')
require('keymaps')
require('autocmds')
require('statusline')
require('lsp')
