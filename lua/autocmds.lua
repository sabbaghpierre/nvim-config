local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking text
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Go: auto-import and format on save
autocmd('BufWritePre', {
  pattern = '*.go',
  group = augroup('golang-auto-import', { clear = true }),
  callback = function()
    local client = vim.lsp.get_clients({ bufnr = 0, name = 'gopls' })[1]
    if not client then return end
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { 'source.organizeImports' } }
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})

-- Lint on buffer enter, write, and insert leave
autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = augroup('lint', { clear = true }),
  callback = function()
    if vim.opt_local.modifiable:get() then
      require('lint').try_lint()
    end
  end,
})

-- Handle swap file conflicts during session restore.
-- Only bypass the swap warning when auto-session is actively restoring a
-- session (vim.g.restoring_session is set by our pre/post restore hooks below).
-- Outside of that, the swap dialog shows normally to protect against opening
-- the same file in two Neovim instances simultaneously.
autocmd('SwapExists', {
  callback = function()
    if vim.g.restoring_session then
      vim.v.swapchoice = 'e'
    end
  end,
})

-- Claude Code: use TreeAdd in file explorer filetypes
autocmd('FileType', {
  pattern = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
  callback = function()
    vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', { buffer = true, desc = 'Add file to Claude' })
  end,
})
