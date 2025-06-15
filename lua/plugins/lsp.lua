-- -- LSP and Completion Configuration
return {

  -- saghen/blink.cmp: Auto-completion plugin that shows suggestions while you type code (like IntelliSense in VS Code)
  -- Provides function names, variables, LSP suggestions, and snippets in a popup menu as you write
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },  -- Accept first item with Enter
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      },
    },
  },
  --
  -- highlighting, & indentation
  --
  -- code folding, indentation, and text objects by parsing code into an AST (Abstract Syntax Tree) for better code understanding.
  -- nvim-treesitter/nvim-treesitter: Provides Treesitter integration for Neovim, enabling advanced syntax highlighting,
  -- code folding, indentation, and text objects by parsing code into an AST (Abstract Syntax Tree) for better code understanding.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
    },
  },
-- Auto-format C and Device Tree files using clang-format
-- Formatting only occurs if file has "clang-format-style: stylename" comment (controlled by autocmd)
  {
	"stevearc/conform.nvim",
	optional = true,
	opts = function(_, opts)
		-- Ensure formatters_by_ft exists
		opts.formatters_by_ft = opts.formatters_by_ft or {}

		-- Set clang_format for C/C++ and Device Tree files
		opts.formatters_by_ft.c = { "clang_format" }
		opts.formatters_by_ft.cpp = { "clang_format" }
		opts.formatters_by_ft.h = { "clang_format" }
		opts.formatters_by_ft.hpp = { "clang_format" }
		opts.formatters_by_ft.dts = { "clang_format" }
		opts.formatters_by_ft.dtsi = { "clang_format" }

		-- Configure clang_format to use ~/.clang-format (set by autocmd)
		opts.formatters = opts.formatters or {}
		opts.formatters.clang_format = {
		command = "clang-format",
		args = { "--style=file" },
		}

		return opts
	end,
  },



-- SMA: -- Mason-lspconfig Configuration Template

-- -- ============================================================================
--   -- Mason: LSP/DAP/Linter/Formatter installer
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ui = {
--         border = "rounded",
--         icons = {
--           package_installed = "✓",
--           package_pending = "➜",
--           package_uninstalled = "✗",
--         },
--       },
--     },
--   },
--
--   -- Mason-lspconfig: Bridge between Mason and lspconfig
--   {
--     "williamboman/mason-lspconfig.nvim",
--     dependencies = {
--       "williamboman/mason.nvim",
--       "neovim/nvim-lspconfig",
--     },
--     opts = {
--       -- Automatically install these LSP servers
--       ensure_installed = {
--         "clangd",        -- C/C++
--         "lua_ls",        -- Lua
--         "pyright",       -- Python
--         "bashls",        -- Bash
--         "jsonls",        -- JSON
--         -- Add more servers as needed
--       },
--
--       -- Automatically install any server you configure via lspconfig
--       automatic_installation = true,
--
--       -- Handler function to configure each server
--       handlers = {
--         -- Default handler: applies to all servers without custom config
--         function(server_name)
--           require("lspconfig")[server_name].setup({})
--         end,
--
--         -- Custom handlers for specific servers
--         ["lua_ls"] = function()
--           require("lspconfig").lua_ls.setup({
--             settings = {
--               Lua = {
--                 diagnostics = {
--                   globals = { "vim" },  -- Recognize 'vim' global
--                 },
--                 workspace = {
--                   library = vim.api.nvim_get_runtime_file("", true),
--                   checkThirdParty = false,
--                 },
--                 telemetry = { enable = false },
--               },
--             },
--           })
--         end,
--
--         ["clangd"] = function()
--           require("lspconfig").clangd.setup({
--             cmd = {
--               "clangd",
--               "--background-index",
--               "--clang-tidy",
--               "--header-insertion=iwyu",
--               "--completion-style=detailed",
--               "--function-arg-placeholders",
--             },
--             filetypes = { "c", "cpp", "objc", "objcpp" },
--             root_dir = require("lspconfig").util.root_pattern(
--               "compile_commands.json",
--               ".git",
--               "Makefile"
--             ),
--           })
--         end,
--
--         ["pyright"] = function()
--           require("lspconfig").pyright.setup({
--             settings = {
--               python = {
--                 analysis = {
--                   typeCheckingMode = "basic",
--                   autoSearchPaths = true,
--                   useLibraryCodeForTypes = true,
--                 },
--               },
--             },
--           })
--         end,
--       },
--     },
--   },
--
-- SMA: -- nvim-lspconfig: LSP configuration

