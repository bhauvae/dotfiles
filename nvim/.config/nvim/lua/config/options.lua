-- lua/config/options.lua
-- Core Neovim options for LazyVim

local opt = vim.opt

----------------------------------------------------------------------------------------------------
-- UI / UX
----------------------------------------------------------------------------------------------------

opt.number = true -- Absolute line numbers
opt.relativenumber = true -- Relative line numbers (flip to false if you hate them)
opt.cursorline = true -- Highlight current line

opt.signcolumn = "yes" -- Always show sign column (LSP, git, diagnostics)
opt.colorcolumn = "100" -- Visual ruler at column 100
opt.wrap = false -- Don't soft-wrap lines
opt.scrolloff = 8 -- Keep lines above/below cursor
opt.sidescrolloff = 8 -- Keep columns left/right of cursor

opt.termguicolors = true -- 24-bit colors
opt.showmode = false -- Don't show mode (statusline handles it)
opt.pumheight = 12 -- Max height of completion menu
opt.pumblend = 10 -- Slight transparency for completion menu
opt.winblend = 0 -- Floating window transparency

opt.conceallevel = 2 -- Good for Markdown / Obsidian-style notes
opt.concealcursor = "" -- Show markup on cursor line as well

-- VS Code-like substitute preview: live preview of :%s/foo/bar
opt.inccommand = "nosplit" -- Show substitution preview inline, no split

-- More stable splits when opening/closing horizontal splits
opt.splitbelow = true -- Horizontal splits open below
opt.splitright = true -- Vertical splits open to the right
opt.splitkeep = "screen" -- Keep text stable when splitting windows

----------------------------------------------------------------------------------------------------
-- Editing / Indentation
----------------------------------------------------------------------------------------------------

opt.expandtab = true -- Tabs -> spaces
opt.tabstop = 2 -- Visual width of tab (tweak per language via ftplugins if needed)
opt.shiftwidth = 2 -- Indent width
opt.softtabstop = 2 -- Backspace treats 2 spaces as a tab
opt.smartindent = true -- Smarter auto-indent
opt.autoindent = true -- Keep indent from current line

opt.backspace = "indent,eol,start" -- More natural backspace
opt.virtualedit = "block" -- Allow cursor past end of line in visual block

-- Treat dash-separated words as a single word for motions like 'w', 'b'
opt.iskeyword:append("-")

----------------------------------------------------------------------------------------------------
-- Search
----------------------------------------------------------------------------------------------------

opt.ignorecase = true -- Case-insensitive search by default
opt.smartcase = true -- But make it case-sensitive if pattern has uppercase
opt.hlsearch = false -- Don't persist highlight after search
opt.incsearch = true -- Show matches while typing

----------------------------------------------------------------------------------------------------
-- Clipboard & Mouse
----------------------------------------------------------------------------------------------------

opt.clipboard = "unnamedplus" -- Use system clipboard (VS Code-like copy/paste)
opt.mouse = "a" -- Enable mouse everywhere

----------------------------------------------------------------------------------------------------
-- Files, Undo, Backup
----------------------------------------------------------------------------------------------------

opt.swapfile = false -- No swap files
opt.backup = false -- No backup files
opt.writebackup = false -- Don't keep a backup when overwriting
opt.undofile = true -- Persistent undo across sessions

-- Use Neovim's standard state dir for undo, and ensure it exists
local undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir

opt.autoread = true -- Auto-reload files changed on disk
opt.autowrite = true -- Don't auto-write on various events (LazyVim handles some saves)

-- Faster CursorHold / diagnostic updates
opt.updatetime = 200 -- Default is 4000; 200-300 feels snappy without being noisy

----------------------------------------------------------------------------------------------------
-- Completion & Cmdline
----------------------------------------------------------------------------------------------------

-- Recommended for modern completion engines (blink.cmp / nvim-cmp)
opt.completeopt = { "menu", "menuone", "noselect" }

opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignorecase = true

opt.timeoutlen = 500 -- Mapped sequence timeout (space-which-key etc)
opt.ttimeoutlen = 0 -- No delay for keycode timeout (feel free to bump if needed)

----------------------------------------------------------------------------------------------------
-- Folding (Tree-sitter)
----------------------------------------------------------------------------------------------------

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevel = 99 -- Open all folds by default
opt.foldlevelstart = 99

----------------------------------------------------------------------------------------------------
-- Diff
----------------------------------------------------------------------------------------------------

opt.diffopt:append("vertical") -- Vertical diffs
opt.diffopt:append("algorithm:patience")
opt.diffopt:append("linematch:60") -- Better diff matching

----------------------------------------------------------------------------------------------------
-- Misc
----------------------------------------------------------------------------------------------------

opt.errorbells = false -- No bell on errors
opt.shortmess:append("c") -- Cleaner messages
opt.encoding = "utf-8"

-- Make gf search into subfolders
opt.path:append("**")

-- Grep
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
