# nvim-config

Personal Neovim configuration. Built on Neovim 0.12 native package management
(`vim.pack`), no plugin manager required — plugins install and update themselves
on first launch.

## Requirements

Install these **before** the first launch. Everything else is installed
automatically by Mason or compiled on demand.

### Required

- [Neovim](https://github.com/neovim/neovim) >= 0.12
- `git`
- C compiler (`cc` / `gcc`)
- `make`
- Node.js + npm
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- A [Nerd Font](https://www.nerdfonts.com/) set as your terminal font (icons)

### Optional but recommended

- `fd` — faster telescope `find_files`
- Go toolchain (`go`) — gopls + goimports (installed lazily on first Go file)
- Rust toolchain — fast fuzzy matcher for blink.cmp (falls back to Lua if absent)
- `trash-cli` — oil.nvim `delete_to_trash` actually moves files to trash
- Flutter SDK — [flutter-tools.nvim](https://flutter.dev/docs/get-started/install), deferred until a `.dart` file is opened

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
      site/pack/*/opt/telescope-fzf-native.nvim
   ```

   (Or just let it build on first use — it's invoked with `pcall`.)

## Updating

| Keys | Action |
|------|--------|
| `<leader>ps` | Update plugins (`vim.pack.update()`) |
| `<leader>ph` | Plugin health (`:checkhealth vim.pack`) |
| `<leader>pa` | Add a plugin (prompts for src, persists to `plugins.lua`) |
| `<leader>pd` | Fully remove a configured plugin (config line, disk, restart) |
| `<leader>pc` | Clean orphan plugins (on disk but not in `plugins.lua`) |

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
│   ├── statusline.lua    # lualine statusline
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
