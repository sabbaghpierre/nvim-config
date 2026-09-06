require('lualine').setup({
  options = {
    theme = 'tokyonight',
    icons_enabled = vim.g.have_nerd_font,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'lsp_status', 'filetype', 'filesize' },
    lualine_y = { 'searchcount', 'selectioncount', 'progress' },
    lualine_z = { '%2l:%-2v' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'oil', 'mason', 'fugitive', 'quickfix' },
})
