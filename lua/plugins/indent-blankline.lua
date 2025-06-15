-- ============================================================================
-- INDENT-BLANKLINE LAZY.NVIM PLUGIN CONFIGURATION
-- Complete guide with all options explained
-- ============================================================================

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    -- ========================================================================
    -- enabled: Controls if indent-blankline is active or not.
    -- Set to false to disable the plugin completely without uninstalling it.
    -- ========================================================================
    enabled = true,
    -- Example: enabled = false  -- Turns off all indentation guides

    -- ========================================================================
    -- debounce: Delay in milliseconds before refreshing the display.
    -- Higher values reduce CPU usage but increase lag when typing fast.
    -- ========================================================================
    debounce = 0,
    -- Example: debounce = 100  -- Faster refresh, more responsive

    -- ========================================================================
    -- VIEWPORT BUFFER CONFIGURATION
    -- ========================================================================
    viewport_buffer = {
      -- min: Number of lines above/below visible area to render guides for.
      -- Larger values show guides when scrolling but use more memory.
      min = 30,
      -- Example: min = 100  -- Render guides 100 lines above/below screen

      -- max: DEPRECATED - Previously limited maximum rendering distance.
      -- This setting no longer has effect, use 'min' instead.
      max = 500,
    },

    -- ========================================================================
    -- INDENT CONFIGURATION
    -- ========================================================================
    indent = {
      -- char: Character(s) used to draw the indentation guide lines.
      -- Can be a single character or array for cycling through multiple chars.
      char = "┊",
      -- Examples:
      -- char = "│"                    -- Center-aligned solid line
      -- char = { "▏", "▎", "▍", "▌" } -- Different width for each level
      -- char = "┊"                    -- Dashed line for subtle look

      -- tab_char: Character(s) for tab indentation guides specifically.
      -- Falls back to 'char' if not set; uses listchars if list mode is on.
      tab_char = "→",
      -- Example: tab_char = "→"  -- Arrow for tabs, vertical line for spaces

      -- highlight: Highlight group(s) that color the indent guides.
      -- Array allows different colors for different indentation levels.
      highlight = "IblIndent",
      -- Examples:
      -- highlight = "Comment"                    -- Use comment color
      -- highlight = { "Function", "String" }     -- Cycle through colors
      -- highlight = { "IblIndent1", "IblIndent2", "IblIndent3" }  -- Custom

      -- smart_indent_cap: Limits indent levels based on surrounding code.
      -- Prevents excessive indentation in function arguments spanning lines.
      smart_indent_cap = false, -- SMA: DONE
      -- Example: Wraps function(arg1, arg2,
      --                         arg3)  -- Shows only 1 indent, not 4

      -- priority: Virtual text priority (higher numbers appear on top).
      -- Increase if guides are hidden behind other virtual text.
      priority = 1,
      -- Example: priority = 10  -- Make guides appear above most other text

      -- repeat_linebreak: Shows guides on wrapped lines when breakindent is set.
      -- Maintains visual indentation structure on long wrapped lines.
      repeat_linebreak = true,
      -- Example: Long line that wraps
      --          ▎ continues with guide  -- When true
    },

    -- ========================================================================
    -- WHITESPACE CONFIGURATION
    -- ========================================================================
    whitespace = {
      -- highlight: Highlight group(s) for whitespace characters.
      -- Controls the color of spaces and tabs between indent guides.
      highlight = "IblWhitespace",
      -- Example: highlight = "NonText"  -- Use same color as hidden chars

      -- remove_blankline_trail: Removes trailing whitespace on empty lines.
      -- Disable this if you want background colors on blank lines.
      remove_blankline_trail = false, -- SMA: DONE
      -- Example: False shows whitespace highlight on entire blank line
    },

    -- ========================================================================
    -- SCOPE CONFIGURATION
    -- Scope = code block where variables/functions are accessible
    -- ========================================================================
    scope = {
      -- enabled: Shows special highlighting for the current code scope.
      -- Requires treesitter to identify scope based on cursor position.
      enabled = true,
      -- Example: Highlights the function/block your cursor is currently in

      -- char: Character(s) used for the scope indentation guide.
      -- Defaults to indent.char; typically uses same or bolder character.
      char = "▎",
      -- Example: char = "┃"  -- Thicker line for current scope

      -- show_start: Draws an underline at the scope's opening line.
      -- Visually marks where the current scope begins (e.g., function start).
      show_start = true,
      -- Example: def function():
      --          ▔▔▔▔▔▔▔▔▔▔  -- Underline on function definition

      -- show_end: Draws an underline at the scope's closing line.
      -- Visually marks where the current scope ends (e.g., closing brace).
      show_end = true,
      -- Example:     return value
      --          ▁▁▁▁▁▁▁▁▁▁  -- Underline on last line of scope

      -- show_exact_scope: Underlines exact start/end of scope, not just indent.
      -- Shows precise scope boundaries including text beyond indent guide.
      show_exact_scope = false,
      -- Example: for (int i; i < 10; i++) {
      --              ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔  -- Entire line underlined

      -- injected_languages: Checks for scope in embedded language blocks.
      -- Finds scope in things like Lua inside Vim config or SQL in Python.
      injected_languages = true,
      -- Example: Detects scope inside ```lua code blocks in markdown

      -- highlight: Highlight group(s) for scope indentation guide.
      -- Makes current scope stand out with different color than normal indent.
      highlight = "IblScope",
      -- Examples:
      -- highlight = "Function"                -- Use function color
      -- highlight = { "Red", "Yellow", "Green" }  -- Cycle colors by depth

      -- priority: Virtual text priority for scope guides (higher = on top).
      -- Higher than indent.priority so scope guides appear over normal guides.
      priority = 1024,
      -- Example: priority = 2000  -- Ensure scope always visible

      -- ======================================================================
      -- SCOPE INCLUDE CONFIGURATION
      -- ======================================================================
      include = {
        -- node_type: Additional treesitter nodes to treat as valid scopes.
        -- Extends default scope detection with language-specific constructs.
        node_type = {},
        -- Examples:
        -- node_type = { lua = { "table_constructor" } }  -- Tables as scope
        -- node_type = { ["*"] = { "*" } }  -- Everything is scope (chaotic!)
      },

      -- ======================================================================
      -- SCOPE EXCLUDE CONFIGURATION
      -- ======================================================================
      exclude = {
        -- language: Treesitter languages where scope is completely disabled.
        -- Useful for languages where scope highlighting is distracting.
        language = {},
        -- Example: language = { "markdown", "text" }  -- No scope in docs

        -- node_type: Specific node types that should never be scopes.
        -- Prevents certain code structures from being highlighted as scope.
        node_type = {
          ["*"] = { "source_file", "program" },
          lua = { "chunk" },
          python = { "module" },
        },
        -- Example: node_type = { rust = { "use_declaration" } }
        -- Prevents 'use' statements from being scope boundaries
      },
    },

    -- ========================================================================
    -- EXCLUDE CONFIGURATION
    -- ========================================================================
    exclude = {
      -- filetypes: File types where indent-blankline is completely disabled.
      -- Plugin won't run at all in these buffer types to avoid interference.
      filetypes = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "",
      },
      -- Example: filetypes = { "markdown", "json" }  -- Disable in these

      -- buftypes: Buffer types where indent-blankline is disabled.
      -- Prevents guides from appearing in special Neovim buffer types.
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
      -- Example: buftypes = { "terminal", "help" }  -- Skip these buffers
    },
  },

  -- ==========================================================================
  -- LAZY.NVIM SPECIFIC CONFIG
  -- ==========================================================================
  event = { "BufReadPost", "BufNewFile" }, -- Load on opening files
  -- Alternative loading strategies:
  -- event = "VeryLazy",  -- Load after UI is ready
  -- lazy = false,        -- Load immediately on startup

  -- ==========================================================================
  -- ADVANCED CONFIGURATION WITH HOOKS
  -- ==========================================================================
  config = function(_, opts)
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")

    -- Apply base configuration
    ibl.setup(opts)

    -- ========================================================================
    -- CUSTOM HIGHLIGHT GROUPS
    -- Define colors before plugin creates highlight groups
    -- ========================================================================
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Single color for all indents
      -- vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4252", nocombine = true })
            vim.api.nvim_set_hl(0, "IblIndent", { fg = "#ff0000" })
      vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#2e3440", nocombine = true })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#88c0d0", nocombine = true })

      -- Multiple colors for rainbow indentation (uncomment to use)
      -- vim.api.nvim_set_hl(0, "IblIndent1", { fg = "#E06C75", nocombine = true })
      -- vim.api.nvim_set_hl(0, "IblIndent2", { fg = "#E5C07B", nocombine = true })
      -- vim.api.nvim_set_hl(0, "IblIndent3", { fg = "#98C379", nocombine = true })
      -- vim.api.nvim_set_hl(0, "IblIndent4", { fg = "#56B6C2", nocombine = true })
      -- vim.api.nvim_set_hl(0, "IblIndent5", { fg = "#61AFEF", nocombine = true })
      -- vim.api.nvim_set_hl(0, "IblIndent6", { fg = "#C678DD", nocombine = true })

      -- Scope highlight colors for rainbow effect (uncomment to use)
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
      -- vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
    end)

    -- ========================================================================
    -- HOOK 1: Performance optimization for large files
    -- Disables plugin in files with more than 5000 lines
    -- ========================================================================
    hooks.register(hooks.type.ACTIVE, function(bufnr)
      return vim.api.nvim_buf_line_count(bufnr) < 5000
    end)

    -- ========================================================================
    -- HOOK 2: Skip preprocessor lines in C/C++
    -- Automatically hides indent guides on lines starting with #
    -- ========================================================================
    -- hooks.register(
    --   hooks.type.SKIP_LINE,
    --   hooks.builtin.skip_preproc_lines,
    --   { bufnr = 0 }
    -- )

    -- ========================================================================
    -- HOOK 3: Sync scope colors with rainbow delimiters
    -- Makes scope highlight colors match rainbow parentheses colors
    -- ========================================================================
    -- local rainbow_highlight = {
    --   "RainbowDelimiterRed",
    --   "RainbowDelimiterYellow",
    --   "RainbowDelimiterBlue",
    --   "RainbowDelimiterOrange",
    --   "RainbowDelimiterGreen",
    --   "RainbowDelimiterViolet",
    --   "RainbowDelimiterCyan",
    -- }
    -- hooks.register(
    --   hooks.type.SCOPE_HIGHLIGHT,
    --   hooks.builtin.scope_highlight_from_extmark
    -- )

    -- ========================================================================
    -- HOOK 4: Hide first indentation level
    -- Removes the first indent guide for a cleaner minimal look
    -- ========================================================================
    -- hooks.register(
    --   hooks.type.WHITESPACE,
    --   hooks.builtin.hide_first_space_indent_level
    -- )

    -- ========================================================================
    -- HOOK 5: Hide first tab indentation level
    -- Replaces first tab indent with listchars tab fill character
    -- ========================================================================
    -- hooks.register(
    --   hooks.type.WHITESPACE,
    --   hooks.builtin.hide_first_tab_indent_level
    -- )

    -- ========================================================================
    -- HOOK 6: Custom skip line logic
    -- Example: Skip lines that are comments or empty
    -- ========================================================================
    -- hooks.register(hooks.type.SKIP_LINE, function(tick, bufnr, row, line)
    --   -- Skip empty lines
    --   if line:match("^%s*$") then
    --     return true
    --   end
    --   -- Skip comment lines (example for Lua/Python)
    --   if line:match("^%s*[-#][-#]") or line:match("^%s*#") then
    --     return true
    --   end
    --   return false
    -- end)

    -- ========================================================================
    -- HOOK 7: Custom virtual text modification
    -- Example: Add custom characters or modify existing ones
    -- ========================================================================
    -- hooks.register(hooks.type.VIRTUAL_TEXT, function(tick, bufnr, row, virt_text)
    --   -- Modify the virtual text array here
    --   -- Each element is { "character", "highlight_group" }
    --   return virt_text
    -- end)

    -- ========================================================================
    -- HOOK 8: Disable scope in specific conditions
    -- Example: Disable scope highlighting when in insert mode
    -- ========================================================================
    -- hooks.register(hooks.type.SCOPE_ACTIVE, function(bufnr)
    --   local mode = vim.api.nvim_get_mode().mode
    --   return mode ~= "i"  -- Disable in insert mode
    -- end)
  end,
}

-- ============================================================================
-- USAGE COMMANDS (available after plugin loads)
-- ============================================================================
--
-- :IBLEnable         - Turn on indent guides
-- :IBLDisable        - Turn off indent guides
-- :IBLToggle         - Toggle guides on/off
-- :IBLEnableScope    - Enable scope highlighting
-- :IBLDisableScope   - Disable scope highlighting
-- :IBLToggleScope    - Toggle scope highlighting
--
-- ============================================================================

-- ============================================================================
-- RECOMMENDED PRESET CONFIGURATIONS
-- Replace the entire opts table with one of these
-- ============================================================================

-- PRESET 1: Minimal and Clean
-- opts = {
--   indent = { char = "│" },
--   scope = { enabled = false },
-- }

-- PRESET 2: Rainbow Indentation (requires custom highlights)
-- opts = {
--   indent = {
--     char = "▎",
--     highlight = {
--       "IblIndent1", "IblIndent2", "IblIndent3",
--       "IblIndent4", "IblIndent5", "IblIndent6",
--     },
--   },
-- }

-- PRESET 3: Subtle and Performance-Focused
-- opts = {
--   indent = { char = "┊", smart_indent_cap = true },
--   scope = { enabled = false },
--   debounce = 100,
-- }

-- PRESET 4: Maximum Information
-- opts = {
--   indent = { char = "▎" },
--   scope = {
--     enabled = true,
--     show_start = true,
--     show_end = true,
--     show_exact_scope = true,
--   },
-- }

-- PRESET 5: Different characters per level
-- opts = {
--   indent = {
--     char = { "│", "┊", "┆", "┊" },
--   },
-- }

-- PRESET 6: With rainbow delimiters integration
-- opts = {
--   scope = {
--     highlight = {
--       "RainbowDelimiterRed",
--       "RainbowDelimiterYellow",
--       "RainbowDelimiterBlue",
--       "RainbowDelimiterOrange",
--       "RainbowDelimiterGreen",
--       "RainbowDelimiterViolet",
--       "RainbowDelimiterCyan",
--     },
--   },
-- }

-- ============================================================================
-- PROGRAMMATIC USAGE EXAMPLES
-- ============================================================================

-- Update configuration dynamically:
-- require("ibl").update({ enabled = false })

-- Overwrite specific settings:
-- require("ibl").overwrite({ indent = { char = "│" } })

-- Configure for specific buffer only:
-- require("ibl").setup_buffer(0, { indent = { char = "┊" } })

-- Force refresh display:
-- require("ibl").refresh(0)

-- Debounced refresh (recommended):
-- require("ibl").debounced_refresh(0)

-- Refresh all buffers:
-- require("ibl").refresh_all()

-- ============================================================================
-- CHARACTER ALTERNATIVES FOR INDENT GUIDES
-- ============================================================================

-- Left-aligned solid:   ▏ ▎ ▍ ▌ ▋ ▊ ▉ █
-- Center-aligned solid: │ ┃
-- Right-aligned solid:  ▕ ▐
-- Center-aligned dashed: ╎ ╏ ┆ ┇ ┊ ┋
-- Center-aligned double: ║

-- ============================================================================
-- TROUBLESHOOTING
-- ============================================================================

-- If guides don't appear:
-- 1. Check if filetype is in exclude.filetypes
-- 2. Verify treesitter is installed for scope
-- 3. Check if file is too large (see ACTIVE hook)
-- 4. Run :IBLEnable to manually enable

-- If performance is slow:
-- 1. Increase debounce value (e.g., 300)
-- 2. Decrease viewport_buffer.min (e.g., 10)
-- 3. Disable scope highlighting
-- 4. Add ACTIVE hook to skip large files

-- If colors don't match your theme:
-- 1. Define custom highlight groups in HIGHLIGHT_SETUP hook
-- 2. Or link to existing groups: vim.cmd("hi link IblIndent Comment")

-- ============================================================================
