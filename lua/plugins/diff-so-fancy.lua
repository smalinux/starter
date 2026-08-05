-- diff-so-fancy.nvim — https://github.com/smalinux/diff-so-fancy.nvim
--
--   <leader>gx     : Toggle inline diff globally (all buffers): removed lines
--                    as virtual lines, word-diff highlights on added lines
--   :FancyDiff ... : Any git diff in a float, e.g. :FancyDiff --staged,
--                    :FancyDiff HEAD~3 — q / <Esc> to close
return {
  {
    "smalinux/diff-so-fancy.nvim",
    main = "diff-so-fancy",
    opts = {},
    cmd = "FancyDiff",
    keys = {
      {
        "<leader>gx",
        function()
          require("diff-so-fancy").toggle()
        end,
        desc = "Toggle Inline Diff (diff-so-fancy)",
      },
    },
  },
}
