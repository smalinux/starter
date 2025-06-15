-- ============================================================================
-- Auto-restore last session on startup, preserving all buffers, windows, and cursor positions
-- Ensures seamless continuation of work across Neovim restarts
-- ============================================================================
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
  },
  -- keys = {
  --   { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
  --   { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
  --   { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  -- },
  init = function()
    -- Auto-restore session on startup if nvim was opened without arguments
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
      callback = function()
        if vim.fn.argc() == 0 then
          require("persistence").load()
        end
      end,
      nested = true,
    })
  end,
}
