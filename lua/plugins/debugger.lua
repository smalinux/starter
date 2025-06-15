return {
  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",

      -- Virtual text support
      "theHamsta/nvim-dap-virtual-text",

      -- DAP for C/C++/Rust
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup DAP UI
      dapui.setup()

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup()

      -- -- Auto open/close DAP UI
      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end

      -- C/C++/Rust adapter (using gdb/lldb)
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
       args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.cpp = dap.configurations.c
    end,
  },

  -- Mason integration for DAP
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        "codelldb", -- for C/C++/Rust
      },
    },
  },
}

-- -- ============================================================================
-- -- DAP (Debug Adapter Protocol) Quick Reference
-- -- ============================================================================
--
-- -- Installation: Add nvim-dap plugin, install debug adapters per language
-- -- Docs: https://github.com/mfussenegger/nvim-dap
-- -- Adapters: https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
--
-- -- ============================================================================
-- -- Basic Setup Example (C/C++ with GDB)
-- -- ============================================================================
--
-- local dap = require('dap')
--
-- -- Configure adapter
-- dap.adapters.cppdbg = {
--   id = 'cppdbg',
--   type = 'executable',
--   command = '/usr/bin/gdb',  -- or lldb
--   args = {'--interpreter=dap'},
-- }
--
-- -- Configure launch configuration
-- dap.configurations.c = {
--   {
--     name = "Launch file",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--   },
-- }
--
-- -- C++ uses same config as C
-- dap.configurations.cpp = dap.configurations.c
--
-- -- ============================================================================
-- -- Common Keybindings
-- -- ============================================================================
--
-- vim.keymap.set('n', '<F5>', dap.continue, {desc = 'Debug: Start/Continue'})
-- vim.keymap.set('n', '<F10>', dap.step_over, {desc = 'Debug: Step Over'})
-- vim.keymap.set('n', '<F11>', dap.step_into, {desc = 'Debug: Step Into'})
-- vim.keymap.set('n', '<F12>', dap.step_out, {desc = 'Debug: Step Out'})
-- vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, {desc = 'Debug: Toggle Breakpoint'})
-- vim.keymap.set('n', '<Leader>B', function()
--   dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
-- end, {desc = 'Debug: Conditional Breakpoint'})
-- vim.keymap.set('n', '<Leader>dr', dap.repl.open, {desc = 'Debug: Open REPL'})
-- vim.keymap.set('n', '<Leader>dl', dap.run_last, {desc = 'Debug: Run Last'})
--
-- -- ============================================================================
-- -- Key Commands (User Commands)
-- -- ============================================================================
--
-- -- :DapContinue       - Start/continue debugging
-- -- :DapToggleBreakpoint - Toggle breakpoint at current line
-- -- :DapStepOver       - Step over (F10)
-- -- :DapStepInto       - Step into (F11)
-- -- :DapStepOut        - Step out (F12)
-- -- :DapTerminate      - Stop debugging
-- -- :DapToggleRepl     - Toggle REPL console
-- -- :DapShowLog        - Show debug log
--
-- -- ============================================================================
-- -- Breakpoint Signs Customization
-- -- ============================================================================
--
-- vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define('DapBreakpointCondition', {text='🟡', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='', linehl='', numhl=''})
--
-- -- ============================================================================
-- -- REPL Special Commands
-- -- ============================================================================
--
-- -- .exit / .c / .continue / .n / .next / .into / .out / .up / .down
-- -- .scopes / .threads / .frames / .capabilities
--
-- -- ============================================================================
-- -- Variables in launch.json configurations
-- -- ============================================================================
--
-- -- ${file}                - Current file
-- -- ${fileBasename}        - Current filename
-- -- ${fileDirname}         - Current file directory
-- -- ${workspaceFolder}     - Project root
-- -- ${command:pickProcess} - Select running process
-- -- ${env:HOME}            - Environment variable
--
-- -- ============================================================================
-- -- Additional Language Adapters (examples)
-- -- ============================================================================
--
-- -- Python (debugpy)
-- dap.adapters.debugpy = {
--   type = 'executable',
--   command = 'python',
--   args = {'-m', 'debugpy.adapter'},
-- }
--
-- dap.configurations.python = {
--   {
--     type = 'debugpy',
--     request = 'launch',
--     name = "Launch file",
--     program = "${file}",
--     pythonPath = function()
--       return '/usr/bin/python3'
--     end,
--   },
-- }
--
-- -- ============================================================================
-- -- UI Widgets (optional, requires dap.ui.widgets)
-- -- ============================================================================
--
-- local widgets = require('dap.ui.widgets')
--
-- -- Sidebar with scopes
-- vim.keymap.set('n', '<Leader>ds', function()
--   widgets.sidebar(widgets.scopes).open()
-- end, {desc = 'Debug: Scopes'})
--
-- -- Hover variable
-- vim.keymap.set({'n', 'v'}, '<Leader>dh', widgets.hover, {desc = 'Debug: Hover'})
--
-- -- Centered float with frames
-- vim.keymap.set('n', '<Leader>df', function()
--   widgets.centered_float(widgets.frames)
-- end, {desc = 'Debug: Frames'})
--
--
--
-- -- ============================================================================
-- -- nvim-dap-ui Configuration
-- -- ============================================================================
-- -- Plugin: rcarriga/nvim-dap-ui
-- -- Provides a full-featured debugging UI for nvim-dap
-- -- Repo: https://github.com/rcarriga/nvim-dap-ui
--
-- -- ============================================================================
-- -- Basic Setup
-- -- ============================================================================
--
-- local dap = require('dap')
-- local dapui = require('dapui')
--
-- -- Initialize dapui with default config
-- dapui.setup({
--   icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
--   mappings = {
--     expand = { "<CR>", "<2-LeftMouse>" },
--     open = "o",
--     remove = "d",
--     edit = "e",
--     repl = "r",
--     toggle = "t",
--   },
--   layouts = {
--     {
--       elements = {
--         { id = "scopes", size = 0.25 },
--         { id = "breakpoints", size = 0.25 },
--         { id = "stacks", size = 0.25 },
--         { id = "watches", size = 0.25 },
--       },
--       size = 40,  -- columns
--       position = "left",
--     },
--     {
--       elements = {
--         "repl",
--         "console",
--       },
--       size = 10,  -- rows
--       position = "bottom",
--     },
--   },
--   floating = {
--     max_height = nil,
--     max_width = nil,
--     border = "single",
--     mappings = {
--       close = { "q", "<Esc>" },
--     },
--   },
--   windows = { indent = 1 },
--   render = {
--     max_type_length = nil,
--     max_value_lines = 100,
--   },
-- })
--
-- -- ============================================================================
-- -- Auto-open/close UI
-- -- ============================================================================
--
-- -- Auto-open UI when debugging starts
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
--
-- -- Auto-close UI when debugging ends
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
--
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
--
-- -- ============================================================================
-- -- Keybindings
-- -- ============================================================================
--
-- vim.keymap.set('n', '<Leader>du', dapui.toggle, {desc = 'Debug: Toggle UI'})
-- vim.keymap.set('n', '<Leader>de', function() dapui.eval() end, {desc = 'Debug: Eval'})
-- vim.keymap.set('v', '<Leader>de', function() dapui.eval() end, {desc = 'Debug: Eval Selection'})
--
-- -- Toggle specific elements
-- vim.keymap.set('n', '<Leader>d1', function() dapui.toggle(1) end, {desc = 'Debug: Toggle Sidebar'})
-- vim.keymap.set('n', '<Leader>d2', function() dapui.toggle(2) end, {desc = 'Debug: Toggle Console'})
--
-- -- ============================================================================
-- -- Available UI Elements
-- -- ============================================================================
--
-- -- Sidebar elements:
-- --   - scopes      : Variables in current scope
-- --   - breakpoints : All breakpoints
-- --   - stacks      : Call stack/frames
-- --   - watches     : Watch expressions
--
-- -- Bottom elements:
-- --   - repl        : Debug REPL
-- --   - console     : Program output
--
-- -- ============================================================================
-- -- Functions
-- -- ============================================================================
--
-- -- dapui.open([layout])      - Open UI (specific layout optional)
-- -- dapui.close([layout])     - Close UI
-- -- dapui.toggle([layout])    - Toggle UI
-- -- dapui.eval([expr], opts)  - Evaluate expression (uses <cexpr> if nil)
-- -- dapui.float_element(elem, opts) - Open element in floating window
--
-- -- ============================================================================
-- -- Custom Layout Example (Minimal)
-- -- ============================================================================
--
-- -- dapui.setup({
-- --   layouts = {
-- --     {
-- --       elements = { "scopes", "stacks" },
-- --       size = 40,
-- --       position = "left",
-- --     },
-- --     {
-- --       elements = { "repl" },
-- --       size = 10,
-- --       position = "bottom",
-- --     },
-- --   },
-- -- })
--
-- -- ============================================================================
-- -- Float Element Example
-- -- ============================================================================
--
-- -- Open scopes in floating window
-- vim.keymap.set('n', '<Leader>dfs', function()
--   dapui.float_element('scopes', {
--     width = 100,
--     height = 30,
--     enter = true,
--   })
-- end, {desc = 'Debug: Float Scopes'})
--
-- -- Open REPL in floating window
-- vim.keymap.set('n', '<Leader>dfr', function()
--   dapui.float_element('repl', {
--     width = 120,
--     height = 40,
--     enter = true,
--   })
-- end, {desc = 'Debug: Float REPL'})
--
-- -- ============================================================================
-- -- Advanced: Conditional Auto-Open
-- -- ============================================================================
--
-- -- Only auto-open for specific adapters
-- -- dap.listeners.after.event_initialized["dapui_config"] = function(session)
-- --   if session.config.type == "cppdbg" then
-- --     dapui.open()
-- --   end
-- -- end
--
-- -- ============================================================================
-- -- UI Navigation (within dap-ui windows)
-- -- ============================================================================
--
-- -- <CR> or double-click : Expand/collapse
-- -- o                    : Open (jump to location)
-- -- d                    : Remove (delete watch/breakpoint)
-- -- e                    : Edit (watch expression)
-- -- r                    : Open REPL with item
-- -- t                    : Toggle element
-- -- q or <Esc>          : Close floating window
--
-- -- ============================================================================
-- -- Integration with nvim-dap
-- -- ============================================================================
--
-- -- All standard nvim-dap commands work:
-- -- :DapContinue, :DapToggleBreakpoint, :DapStepOver, etc.
--
-- -- dap-ui enhances the experience with visual feedback
