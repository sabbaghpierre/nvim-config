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
-- Git (vim-fugitive & diffview)
----------------------------------------------------------------------
keymap('n', '<leader>cd', function()
  local ok, lib = pcall(require, 'diffview.lib')
  if ok and lib.get_current_view() then
    vim.cmd('DiffviewClose')
  else
    vim.cmd('DiffviewOpen')
  end
end, { desc = 'Toggle Visual Diff' })
keymap('n', '<leader>cm', '<cmd>DiffviewOpen<CR>', { desc = 'Resolve Merge Conflicts' })

keymap('n', '<leader>gg', function()
  if vim.bo.filetype == 'fugitive' then
    vim.cmd('close')
  else
    vim.cmd('Git')
  end
end, { desc = '[G]it status' })
keymap('n', '<leader>gs', '<cmd>Git stash<CR>', { desc = '[G]it [S]tash' })
keymap('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = '[G]it [C]ommit' })
keymap('n', '<leader>gp', '<cmd>Git push<CR>', { desc = '[G]it [P]ush' })
keymap('n', '<leader>gl', '<cmd>Git pull<CR>', { desc = '[G]it Pul[l]' })
keymap('n', '<leader>gd', '<cmd>Gdiffsplit<CR>', { desc = '[G]it [D]iff file' })
keymap('n', '<leader>gS', '<cmd>Git stash pop<CR>', { desc = '[G]it [S]tash Pop' })
keymap('n', '<leader>gb', function()
  builtin.git_branches({ initial_mode = 'normal' })
end, { desc = '[G]it [B]ranches' })

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
-- LivePreview
----------------------------------------------------------------------
keymap('n', '<leader>ls', '<cmd>LivePreview start<cr>', { desc = 'Live Preview Start' })
keymap('n', '<leader>lS', '<cmd>LivePreview close<cr>', { desc = 'Live Preview Stop' })


----------------------------------------------------------------------
-- Plugin updates
----------------------------------------------------------------------
keymap('n', '<leader>ps', '<cmd>lua vim.pack.update()<CR>', { desc = '[P]ack update plugin[s]' })
keymap('n', '<leader>ph', '<cmd>checkhealth vim.pack<CR>', { desc = '[P]ack [H]ealth' })
keymap('n', '<leader>pd', function()
  local names = {}
  local src_by_name = {}
  for _, plug in ipairs(vim.pack.get()) do
    if plug.active then
      names[#names + 1] = plug.spec.name
      src_by_name[plug.spec.name] = plug.spec.src
    end
  end
  table.sort(names)
  vim.ui.select(names, { prompt = 'Remove plugin:' }, function(choice)
    if not choice then return end
    -- `names` holds active plugins only, so plain del would refuse:
    -- go straight to the choices instead of trial-deleting.
    vim.ui.select({
      'Full remove (config line, disk, then restart)',
      'Remove config line only',
      'Cancel',
    }, { prompt = choice .. ' is active:' }, function(action)
      if not action or action == 'Cancel' then return end
      local src = src_by_name[choice]
      if not src then
        vim.notify('No src recorded for ' .. choice, vim.log.levels.ERROR)
        return
      end
      local cfg = vim.fn.stdpath('config') .. '/lua/plugins.lua'
      local lines = vim.fn.readfile(cfg)
      local target = '"' .. src .. '"'
      local idx = nil
      for i, line in ipairs(lines) do
        if line:find(target, 1, true) then
          idx = i
          break
        end
      end
      if not idx then
        vim.notify('Pack line not found in plugins.lua', vim.log.levels.ERROR)
        return
      end
      table.remove(lines, idx)
      if lines[idx - 1] and lines[idx - 1]:match('added via <leader>pa') then
        table.remove(lines, idx - 1)
      end
      if vim.fn.writefile(lines, cfg) ~= 0 then
        vim.notify('Failed to write plugins.lua', vim.log.levels.ERROR)
        return
      end
      if action == 'Remove config line only' then
        vim.notify('Removed from plugins.lua — restart, then <leader>pc to clean from disk', vim.log.levels.INFO)
        return
      end
      local ok, err = pcall(vim.pack.del, { choice }, { force = true })
      if not ok then
        vim.notify('Delete failed: ' .. tostring(err), vim.log.levels.ERROR)
        return
      end
      if #vim.fn.getbufinfo({ bufmodified = 1 }) > 0 then
        vim.notify('Plugin removed — save buffers and restart to finish', vim.log.levels.WARN)
        return
      end
      vim.cmd('restart')
    end)
  end)
end, { desc = '[P]ack [D]elete plugin' })
keymap('n', '<leader>pc', function()
  local orphans = {}
  for _, plug in ipairs(vim.pack.get()) do
    if not plug.active then
      orphans[#orphans + 1] = plug.spec.name
    end
  end
  if #orphans == 0 then
    vim.notify('No orphan plugins', vim.log.levels.INFO)
    return
  end
  table.sort(orphans)
  vim.ui.select({ 'Yes, delete' }, {
    prompt = 'Delete orphans: ' .. table.concat(orphans, ', ') .. '?',
  }, function(choice)
    if not choice then return end
    local ok, err = pcall(vim.pack.del, orphans)
    if ok then
      vim.notify('Deleted orphans: ' .. table.concat(orphans, ', '), vim.log.levels.INFO)
    else
      vim.notify('Clean failed: ' .. tostring(err), vim.log.levels.ERROR)
    end
  end)
end, { desc = '[P]ack [C]lean orphans' })
keymap('n', '<leader>pa', function()
  vim.ui.input({ prompt = 'Plugin src: ' }, function(input)
    if not input or input:match('^%s*$') then return end
    local src = vim.trim(input)
    if src:find('[\"\\]') then
      vim.notify('Invalid plugin src', vim.log.levels.ERROR)
      return
    end
    local cfg = vim.fn.stdpath('config') .. '/lua/plugins.lua'
    local lines = vim.fn.readfile(cfg)
    local close = nil
    local started = false
    for i, line in ipairs(lines) do
      if not started and line:match('vim%.pack%.add%(') then
        started = true
      elseif started and line:match('^%s*}%)%s*$') then
        close = i
        break
      end
    end
    if not close then
      vim.notify('vim.pack.add block not found', vim.log.levels.ERROR)
      return
    end
    for _, line in ipairs(lines) do
      if line:find(src, 1, true) then
        vim.notify('Already in plugins.lua, installing', vim.log.levels.INFO)
        vim.pack.add({ src })
        return
      end
    end
    table.insert(lines, close, '  { src = "' .. src .. '" },')
    table.insert(lines, close, '  -- added via <leader>pa (move to a category as needed)')
    if vim.fn.writefile(lines, cfg) ~= 0 then
      vim.notify('Failed to write plugins.lua', vim.log.levels.ERROR)
      return
    end
    vim.pack.add({ src })
  end)
end, { desc = '[P]ack [A]dd plugin' })
