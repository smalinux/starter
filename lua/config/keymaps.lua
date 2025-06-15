-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- ============================================================================
-- ============================================================================
-- ============================================================================

-- TOC:
-- Lazy.nvim Quick Reference
-- Comment.nvim Keybindings Cheatsheet -- gc
-- aerial.nvim Keybindings & Usage Cheatsheet -- F8
-- LSP -- How to use
-- Mason.nvim Quick Reference - Package Manager for LSP/DAP/Linters/Formatters
-- <leader>c (Code) keybindings


-- ============================================================================
-- Lazy.nvim Quick Reference
-- ============================================================================
-- :Lazy         - Open plugin manager UI
-- :Lazy sync    - Sync all plugins (clean + install + update)
-- :Lazy update  - Update all plugins
-- :Lazy clean   - Remove unused plugins
-- :Lazy check   - Check for updates
-- :Lazy profile - Show startup performance
-- In UI: I=install, U=update, S=sync, X=clean, C=check, ?=help, /=search, q=quit
--

-- ============================================================================
-- Comment.nvim Keybindings Cheatsheet
-- ============================================================================

-- BASIC OPERATOR-PENDING MAPPINGS (NORMAL mode)
-- ============================================================================
-- gc{motion}       - Toggle linewise comment (e.g., gc2j, gcap, gciw)
-- gb{motion}       - Toggle blockwise comment (e.g., gb2j, gbap, gbiw)
-- gcc              - Toggle linewise comment on current line
-- gbc              - Toggle blockwise comment on current line
-- [count]gcc       - Toggle linewise comment on [count] lines
-- [count]gbc       - Toggle blockwise comment on [count] lines

-- VISUAL MODE MAPPINGS
-- ============================================================================
-- gc               - Toggle linewise comment on visual selection
-- gb               - Toggle blockwise comment on visual selection

-- EXTRA MAPPINGS (INSERT mode shortcuts)
-- ============================================================================
-- gco              - Insert comment below current line and enter INSERT mode
-- gcO              - Insert comment above current line and enter INSERT mode
-- gcA              - Insert comment at end of line and enter INSERT mode

-- ============================================================================
-- USAGE EXAMPLES
-- ============================================================================
-- gcc              - Comment/uncomment current line
-- 3gcc             - Comment/uncomment 3 lines starting from current
-- gc2j             - Comment/uncomment current line + 2 lines below
-- gcap             - Comment/uncomment around paragraph
-- gciw             - Comment/uncomment inner word
-- gc$              - Comment from cursor to end of line
-- gcG              - Comment from current line to end of file
-- gbc              - Block comment current line
-- gb2j             - Block comment current line + 2 lines below

-- VISUAL MODE EXAMPLES
-- Select lines with V or v, then:
-- gc               - Comment/uncomment selection (linewise)
-- gb               - Comment/uncomment selection (blockwise)

-- ============================================================================
-- PLUG MAPPINGS (for custom keybindings)
-- ============================================================================
-- <Plug>(comment_toggle_linewise)          - Toggle linewise (operator-pending)
-- <Plug>(comment_toggle_blockwise)         - Toggle blockwise (operator-pending)
-- <Plug>(comment_toggle_linewise_current)  - Toggle linewise current line
-- <Plug>(comment_toggle_blockwise_current) - Toggle blockwise current line
-- <Plug>(comment_toggle_linewise_count)    - Toggle linewise with count
-- <Plug>(comment_toggle_blockwise_count)   - Toggle blockwise with count
-- <Plug>(comment_toggle_linewise_visual)   - Toggle linewise in visual mode
-- <Plug>(comment_toggle_blockwise_visual)  - Toggle blockwise in visual mode
--


-- ============================================================================
-- aerial.nvim Keybindings & Usage Cheatsheet
-- ============================================================================
-- aerial.nvim provides a code outline window that displays symbols from LSP,
-- treesitter, or other backends (functions, classes, variables, etc.)
-- ============================================================================





