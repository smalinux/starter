-- -- ~/.config/nvim/lua/plugins/noice-minimal.lua
-- -- Minimal noice.nvim configuration - just centered command line
--
return {
  --   {
  --     "folke/noice.nvim",
  --     event = "VeryLazy",
  --     dependencies = {
  --       "MunifTanjim/nui.nvim",
  --     },
  --     opts = {
  --       -- Disable most features, keep only cmdline
  --       lsp = {
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true,
  --         },
  --       },
  --       -- Enable centered command line
  --       cmdline = {
  --         enabled = true,
  --         view = "cmdline_popup",
  --         format = {
  --           cmdline = { pattern = "^:", icon = "", lang = "vim" },
  --           search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
  --           search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
  --           filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
  --           lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
  --           help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
  --           input = {},
  --         },
  --       },
  --       -- Configure the centered popup
  --       views = {
  --         cmdline_popup = {
  --           position = {
  --             row = "50%",
  --             col = "50%",
  --           },
  --           size = {
  --             width = "auto",
  --             height = "auto",
  --           },
  --           border = {
  --             style = "rounded",
  --             padding = { 0, 1 },
  --           },
  --         },
  --       },
  --       -- Disable messages and notifications (keep default behavior)
  --       messages = { enabled = false },
  --       notify = { enabled = false },
  --     },
  --   },
}
