-- -- UI and Appearance Plugins
return {
  -- Status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  -- pop notes
  {
    "folke/noice.nvim",
    enabled = false,  -- Disable noice completely
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline", -- Use bottom cmdline instead of popup
      },
      messages = {
        enabled = true,
        view = "mini", -- Minimal message view
      },
      popupmenu = {
        enabled = false, -- Disable popup menu
      },
    },
  },
-- stevearc/aerial.nvim: Code outline sidebar that displays document symbols (functions, classes, variables)
-- using LSP or Treesitter, providing quick navigation and overview of code structure
  {
    'stevearc/aerial.nvim',
    opts = {
      backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

      layout = {
        max_width = { 60, 0.35 },
        width = nil,
        min_width = 20,
        win_opts = {},
        default_direction = "prefer_right",
        placement = "window",
        resize_to_content = true,
        preserve_equality = false,
      },

      attach_mode = "window",
      close_automatic_events = {},

      keymaps = {
        ["?"] = "actions.show_help",
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["p"] = "actions.scroll",
        ["<C-j>"] = "actions.down_and_scroll",
        ["<C-k>"] = "actions.up_and_scroll",
        ["{"] = "actions.prev",
        ["}"] = "actions.next",
        ["[["] = "actions.prev_up",
        ["]]"] = "actions.next_up",
        ["q"] = "actions.close",
        ["o"] = "actions.tree_toggle",
        ["za"] = "actions.tree_toggle",
        ["O"] = "actions.tree_toggle_recursive",
        ["zA"] = "actions.tree_toggle_recursive",
        ["l"] = "actions.tree_open",
        ["zo"] = "actions.tree_open",
        ["L"] = "actions.tree_open_recursive",
        ["zO"] = "actions.tree_open_recursive",
        ["h"] = "actions.tree_close",
        ["zc"] = "actions.tree_close",
        ["H"] = "actions.tree_close_recursive",
        ["zC"] = "actions.tree_close_recursive",
        ["zr"] = "actions.tree_increase_fold_level",
        ["zR"] = "actions.tree_open_all",
        ["zm"] = "actions.tree_decrease_fold_level",
        ["zM"] = "actions.tree_close_all",
        ["zx"] = "actions.tree_sync_folds",
        ["zX"] = "actions.tree_sync_folds",
      },

      lazy_load = true,
      disable_max_lines = 10000,
      disable_max_size = 2000000,

      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        "Variable",
        "Constant",
        "TypeParameter",
        "Field",
      },

      highlight_mode = "split_width",
      highlight_closest = true,
      highlight_on_hover = false,
      highlight_on_jump = 300,

      -- Enable autojump: cursor moves in source window when you navigate in aerial
      autojump = true,

      icons = {},

      ignore = {
        unlisted_buffers = false,
        diff_windows = true,
        filetypes = {},
        buftypes = "special",
        wintypes = "special",
      },

      manage_folds = false,
      link_folds_to_tree = false,
      link_tree_to_folds = true,
      nerd_font = "auto",

      on_attach = function(bufnr) end,
      on_first_symbols = function(bufnr) end,

      open_automatic = false,
      post_jump_cmd = "normal! zz",

      post_parse_symbol = function(bufnr, item, ctx)
        if ctx.backend_name == "lsp" and ctx.symbol then
          local detail = ctx.symbol.detail or ""
          local kind = ctx.symbol.kind

          -- Read the actual line from the buffer to check for static
          local line_content = vim.api.nvim_buf_get_lines(bufnr, item.lnum - 1, item.lnum, false)[1] or ""

          local prefix = ""
          local suffix = ""

          -- Check if function/variable is static by examining the source line
          if line_content:match("^%s*static%s+") or line_content:match("^static%s+") then
            prefix = "🔒 "  -- or use "[S] " if you prefer text
          end

          -- Add return type for functions from detail
          if (kind == 12 or item.kind == "Function") and detail ~= "" then
            -- Clean up detail and extract return type
            local return_type = detail:match("^[^%(]+")
            if return_type then
              return_type = return_type:gsub("^%s+", ""):gsub("%s+$", "")
              return_type = return_type:gsub("^static%s+", "")
              return_type = return_type:gsub("^inline%s+", "")
              return_type = return_type:gsub("^extern%s+", "")

              if return_type ~= "" and return_type ~= item.name then
                suffix = " → " .. return_type
              end
            end
          end

          item.name = prefix .. item.name .. suffix
        end
        return true
      end,

      post_add_all_symbols = function(bufnr, items, ctx)
        return items
      end,

      close_on_select = false,
      update_events = "TextChanged,InsertLeave",

      show_guides = true,

      guides = {
        mid_item = "├─",
        last_item = "└─",
        nested_top = "│ ",
        whitespace = "  ",
      },

      get_highlight = function(symbol, is_icon, is_collapsed)
      end,

      float = {
        border = "rounded",
        relative = "cursor",
        max_height = 0.9,
        height = nil,
        min_height = { 8, 0.1 },
        override = function(conf, source_winid)
          return conf
        end,
      },

      nav = {
        border = "rounded",
        max_height = 0.9,
        min_height = { 10, 0.1 },
        max_width = 0.5,
        min_width = { 0.2, 20 },
        win_opts = {
          cursorline = true,
          winblend = 10,
        },
        autojump = false,
        preview = false,
        keymaps = {
          ["<CR>"] = "actions.jump",
          ["<2-LeftMouse>"] = "actions.jump",
          ["<C-v>"] = "actions.jump_vsplit",
          ["<C-s>"] = "actions.jump_split",
          ["h"] = "actions.left",
          ["l"] = "actions.right",
          ["<C-c>"] = "actions.close",
        },
      },

      lsp = {
        diagnostics_trigger_update = true,
        update_when_errors = true,
        update_delay = 300,
        priority = {
          clangd = 15,
        },
      },

      treesitter = {
        update_delay = 300,
      },

      markdown = {
        update_delay = 300,
      },

      asciidoc = {
        update_delay = 300,
      },

      man = {
        update_delay = 300,
      },
    },
  },
