local keymap = vim.keymap.set

----------------------------------------------------------------------
-- General
----------------------------------------------------------------------
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Splits
keymap('n', '<leader>-', '<cmd>split<CR>', { desc = 'Split horizontal' })
keymap('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'Split vertical' })

----------------------------------------------------------------------
-- Telescope
----------------------------------------------------------------------
local builtin = require('telescope.builtin')
keymap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
keymap('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
keymap('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
keymap('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
keymap('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

keymap('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = '[/] Fuzzily search in current buffer' })

keymap('n', '<leader>s/', function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  })
end, { desc = '[S]earch [/] in Open Files' })

keymap('n', '<leader>sn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, { desc = '[S]earch [N]eovim files' })

----------------------------------------------------------------------
-- Bufferline
----------------------------------------------------------------------
keymap('n', '<Leader>bn', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
keymap('n', '<Leader>bp', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous Buffer' })
keymap('n', '<Leader>bb', '<cmd>BufferLinePick<CR>', { desc = 'Pick Buffer' })
keymap('n', '<Leader>bd', function()
  local current = vim.api.nvim_get_current_buf()
  local next_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype ~= 'terminal' then
      next_buf = buf
      break
    end
  end
  if next_buf then
    vim.api.nvim_set_current_buf(next_buf)
  end
  vim.cmd('bdelete ' .. current)
end, { desc = 'Delete Buffer' })
keymap('n', '<Leader>bo', '<cmd>BufferLineCloseOthers<CR>', { desc = 'Close Other Buffers' })

----------------------------------------------------------------------
-- Oil (File Explorer)
----------------------------------------------------------------------
keymap('n', '<leader>fe', function()
  require('oil').toggle_float(vim.fn.expand('%:p:h'))
end, { desc = '[F]ile [E]xplorer (Oil)' })

keymap('n', '<leader>fb', function()
  builtin.buffers({
    initial_mode = 'normal',
    attach_mappings = function(_, map)
      map('n', 'dd', require('telescope.actions').delete_buffer)
      return true
    end,
  })
end, { desc = '[F]ile [B]uffers (Telescope)' })

----------------------------------------------------------------------
-- Terminal (betterTerm)
----------------------------------------------------------------------
keymap({ 'n', 't' }, '<leader>tt', function()
  require('betterTerm').open()
end, { desc = 'Open BetterTerm' })

----------------------------------------------------------------------
-- Formatting
----------------------------------------------------------------------
keymap('', '<leader>cf', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = '[C]ode [F]ormat buffer' })

----------------------------------------------------------------------
-- Search and Replace (grug-far)
----------------------------------------------------------------------
keymap('n', '<leader>sar', function()
  require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
end, { desc = '[S]earch [A]nd [R]eplace (grug-far)' })

----------------------------------------------------------------------
-- Git (vim-fugitive & codediff)
----------------------------------------------------------------------
keymap('n', '<leader>cd', '<cmd>CodeDiff<cr>', { desc = 'Open Visual Diff' })

----------------------------------------------------------------------
-- Flutter
----------------------------------------------------------------------
keymap('n', '<leader>Fr', '<cmd>FlutterRun<CR>', { desc = '[F]lutter [R]un' })
keymap('n', '<leader>Fq', '<cmd>FlutterQuit<CR>', { desc = '[F]lutter [Q]uit' })
keymap('n', '<leader>Fd', '<cmd>FlutterDevices<CR>', { desc = '[F]lutter [D]evices' })
keymap('n', '<leader>Fe', '<cmd>FlutterEmulators<CR>', { desc = '[F]lutter [E]mulators' })
keymap('n', '<leader>Fl', '<cmd>FlutterReload<CR>', { desc = '[F]lutter Re[l]oad' })
keymap('n', '<leader>FR', '<cmd>FlutterRestart<CR>', { desc = '[F]lutter [R]estart (hot)' })
keymap('n', '<leader>Ft', '<cmd>FlutterLogToggle<CR>', { desc = '[F]lutter Log [T]oggle' })

----------------------------------------------------------------------
-- Claude Code
----------------------------------------------------------------------
keymap('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
keymap('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
keymap('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
keymap('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
keymap('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Select Claude model' })
keymap('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })
keymap('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })
keymap('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
keymap('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })

----------------------------------------------------------------------
-- LiveServer
----------------------------------------------------------------------
keymap('n', '<leader>ls', '<cmd>LiveServerStart<cr>', { desc = 'Live Server Start' })
keymap('n', '<leader>lS', '<cmd>LiveServerStop<cr>', { desc = 'Live Server Stop' })


----------------------------------------------------------------------
-- Plugin updates
----------------------------------------------------------------------
keymap('n', '<leader>ps', '<cmd>lua vim.pack.update()<CR>', { desc = '[P]ack update plugin[s]' })
