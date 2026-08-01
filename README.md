# nvim-config

Personal Neovim configuration. Built on Neovim 0.12 native package management
(`vim.pack`), no plugin manager required — plugins install and update themselves
on first launch.

## Requirements

Install these **before** the first launch. Everything else is installed
automatically by Mason or compiled on demand.

### Required

| Tool | Why | macOS | Ubuntu/Debian | Void Linux |
|------|-----|-------|---------------|------------|
| [Neovim](https://github.com/neovim/neovim) >= 0.12 | Runtime (uses `vim.pack`, `vim.lsp.enable`) | `brew install neovim` | `sudo apt install neovim` | `sudo xbps-install neovim` |
| `git` | Plugin fetching, gitsigns, fugitive | `brew install git` | `sudo apt install git` | `sudo xbps-install git` |
| C compiler (`cc`/`gcc`) | Treesitter parser compilation, telescope-fzf-native build | `brew install gcc` | `sudo apt install build-essential` | `sudo xbps-install gcc` |
| `make` | telescope-fzf-native build | `brew install make` | `sudo apt install make` | `sudo xbps-install make` |
| Node.js + npm | JS/TS/CSS/Angular/HTML LSP servers, prettier, eslint_d | `brew install node` | `sudo apt install nodejs npm` | `sudo xbps-install nodejs` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | telescope live_grep, grug-far | `brew install ripgrep` | `sudo apt install ripgrep` | `sudo xbps-install ripgrep` |
| [Nerd Font](https://www.nerdfonts.com/) | Icons in statusline, bufferline, etc. | Download and set as terminal font (e.g. JetBrainsMono Nerd Font) | same |

### Optional but recommended

| Tool | Why |
|------|-----|
| `fd` | Faster telescope `find_files` |
| Go toolchain (`go`) | gopls + goimports (installed lazily on first Go file) |
| Rust toolchain | Fast fuzzy matcher for blink.cmp (falls back to pure Lua if absent) |
| `trash-cli` | oil.nvim `delete_to_trash` actually moves files to trash |
| Claude CLI | [claudecode.nvim](https://github.com/coder/claudecode.nvim) — `curl -fsSL https://claude.ai/install.sh \| bash` |
| Flutter SDK | [flutter-tools.nvim](https://flutter.dev/docs/get-started/install) — Dart/Flutter support, deferred until a `.dart` file is opened |

## Installation

```sh
# Replace URL with your fork's URL
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim
nvim
```

## First launch

1. **Plugins install automatically** — `vim.pack` fetches everything in
   `lua/plugins.lua` on first start (this can take a few minutes).
2. Run `:Mason` to check LSP servers/formatters/linters. Mason auto-installs:
   `lua-language-server`, `stylua`, `typescript-language-server`,
   `angular-language-server`, `html-lsp`, `css-lsp`, `emmet-ls`, `prettier`,
   `eslint_d`. `gopls` and `goimports` install on your first Go file.
3. **Treesitter parsers compile automatically** (needs a C compiler). If
   parsing fails, run `:TSInstall <lang>` for the affected language.
4. **telescope-fzf-native** is built once (needs `make`). If live grep
   filtering seems slow, rebuild it:

   ```sh
   make -C "$(nvim --headless -c 'echo stdpath("data")' -c 'qa' 2>/dev/null)" \
     site/pack/*/start/telescope-fzf-native.nvim
   ```

   (Or just let it build on first use — it's invoked with `pcall`.)

## Updating

```vim
<leader>ps
```

or `:UpdateRemotePlugins`-equivalent via `vim.pack.update()`.

## Structure

```
~/.config/nvim
├── init.lua              # entrypoint, requires everything
├── nvim-pack-lock.json   # pinned plugin versions (keeps installs reproducible)
├── lua/
│   ├── plugins.lua       # plugin list, colorscheme, per-plugin setup
│   ├── configs.lua       # options (vim.opt)
│   ├── keymaps.lua       # keymaps (leader is space)
│   ├── autocmds.lua      # autocommands
│   ├── statusline.lua    # mini.statusline
│   └── lsp.lua           # LSP setup, diagnostics, LspAttach keymaps
└── lsp/                  # vim.lsp.config per-server (lua_ls, gopls, ts_ls, ...)
```

## Languages

| Language | LSP | Format | Lint |
|----------|-----|--------|------|
| Lua | lua-language-server | stylua | — |
| TypeScript / JavaScript / React | ts_ls | prettier | eslint_d |
| Angular | angular-language-server | prettier | eslint_d |
| HTML / CSS / SCSS | html-lsp, css-lsp, emmet-ls | prettier | — |
| Go | gopls | gofmt + goimports | — |
| Dart / Flutter | flutter-tools (SDK) | dart format | — |
