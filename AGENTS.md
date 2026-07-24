# AGENTS.md

Personal Neovim configuration (Lua) using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. See [README.md](README.md) for key bindings and prerequisites.

## Structure

- [init.lua](init.lua) — entry point. Sets leader key (`,`), then branches: if `vim.g.vscode` is set (running inside the VS Code Neovim extension), loads only [lua/config/vscode.lua](lua/config/vscode.lua); otherwise loads the full config (`autocmds`, `keymaps`, `options`, `nvim-tree-config`, `lsp`).
- `lua/config/` — core editor settings, not plugin-specific (options, keymaps, autocmds, LSP setup, lazy.nvim bootstrap).
- `lua/plugins/` — one file per plugin or feature area (e.g. [lsp.lua](lua/plugins/lsp.lua), [formatter.lua](lua/plugins/formatter.lua), [telescope.lua](lua/plugins/telescope.lua)). Each file `return`s a lazy.nvim plugin spec (table or array of tables). All files here are auto-loaded via `{ import = "plugins" }` in [lua/config/lazy.lua](lua/config/lazy.lua) — no manual registration needed when adding a new file.
- [lazy-lock.json](lazy-lock.json) — plugin version lockfile managed by lazy.nvim (`:Lazy`). Don't hand-edit; it updates automatically on `:Lazy update`.

## Conventions

- New plugin → new file in `lua/plugins/`, named after the plugin/feature (kebab-case, e.g. `db-client.lua`), returning a lazy.nvim spec. Don't add unrelated plugins to an existing file.
- Keymaps for a plugin live in that plugin's `config` function (see [ai.lua](lua/plugins/ai.lua), [formatter.lua](lua/plugins/formatter.lua)); global/editor-wide keymaps live in [lua/config/keymaps.lua](lua/config/keymaps.lua).
- LSP servers are configured with the native `vim.lsp.config(...)` / `vim.lsp.enable({...})` API (Neovim 0.11+) in [lua/config/lsp.lua](lua/config/lsp.lua), not `lspconfig.setup()`. Installation is handled by `mason` + `mason-lspconfig`.
- Formatting is handled by `conform.nvim` in [lua/plugins/formatter.lua](lua/plugins/formatter.lua) — add new filetypes to `formatters_by_ft`, not via separate autocmds.
- `<leader>` is `,`. Check [README.md](README.md)'s keybinding tables before adding a shortcut to avoid clashes.

## Verifying changes

There is no build or test suite (this is an editor config). After editing:
- Reload without restarting: `:source $MYVIMRC` (mapped to `<leader>sv`).
- Check plugin/LSP health: `:checkhealth`, `:Lazy`, `:LspInfo`, `:Mason`.
- Watch `:messages` for Lua errors after reload — a broken `require` or syntax error in any `lua/plugins/*.lua` file will surface there.