--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       -- Global LSP settings
--       servers = {
--         -- Additional server configs can go here
--       },
--
--       -- Setup function runs after all servers are configured
--       setup = {
--         -- You can add custom setup logic here
--       },
--     },
--   },
--   --     {
  --         'neovim/nvim-lspconfig',
  --         dependencies = {
  --             'williamboman/mason.nvim',
  --             'williamboman/mason-lspconfig.nvim',
  --             'hrsh7th/cmp-nvim-lsp',
  --         },
  --         config = function()
  --             require('mason').setup()
  --             require('mason-lspconfig').setup({
  --                 ensure_installed = {
  --                     'clangd',
  --                     'cmake',
  --                     'ts_ls',
  --                     'vimls',
  --                 },
  --             })
  --
  --             local capabilities = require('cmp_nvim_lsp').default_capabilities()
  --             local lspconfig = require('lspconfig')
  --
  --             -- Configure language servers
  --             lspconfig.clangd.setup({ capabilities = capabilities })
  --             lspconfig.cmake.setup({ capabilities = capabilities })
  --             lspconfig.ts_ls.setup({ capabilities = capabilities })
  --             lspconfig.vimls.setup({ capabilities = capabilities })
  --
  --             -- LSP Keybindings
  --             vim.api.nvim_create_autocmd('LspAttach', {
  --                 group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  --                 callback = function(ev)
  --                     local opts = { buffer = ev.buf, noremap = true, silent = true }
  --                     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  --                     vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
  --                     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  --                     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  --                     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  --                     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  --                     vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
  --                         vim.lsp.buf.format({ async = true })
  --                     end, opts)
  --                     vim.keymap.set({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, opts)
  --                     vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
  --                     vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
  --                 end,
  --             })
  --
  --             -- Diagnostic configuration
  --             vim.diagnostic.config({
  --                 virtual_text = true,
  --                 signs = true,
  --                 update_in_insert = false,
  --                 underline = true,
  --                 severity_sort = true,
  --             })
  --         end,
  --     },
  --
  --     -- Mason
  --     {
  --         'williamboman/mason.nvim',
  --         build = ':MasonUpdate',
  --     },
  --
  --     {
  --         'williamboman/mason-lspconfig.nvim',
  --     },
  --
  --     -- Completion
  --     {
  --         'hrsh7th/nvim-cmp',
  --         event = 'InsertEnter',
  --         dependencies = {
  --             'hrsh7th/cmp-nvim-lsp',
  --             'hrsh7th/cmp-buffer',
  --             'hrsh7th/cmp-path',
  --             'hrsh7th/cmp-cmdline',
  --             'L3MON4D3/LuaSnip',
  --             'saadparwaiz1/cmp_luasnip',
  --         },
  --         config = function()
  --             local cmp = require('cmp')
  --             local luasnip = require('luasnip')
  --
  --             cmp.setup({
  --                 snippet = {
  --                     expand = function(args)
  --                         luasnip.lsp_expand(args.body)
  --                     end,
  --                 },
  --                 mapping = cmp.mapping.preset.insert({
  --                     ['<Tab>'] = cmp.mapping(function(fallback)
  --                         if cmp.visible() then
  --                             cmp.select_next_item()
  --                         elseif luasnip.expand_or_jumpable() then
  --                             luasnip.expand_or_jump()
  --                         else
  --                             fallback()
  --                         end
  --                     end, { 'i', 's' }),
  --                     ['<S-Tab>'] = cmp.mapping(function(fallback)
  --                         if cmp.visible() then
  --                             cmp.select_prev_item()
  --                         elseif luasnip.jumpable(-1) then
  --                             luasnip.jump(-1)
  --                         else
  --                             fallback()
  --                         end
  --                     end, { 'i', 's' }),
  --                     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --                     ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --                     ['<C-Space>'] = cmp.mapping.complete(),
  --                     ['<C-e>'] = cmp.mapping.abort(),
  --                     ['<CR>'] = cmp.mapping.confirm({ select = true }),
  --                 }),
  --                 sources = cmp.config.sources({
  --                     { name = 'nvim_lsp' },
  --                     { name = 'luasnip' },
  --                     { name = 'buffer' },
  --                     { name = 'path' },
  --                 }),
  --             })
  --
  --             -- Cmdline completion
  --             cmp.setup.cmdline(':', {
  --                 mapping = cmp.mapping.preset.cmdline(),
  --                 sources = {
  --                     { name = 'path' },
  --                     { name = 'cmdline' },
  --                 },
  --             })
  --         end,
  --     },
  --
  --     -- LuaSnip
  --     {
  --         'L3MON4D3/LuaSnip',
  --         version = 'v2.*',
  --     },
  --     -- Telescope (FZF replacement - more powerful)
  --     {
  --         'nvim-telescope/telescope.nvim',
  --         dependencies = {
  --             'nvim-lua/plenary.nvim',
  --             { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  --         },
  --         keys = {
  --             { '<leader>f', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
  --             { '<leader>r', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
  --             { '<leader>h', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },
  --             { '<leader>b', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
  --         },
  --         config = function()
  --             local telescope = require('telescope')
  --             local actions = require('telescope.actions')
  --
  --             telescope.setup({
  --                 defaults = {
  --                     mappings = {
  --                         i = {
  --                             ['<C-j>'] = actions.move_selection_next,
  --                             ['<C-k>'] = actions.move_selection_previous,
  --                         },
  --                     },
  --                     file_ignore_patterns = {
  --                         'node_modules',
  --                         '.git/',
  --                         '%.o',
  --                         '%.a',
  --                         '%.out',
  --                         '%.class',
  --                         '%.pdf',
  --                         '%.mkv',
  --                         '%.mp4',
  --                         '%.zip',
  --                     },
  --                 },
  --                 extensions = {
  --                     fzf = {
  --                         fuzzy = true,
  --                         override_generic_sorter = true,
  --                         override_file_sorter = true,
  --                         case_mode = 'smart_case',
  --                     },
  --                 },
  --             })
  --
  --             telescope.load_extension('fzf')
  --         end,
  --     },
  --
  --     -- File explorer (NERDTree replacement)
  --     {
  --         'nvim-tree/nvim-tree.lua',
  --         dependencies = { 'nvim-tree/nvim-web-devicons' },
  --         keys = {
  --             { '<F10>', '<cmd>NvimTreeFindFile<cr>', desc = 'Find File in Tree' },
  --             { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle File Tree' },
  --         },
  --         config = function()
  --             require('nvim-tree').setup({
  --                 disable_netrw = true,
  --                 hijack_netrw = true,
  --                 view = {
  --                     width = 30,
  --                 },
  --                 renderer = {
  --                     group_empty = true,
  --                     icons = {
  --                         show = {
  --                             git = true,
  --                             folder = true,
  --                             file = true,
  --                             folder_arrow = true,
  --                         },
  --                     },
  --                 },
  --                 filters = {
  --                     dotfiles = false,
  --                     custom = { '.git', 'node_modules', '.cache' },
  --                 },
  --             })
  --         end,
  --     },
  --
  --     -- Tagbar replacement
  --     {
  --         'stevearc/aerial.nvim',
  --         keys = {
  --             { '<F8>', '<cmd>AerialToggle<cr>', desc = 'Toggle Outline' },
  --         },
  --         config = function()
  --             require('aerial').setup({
  --                 backends = { 'lsp', 'treesitter', 'markdown', 'man' },
  --                 layout = {
  --                     default_direction = 'right',
  --                     min_width = 30,
  --                 },
  --                 attach_mode = 'global',
  --                 close_on_select = false,
  --             })
  --         end,
  --     },
  --
  --     -- Ack.vim replacement (better search)
  --     {
  --         'mhinz/vim-grepper',
  --         cmd = 'Grepper',
  --         keys = {
  --             { '<leader>g', '<cmd>Grepper<cr>', desc = 'Grep Search' },
  --         },
  --     },
}
