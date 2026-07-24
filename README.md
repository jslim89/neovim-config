# Neovim Config

Use [lazy.nvim](https://github.com/folke/lazy.nvim) as package manager.

## Pre-requisite

```
brew install tmux \
    sqruff \
    delve
```

Debug adapters for TypeScript/Node (`js-debug-adapter`) and Rust (`codelldb`) are installed automatically via Mason on first `:Lazy sync`.

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

#### In file explorer

| Shortcuts | Description |
| --------- | ----------- |
| a | Create a new file |
| d | Remove a file |

#### Debugging

| Shortcuts | Description |
| --------- | ----------- |
| ,db | Toggle breakpoint |
| ,dB | Set conditional breakpoint |
| ,dc | Continue / start debug session |
| ,di | Step into |
| ,do | Step over |
| ,dO | Step out |
| ,dt | Terminate session |
| ,dl | Run last debug configuration |
| ,dr | Open REPL |
| ,du | Toggle debug UI |
| ,dh | Hover to inspect variable value |

## Config

Add more [language servers](https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers)

Update **lua/config/lsp.lua**, eg. add **php**

```lua
require('lspconfig').intelephense.setup({})
```

