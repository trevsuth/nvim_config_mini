-- core/settings.lua

-- Line numbers
vim.o.number = true
-- vim.o.relativenumber = true  -- toggle via <leader>tr

-- Mouse & mode
vim.o.mouse = "a"
vim.o.showmode = false

-- Clipboard (schedule avoids startup cost on some UIs)
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Indent / UI comfort
vim.o.breakindent = true
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.wrap = false

-- Search behavior
vim.o.ignorecase = true
vim.o.smartcase = true

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace rendering
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Live substitute preview
vim.o.inccommand = "split"

-- Safer quits (confirm to save)
vim.o.confirm = true