-- sphamba/smear-cursor.nvim: Animated cursor movement
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,

      -- cursor_color = "#ff0000",
    },
  },
  --     -- Colorscheme (luna-term replacement)
  --     {
  --         'folke/tokyonight.nvim',
  --         lazy = false,
  --         priority = 1000,
  --         config = function()
  --             require('tokyonight').setup({
  --                 style = 'night',
  --                 transparent = true,
  --             })
  --             vim.cmd([[colorscheme tokyonight]])
  --             -- Make background transparent
  --             vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
  --         end,
  --     },
  --
  --     -- Status line (airline replacement)
  --     {
  --         'nvim-lualine/lualine.nvim',
  --         dependencies = { 'nvim-tree/nvim-web-devicons' },
  --         config = function()
  --             require('lualine').setup({
  --                 options = {
  --                     theme = 'auto',
  --                     section_separators = '',
  --                     component_separators = '|',
  --                 },
  --                 sections = {
  --                     lualine_a = { 'mode' },
  --                     lualine_b = { 'branch', 'diff', 'diagnostics' },
  --                     lualine_c = { 'filename' },
  --                     lualine_x = { 'encoding', 'fileformat' },
  --                     lualine_y = {},
  --                     lualine_z = {
  --                         function()
  --                             return string.format('%d%%%% 👻 %d/%d 👻 Col:%d',
  --                                 math.floor((vim.fn.line('.') / vim.fn.line('$')) * 100),
  --                                 vim.fn.line('.'),
  --                                 vim.fn.line('$'),
  --                                 vim.fn.col('.')
  --                             )
  --                         end
  --                     },
  --                 },
  --                 tabline = {
  --                     lualine_a = { 'buffers' },
  --                     lualine_b = {},
  --                     lualine_c = {},
  --                     lualine_x = {},
  --                     lualine_y = {},
  --                     lualine_z = { 'tabs' },
  --                 },
  --             })
  --         end,
  --     },
  --
  --     -- Rainbow brackets
  --     {
  --         'HiPhish/rainbow-delimiters.nvim',
  --         config = function()
  --             local rainbow_delimiters = require('rainbow-delimiters')
  --             vim.g.rainbow_delimiters = {
  --                 strategy = {
  --                     [''] = rainbow_delimiters.strategy['global'],
  --                 },
  --                 query = {
  --                     [''] = 'rainbow-delimiters',
  --                 },
  --                 highlight = {
  --                     'RainbowDelimiterRed',
  --                     'RainbowDelimiterYellow',
  --                     'RainbowDelimiterBlue',
  --                     'RainbowDelimiterOrange',
  --                     'RainbowDelimiterGreen',
  --                     'RainbowDelimiterViolet',
  --                     'RainbowDelimiterCyan',
  --                 },
  --             }
  --         end,
  --     },
  --
  --     -- Indent guides
  --     {
  --         'lukas-reineke/indent-blankline.nvim',
  --         main = 'ibl',
  --         config = function()
  --             require('ibl').setup({
  --                 indent = {
  --                     char = '┊',
  --                 },
  --             })
  --         end,
  --     },
  --
  --     -- Auto pairs
  --     {
  --         'windwp/nvim-autopairs',
  --         event = 'InsertEnter',
  --         config = function()
  --             require('nvim-autopairs').setup({})
  --             -- Integration with nvim-cmp
  --             local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  --             local cmp = require('cmp')
  --             cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  --         end,
  --     },
  --
  --     -- Highlight colors
  --     {
  --         'norcalli/nvim-colorizer.lua',
  --         config = function()
  --             require('colorizer').setup()
  --         end,
  --     },
  --
  --     -- Git signs
  --     {
  --         'lewis6991/gitsigns.nvim',
  --         config = function()
  --             require('gitsigns').setup({
  --                 signs = {
  --                     add = { text = '▎' },
  --                     change = { text = '▎' },
  --                     delete = { text = '▎' },
  --                     topdelete = { text = '▎' },
  --                     changedelete = { text = '▎' },
  --                 },
  --             })
  --         end,
  --     },
  --
  --     -- Zen mode (Goyo replacement)
  --     {
  --         'folke/zen-mode.nvim',
  --         cmd = 'ZenMode',
  --         keys = {
  --             { '<F7>', '<cmd>ZenMode<cr>', desc = 'Zen Mode' },
  --         },
  --         config = function()
  --             require('zen-mode').setup({
  --                 window = {
  --                     width = 0.80,
  --                     height = 0.80,
  --                     options = {
  --                         number = true,
  --                         relativenumber = true,
  --                         linebreak = true,
  --                     },
  --                 },
  --             })
  --         end,
  --     },
  --
  --     -- Tmux navigation
  --     {
  --         'christoomey/vim-tmux-navigator',
  --         lazy = false,
  --     },
  --
  --     -- Which-key (helpful for keybindings)
  --     {
  --         'folke/which-key.nvim',
  --         event = 'VeryLazy',
  --         config = function()
  --             require('which-key').setup({})
  --         end,
  --     },
}
