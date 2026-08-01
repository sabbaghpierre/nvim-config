-- ============================================================================
-- EXTERNAL DEPENDENCIES:
--   Required system tools (install before first run):
--     - git                    (plugin management, gitsigns, fugitive)
--     - a C compiler (cc/gcc)  (treesitter parser compilation, telescope-fzf-native)
--     - make                   (telescope-fzf-native build)
--     - node / npm             (LSP servers: ts_ls, html, cssls, angularls, emmet_ls)
--     - go                     (gopls, goimports)
--     - ripgrep (rg)           (telescope live_grep, grug-far)
--     - fd                     (telescope find_files, optional but recommended)
--     - rust toolchain         (blink.cmp fuzzy matcher, optional — falls back to Lua)
--     - trash-cli or similar   (oil.nvim delete_to_trash)
--     - claude CLI             (claudecode.nvim — install: curl -fsSL https://claude.ai/install.sh | bash)
--     - flutter SDK            (flutter-tools.nvim — https://flutter.dev/docs/get-started/install)
--
--   Mason auto-installs these LSP servers / formatters / linters:
--     lua-language-server, stylua, typescript-language-server, angular-language-server,
--     html-lsp, css-lsp, emmet-ls, prettier, eslint_d
--   Deferred (installed on first Go file open): gopls, goimports
--
--   After first install:
--     1. Run `:Mason` to verify all tools installed successfully
--     2. Build telescope-fzf-native: find the plugin dir and run `make`
--        (usually in stdpath("data")/site/pack/*/start/telescope-fzf-native.nvim/)
--     3. Treesitter parsers compile automatically; ensure a C compiler is available
-- ============================================================================

vim.pack.add({
  -- Colorscheme
  { src = "https://github.com/ankushbhagats/pastel.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },

  -- UI
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },      -- requires: Nerd Font
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },

  -- Mini modules (statusline, ai, surround)
  { src = "https://github.com/echasnovski/mini.nvim" },

  -- Telescope                                                       -- requires: ripgrep, fd (optional)
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" }, -- requires: make, gcc/cc (run `make` in plugin dir after install)

  -- Completion                                                      -- requires: rust toolchain (optional, for fast fuzzy — falls back to Lua)
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  -- Treesitter                                                      -- requires: gcc/cc (compiles parsers from C source)
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },

  -- LSP tools
  -- Mason installs servers/formatters/linters; vim.lsp.enable configures them via lsp/*.lua.
  -- Each LSP server only starts when its matching filetype is opened (defined by filetypes in lsp/*.lua).
  { src = "https://github.com/mason-org/mason.nvim" },              -- requires: npm, go, etc. depending on which servers
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/folke/lazydev.nvim" },
  -- nvim-lspconfig is kept only as an internal dependency for flutter-tools.nvim
  { src = "https://github.com/neovim/nvim-lspconfig" },

  -- Git                                                             -- requires: git
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/esmuellert/codediff.nvim" },

  -- File management                                                 -- requires: trash-cli (for delete_to_trash)
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/malewicz1337/oil-git.nvim" },

  -- Editing
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/tpope/vim-sleuth" },
  { src = "https://github.com/jake-stewart/multicursor.nvim" },

  -- Formatting & Linting
  -- Formatters used: stylua (Lua), prettier (JS/TS), gofmt+goimports (Go), dart format (Dart)
  -- Linters used: eslint_d (JS/TS)
  -- All installed via Mason (except dart format which comes with Flutter SDK)
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },

  -- Search and Replace                                              -- requires: ripgrep
  { src = "https://github.com/MagicDuck/grug-far.nvim" },

  -- Session
  { src = "https://github.com/rmagatti/auto-session" },

  -- Terminal
  { src = "https://github.com/CRAG666/betterTerm.nvim" },

  -- Flutter/Dart (setup deferred until a Dart file is opened)       -- requires: flutter SDK
  { src = "https://github.com/nvim-flutter/flutter-tools.nvim" },
  { src = "https://github.com/stevearc/dressing.nvim" },
  { src = "https://github.com/wa11breaker/flutter-bloc.nvim" },
  { src = "https://github.com/nvimtools/none-ls.nvim" },

  -- Claude Code
  -- requires: claude CLI — install with: curl -fsSL https://claude.ai/install.sh | bash
  { src = "https://github.com/coder/claudecode.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },

  --LiveServer
  { src = "https://git.barrettruth.com/barrettruth/live-server.nvim" },
})

----------------------------------------------------------------------
-- Colorscheme
----------------------------------------------------------------------
require('tokyonight').setup({
  styles = { comments = { italic = false } },
})
require('pastel').setup({})
-- vim.cmd.colorscheme('pasteldark')
vim.cmd.colorscheme('tokyonight')

----------------------------------------------------------------------
-- UI Plugins
----------------------------------------------------------------------
require('which-key').setup({
  delay = 0,
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ', Down = '<Down> ', Left = '<Left> ', Right = '<Right> ',
      C = '<C-…> ', M = '<M-…> ', D = '<D-…> ', S = '<S-…> ',
      CR = '<CR> ', Esc = '<Esc> ', ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ', NL = '<NL> ', BS = '<BS> ',
      Space = '<Space> ', Tab = '<Tab> ',
      F1 = '<F1>', F2 = '<F2>', F3 = '<F3>', F4 = '<F4>',
      F5 = '<F5>', F6 = '<F6>', F7 = '<F7>', F8 = '<F8>',
      F9 = '<F9>', F10 = '<F10>', F11 = '<F11>', F12 = '<F12>',
    },
  },
  spec = {
    { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
    { '<leader>d', group = '[D]ocument' },
    { '<leader>r', group = '[R]ename' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { '<leader>b', group = '[B]uffer' },
    { '<leader>f', group = '[F]ile' },
    { '<leader>F', group = '[F]lutter' },
    { '<leader>sa', group = '[S]earch [A]nd Replace' },
    { '<leader>a', group = '[A]I / Claude' },
  },
})

require('bufferline').setup({
  options = {
    sort_by = function(buffer_a, buffer_b)
      return buffer_a.name < buffer_b.name
    end,
    show_buffer_close_icons = false,
  },
})

require('nvim-web-devicons').setup({})
require('ibl').setup({})
require('colorizer').setup({ user_default_options = { AARRGGBB = true } })
require('todo-comments').setup({ signs = false })
require('fidget').setup({})

----------------------------------------------------------------------
-- Mini modules (ai, surround — statusline is in statusline.lua)
----------------------------------------------------------------------
require('mini.ai').setup({ n_lines = 500 })
require('mini.surround').setup()

----------------------------------------------------------------------
-- Telescope
----------------------------------------------------------------------
require('telescope').setup({
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
})
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

----------------------------------------------------------------------
-- Completion (blink.cmp)
----------------------------------------------------------------------
require('blink.cmp').setup({
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
  keymap = {
    preset = 'none',
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-y>'] = { 'accept', 'fallback' },
    ['<C-Space>'] = { 'show', 'fallback' },
    ['<C-l>'] = { 'snippet_forward', 'fallback' },
    ['<C-h>'] = { 'snippet_backward', 'fallback' },
  },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'normal',
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },
  sources = {
    default = { 'lazydev', 'lsp', 'snippets', 'path' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
})

----------------------------------------------------------------------
-- Treesitter
----------------------------------------------------------------------
require('nvim-treesitter').install({
  'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
  'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
  'javascript', 'typescript', 'tsx', 'css', 'json', 'scss',
  'yaml', 'toml', 'gitcommit',
  'dart', 'go',
})
vim.treesitter.language.register('html', 'htmlangular')

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    -- Only override indentexpr when treesitter actually starts successfully.
    -- If there's no parser for this filetype, vim.treesitter.start() errors
    -- and we leave indentexpr alone so Vim's built-in indent logic takes over.
    -- (Previously this was set unconditionally, breaking indentation for any
    -- filetype without a parser since treesitter.indentexpr() returns -1.)
    local ok = pcall(vim.treesitter.start)
    if ok then
      vim.opt_local.indentexpr = 'v:lua.vim.treesitter.indentexpr()'
    end
  end,
})

-- NOTE: nvim-ts-autotag may use old treesitter internals that break on Neovim 0.12.
-- If you get errors on startup, comment out this setup() call and its vim.pack.add entry above.
require('nvim-ts-autotag').setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
})

----------------------------------------------------------------------
-- LSP Tools
----------------------------------------------------------------------
require('mason').setup({})
require('mason-tool-installer').setup({
  ensure_installed = {
    -- Lua
    'lua-language-server',
    'stylua',
    -- TypeScript / JavaScript / Angular
    'typescript-language-server',
    'angular-language-server',
    'html-lsp',
    'css-lsp',
    'emmet-ls',
    'prettier',
    'eslint_d',
    -- Go: gopls/goimports are installed lazily on first Go file (see autocmd below)
    -- Dart/Flutter: handled by flutter-tools.nvim via Flutter SDK
  },
})

-- Go: install LSP/formatter tools lazily on first Go file open
local go_tools_loaded = false
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'gomod', 'gowork', 'gotmpl' },
  callback = function()
    if go_tools_loaded then return end
    go_tools_loaded = true
    local ok, registry = pcall(require, 'mason-registry')
    if not ok then return end
    for _, name in ipairs({ 'gopls', 'goimports' }) do
      local pkg_ok, pkg = pcall(registry.get_package, name)
      if pkg_ok and not pkg:is_installed() then
        pkg:install()
      end
    end
  end,
})

require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

----------------------------------------------------------------------
-- Git
----------------------------------------------------------------------
require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 200,
    virt_text_pos = 'eol',
  },
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  preview_config = { border = 'rounded' },
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, { desc = 'Jump to previous git [c]hange' })

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'git [s]tage hunk' })
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function() gitsigns.diffthis('@') end, { desc = 'git [D]iff against last commit' })
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
  end,
})

require('codediff').setup({ char_brightness = 0.95 })

----------------------------------------------------------------------
-- File Management (Oil)
----------------------------------------------------------------------
require('oil-git').setup({
  show_file_highlights = true,
  show_directory_highlights = false,
  show_ignored_files = true,
})

require('oil').setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
    is_always_hidden = function(name, _)
      return name == '..' or name == '.git'
    end,
  },
  win_options = { wrap = true },
  float = {
    padding = 2,
    max_width = 0.5,
    max_height = 0.6,
    border = 'rounded',
    win_options = { winblend = 0 },
    get_win_title = nil,
    preview_split = 'auto',
    override = function(conf) return conf end,
  },
})

----------------------------------------------------------------------
-- Editing
----------------------------------------------------------------------
require('nvim-autopairs').setup({})

local mc = require('multicursor-nvim')
mc.setup()

-- oil.nvim's multicursor integration may fire a cursor-constraint callback
-- after the oil buffer is destroyed, causing "Index out of bounds" inside
-- mc.action. Wrap mc.action so that specific error is silently swallowed.
local _orig_action = mc.action
mc.action = function(fn)
  return _orig_action(function(ctx)
    local ok, err = pcall(fn, ctx)
    if not ok and type(err) == 'string' and err:match('Index out of bounds') then
      return
    elseif not ok then
      error(err, 0)
    end
  end)
end
vim.keymap.set('n', '<c-leftmouse>', mc.handleMouse)
vim.keymap.set('n', '<c-leftdrag>', mc.handleMouseDrag)
vim.keymap.set('n', '<c-leftrelease>', mc.handleMouseRelease)
mc.addKeymapLayer(function(layerSet)
  layerSet('n', '<esc>', function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)
vim.api.nvim_set_hl(0, 'MultiCursorCursor', { reverse = true })
vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'MultiCursorSign', { link = 'SignColumn' })
vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { reverse = true })
vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })

----------------------------------------------------------------------
-- Formatting & Linting
----------------------------------------------------------------------
require('conform').setup({
  notify_on_error = false,
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    go = { 'gofmt', 'goimports' },
    dart = { 'dart_format' },
  },
  formatters = {
    dart_format = {
      command = 'dart',
      args = { 'format', '--line-length', '125' },
      stdin = true,
    },
  },
})

local lint = require('lint')
lint.linters_by_ft = {
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
}

----------------------------------------------------------------------
-- Search and Replace
----------------------------------------------------------------------
require('grug-far').setup({})

----------------------------------------------------------------------
-- Session
----------------------------------------------------------------------
require('auto-session').setup({
  suppressed_dirs = { '~/', '~/Downloads', '/' },
  pre_save_cmds = {
    function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local ft = vim.bo[buf].filetype
        local bt = vim.bo[buf].buftype
        if ft == 'oil' or bt == 'terminal' then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end,
  },
  -- Set a flag while restoring so the SwapExists autocmd knows to bypass the
  -- swap dialog (stale swap files from a previous crash are expected here).
  pre_restore_cmds = { function() vim.g.restoring_session = true end },
  post_restore_cmds = { function() vim.g.restoring_session = false end },
})

----------------------------------------------------------------------
-- Terminal
----------------------------------------------------------------------
require('betterTerm').setup({
  position = 'bot',
  size = 20,
})

----------------------------------------------------------------------
-- Flutter/Dart (deferred until a Dart file is opened)
----------------------------------------------------------------------
local flutter_loaded = false
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dart',
  callback = function()
    if flutter_loaded then return end
    flutter_loaded = true

    require('null-ls').setup({
      sources = { require('flutter-bloc').code_actions },
    })
    require('flutter-bloc').setup({
      bloc_type = 'default',
      use_sealed_classes = false,
      enable_code_actions = true,
    })
    require('flutter-tools').setup({
      dev_log = { open_cmd = 'botright 15split' },
      lsp = {
        settings = {
          dart = {
            lineLength = 125,
            completeFunctionCalls = true,
            enableSnippets = true,
          },
        },
      },
      formatting = {
        command = 'dart',
        args = { 'format', '--line-length', '125' },
      },
    })
  end,
})

----------------------------------------------------------------------
-- Claude Code
----------------------------------------------------------------------
require('claudecode').setup({
  diff_opts = {
    open_in_new_tab = true,
    keep_terminal_focus = true,
  },
})
