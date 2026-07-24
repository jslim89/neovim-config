return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      'leoluz/nvim-dap-go',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Installs debug adapters via Mason and auto-wires the ones it
      -- knows about (codelldb -> c/cpp/rust/swift/zig). js-debug-adapter
      -- is installed here too but wired manually below (pwa-node).
      require('mason-nvim-dap').setup({
        ensure_installed = { 'codelldb', 'js-debug-adapter' },
        handlers = {},
      })

      -- Go debugging (delve). Requires `dlv` on your PATH.
      require('dap-go').setup()

      -- Node / TypeScript debugging via vscode-js-debug (installed as
      -- js-debug-adapter through Mason).
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }

      for _, lang in ipairs({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }) do
        dap.configurations[lang] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = vim.fn.getcwd(),
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach to process',
            processId = require('dap.utils').pick_process,
            cwd = vim.fn.getcwd(),
          },
        }
      end

      -- UI
      dapui.setup()
      require('nvim-dap-virtual-text').setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Keymaps
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, opts)
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, opts)
      vim.keymap.set('n', '<leader>dc', dap.continue, opts)
      vim.keymap.set('n', '<leader>di', dap.step_into, opts)
      vim.keymap.set('n', '<leader>do', dap.step_over, opts)
      vim.keymap.set('n', '<leader>dO', dap.step_out, opts)
      vim.keymap.set('n', '<leader>dt', dap.terminate, opts)
      vim.keymap.set('n', '<leader>dl', dap.run_last, opts)
      vim.keymap.set('n', '<leader>dr', dap.repl.open, opts)
      vim.keymap.set('n', '<leader>du', dapui.toggle, opts)
      vim.keymap.set('n', '<leader>dh', require('dap.ui.widgets').hover, opts)
    end,
  },
}
