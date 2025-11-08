vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("core.settings")
require("core.keys")
require("config.project_tree").setup()
