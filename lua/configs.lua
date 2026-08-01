local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- Mouse
opt.mouse = 'a'

-- Appearance
opt.showmode = false
opt.cursorline = true
-- opt.guicursor = 'i:block'
-- opt.colorcolumn = '80'
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.wrap = false
opt.winborder = 'rounded'

-- Whitespace display
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.inccommand = 'split'

-- Indentation
opt.autoindent = true
opt.breakindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Undo / swap
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'

-- Completion
opt.completeopt = { 'menuone', 'popup', 'noinsert' }

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300
opt.scrolloff = 10

-- Session options (for auto-session)
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions'

-- Sync clipboard between OS and Neovim
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

vim.cmd.filetype('plugin indent on')
