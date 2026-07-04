local opt = vim.opt

----------------------------------------------------------------------------------------------------
-- UI / UX
----------------------------------------------------------------------------------------------------
opt.wrap = false -- Don't soft-wrap lines (LazyVim defaults to true)
opt.relativenumber = true -- Relative line numbers
opt.conceallevel = 2 -- Good for Markdown / Obsidian-style notes (LazyVim defaults to 3)
opt.concealcursor = "" -- Show markup on cursor line as well

----------------------------------------------------------------------------------------------------
-- Editing / Indentation
----------------------------------------------------------------------------------------------------
opt.tabstop = 2 -- Visual width of tab
opt.shiftwidth = 2 -- Indent width
opt.softtabstop = 2 -- Backspace treats 2 spaces as a tab
opt.backspace = "indent,eol,start" -- More natural backspace
opt.virtualedit = "block" -- Allow cursor past end of line in visual block
opt.iskeyword:append("-") -- Treat dash-separated words as a single word for motions like 'w', 'b'

----------------------------------------------------------------------------------------------------
-- Files, Backup
----------------------------------------------------------------------------------------------------
opt.swapfile = false -- No swap files
opt.backup = false -- No backup files
opt.writebackup = false -- Don't keep a backup when overwriting

----------------------------------------------------------------------------------------------------
-- Misc
----------------------------------------------------------------------------------------------------
opt.errorbells = false -- No bell on errors

-- Force sh for background tasks (Fixes image.nvim clearing bug in tmux when using zsh/fish)
opt.shell = "/bin/sh"