-- ============================================================================
-- ============================================================================
-- ============================================================================
--
-- ============================================================================
-- LSP -- How to use
-- ============================================================================
--
-- <leader>cr: LSP rename - renames variable/function/symbol across all files in project 🌟

-- LSP Navigation
-- gd: Go to definition - jump to where symbol is defined
-- gr: Go to references - list all references of symbol under cursor
-- gI: Go to implementation - jump to implementation of interface/abstract method
-- gy: Go to type definition - jump to type definition
-- gD: Go to declaration - jump to declaration (C/C++)
-- K: Hover documentation - show documentation for symbol under cursor
-- gK: Signature help - show function signature

-- SMA: NOT so important
-- LSP Diagnostics Navigation
-- ]d: Next diagnostic - jump to next error/warning
-- [d: Previous diagnostic - jump to previous error/warning
-- ]e: Next error - jump to next error only
-- [e: Previous error - jump to previous error only
-- ]w: Next warning - jump to next warning only
-- [w: Previous warning - jump to previous warning only

-- LSP Workspace
-- <leader>cl: LSP info - show active LSP clients and their status
-- <leader>cL: LspLog - open LSP log file

-- LSP Commands Reference
-- :LspInfo          - Show active LSP clients, capabilities, root dirs
--                     Keybinding: <leader>cl
-- :LspStart [name]  - Start LSP server(s) for current buffer
-- :LspStop [id]     - Stop LSP client(s)
-- :LspRestart [id]  - Restart LSP client(s) (useful after config changes)
-- :LspLog           - Open LSP log file (~/.local/state/nvim/lsp.log)

-- ============================================================================
-- <leader>c (Code) keybindings
-- ============================================================================
-- a  = Code Action (LSP actions for current context) 🌟
-- A  = Source Action (broader scope code actions)
-- h  = Switch Source/Header (C/C++ toggle between .c/.h files) 🌟
-- l  = LSP Info (show active language servers)
-- r  = Rename (LSP symbol rename across workspace) 🌟
-- d  = Line Diagnostics (show diagnostics for current line)
-- f  = Format buffer 🌟
-- F  = Format Injected Languages
-- m  = Mason (package manager)
-- s  = Aerial (symbol outline)
-- S  = Trouble LSP (references, definitions, diagnostics) 🌟

-- ============================================================================
-- Mason.nvim Quick Reference - Package Manager for LSP/DAP/Linters/Formatters
-- ============================================================================
-- Opening: :Mason | <leader>cm
--
-- UI Commands:
--   i           - Install package under cursor
--   u           - Update package under cursor
--   U           - Update all installed packages
--   X           - Uninstall package under cursor
--   /           - Search packages by name
--   f           - Filter by type (LSP/DAP/Linter/Formatter)
--   1-4         - Jump to category (1=LSP, 2=DAP, 3=Linter, 4=Formatter)
--   <CR>        - Show package details/info
--   <C-c>       - Cancel current installation
--   g?  or  ?   - Toggle help
--   q           - Close Mason window
--
-- Direct Commands:
--   :Mason                      - Open Mason UI
--   :MasonInstall <pkg> [...]   - Install one or more packages
--   :MasonUninstall <pkg>       - Uninstall package
--   :MasonUpdate                - Update package under cursor
--   :MasonUpdateAll             - Update all packages
--   :MasonLog                   - View Mason log file
--
-- Package Categories:
--   LSP Servers  (1)  - Language servers (clangd, pyright, lua_ls, etc.)
--   DAP Servers  (2)  - Debug adapters (codelldb, debugpy, etc.)
--   Linters      (3)  - Code linters (cpplint, shellcheck, pylint, etc.)
--   Formatters   (4)  - Code formatters (clang-format, black, stylua, etc.)
--
-- Common Packages (C/Embedded/Python):
--   clangd              - C/C++ LSP (language server)
--   clang-format        - C/C++ formatter
--   codelldb            - C/C++ debugger (DAP)
--   cppcheck            - C/C++ static analyzer
--   cpplint             - C++ linter
--   lua-language-server - Lua LSP
--   stylua              - Lua formatter
--   pyright             - Python LSP
--   black               - Python formatter
--   pylint              - Python linter
--   debugpy             - Python debugger
--   bash-language-server- Bash LSP
--   shellcheck          - Shell script linter
--   shfmt               - Shell script formatter
--
-- Installation Path: ~/.local/share/nvim/mason/packages/
-- Binary Path: ~/.local/share/nvim/mason/bin/
--
-- Typical Workflow:
--   1. :Mason                    - Open UI
--   2. /clangd                   - Search for package
--   3. i                         - Install
--   4. U (periodically)          - Update all packages
--
-- Pro Tips:
--   - Use :MasonInstall with multiple packages: :MasonInstall clangd clang-format codelldb
--   - Filter with 'f' then navigate filtered results
--   - Press <CR> on package to see detailed info, homepage, and commands
--   - Mason auto-integrates with nvim-lspconfig and conform.nvim
--   - Check :MasonLog if installation fails



-- ============================================================================
-- ============================================================================
-- ============================================================================
-- toggle AerialToggle: side panel on right for outline functions
vim.keymap.set("n", "<F8>", "<cmd>AerialToggle!<CR>")

-- Git blame current file
vim.keymap.set("n", "<F9>", "<cmd>Git blame<CR>")

-- Paste over selection without yanking the deleted text into default register
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without yanking deleted text" })


-- -- Keymaps Configuration
-- local map = vim.keymap.set
-- local opts = { noremap = true, silent = true }
--
-- -- Clear search highlighting
-- map('n', '<Esc>', '<cmd>noh<CR><Esc>', opts)
--
-- -- Window navigation
-- map('n', '<C-h>', '<C-w>h', opts)
-- map('n', '<C-j>', '<C-w>j', opts)
-- map('n', '<C-k>', '<C-w>k', opts)
-- map('n', '<C-l>', '<C-w>l', opts)
--
-- -- Terminal window navigation
-- map('t', '<C-h>', '<C-\\><C-n><C-h>', opts)
-- map('t', '<C-j>', '<C-\\><C-n><C-j>', opts)
-- map('t', '<C-k>', '<C-\\><C-n><C-k>', opts)
-- map('t', '<C-l>', '<C-\\><C-n><C-l>', opts)
--
-- -- Window resizing (using arrow keys since they're disabled for movement)
-- map('n', '<Right>', '<cmd>vertical resize +5<CR>', opts)
-- map('n', '<Left>', '<cmd>vertical resize -5<CR>', opts)
-- map('n', '<Up>', '<cmd>resize +5<CR>', opts)
-- map('n', '<Down>', '<cmd>resize -5<CR>', opts)
--
-- -- Better window split
-- map('n', '<C-w>n', '<C-w>s', opts)
--
-- -- Close buffer
vim.keymap.set("n", "<F12>", "<cmd>bd<CR>", { desc = "Delete buffer" })
--
-- -- Record macro on Q instead of q
-- map('n', 'Q', 'q', opts)
-- map('n', 'q', '<Nop>', opts)
--
-- -- Disable leader+s
-- map('n', '<leader>s', '<Nop>', opts)
--
-- -- Tab management
-- map('n', '<leader>tt', '<cmd>tabnew<CR>', opts)
-- map('n', '<leader>tq', '<cmd>tabclose<CR>', opts)
--
-- -- Better visual mode paste (don't yank replaced text)
-- map('v', 'p', '"_dP', opts)
--
-- -- Man pages
-- vim.cmd([[
--     runtime! ftplugin/man.vim
--     command! -nargs=* -complete=shellcmd Man vert Man <args>
--     command! -nargs=* -complete=shellcmd Mm vert Man <args>
-- ]])
