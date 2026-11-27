# Neovim Config

Use [lazy.nvim](https://github.com/folke/lazy.nvim) as package manager.

## Pre-requisite

```
brew install tmux \
    sqruff \
    fzf \
    ripgrep \
    fd \
    stylua \
    selene
```

## Usage

```sh
git clone git@github.com:jslim89/neovim-config.git ~/.config/nvim
```

### Key Bindings

| Shortcuts | Description |
| --------- | ----------- |
| ,  | Leader key |
| jj | Exit from insert mode into normal mode |
| C-j | Move focus to down window |
| C-k | Move focus to upper window |
| C-h | Move focus to left window |
| C-l | Move focus to right window |
| A-S-h | Open to previous buffer |
| A-S-l | Open to next buffer |
| S-k | [Visual block mode] move highlighted lines up |
| S-j | [Visual block mode] move highlighted lines down |
| ,rs | Remove trailing spaces |

#### IDE-ish

| Shortcuts | Description |
| --------- | ----------- |
| C-p | Search files by name |
| ,t | Toggle file explorer |
| ,ff | Find from files |
| ,fg | Live grep from files |
| ,fb | Find from buffers |
| ga. | Pick a case conversion for the word under the cursor or the selection |

#### In file explorer

| Shortcuts | Description |
| --------- | ----------- |
| a | Create a new file |
| d | Remove a file |

#### AI ([sidekick.nvim](https://github.com/folke/sidekick.nvim))

| Shortcuts | Description |
| --------- | ----------- |
| Tab | [Normal mode] Jump to or apply the next edit suggestion |
| C-. | Focus the AI CLI window |
| ,aa or ,] | Toggle the AI CLI window |
| ,as | Pick an installed AI CLI |
| ,ad | Detach the CLI session |
| ,at | Send the current position (or selection) to the CLI |
| ,af | Send the current file to the CLI |
| ,av | [Visual mode] Send the selection to the CLI |
| ,ap | Pick a prompt from the prompt library |

Next edit suggestions come from `copilot-language-server`, which Mason installs. Sign in once with `:LspCopilotSignIn`.
CLI sessions run inside zellij when Neovim is started in zellij, and inside tmux otherwise.

## Writing Lua

Opening a Lua file loads [lazydev.nvim](https://github.com/folke/lazydev.nvim), which gives `lua_ls` the types for the
Neovim API and for every installed plugin.

- `lua_ls` is installed by Mason and gives completion, hover, go to definition and diagnostics.
- [selene](https://github.com/Kampfkarren/selene) lints on open, save and leaving insert mode. It uses the nearest
  `selene.toml` above the file. Without one it falls back to [selene.toml](./selene.toml) in this repo, which knows
  about the `vim` global through [vim.yml](./vim.yml).
- `,!` formats with stylua. [.stylua.toml](./.stylua.toml) sets 2-space indents and a 120 column limit.

To lint this config from the shell:

```sh
selene lua init.lua
```

## Config

Add more [language servers](https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers)

Update **lua/config/lsp.lua**, eg. add **php**

```lua
require('lspconfig').intelephense.setup({})
```

