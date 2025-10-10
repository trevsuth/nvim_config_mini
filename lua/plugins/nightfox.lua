return {
	"EdenEast/nightfox.nvim",
	lazy = false, -- load immediately
	priority = 1000, -- load before UI plugins
	opts = {
		options = {
			transparent = false,
			terminal_colors = true,
			dim_inactive = false,
			styles = { comments = "italic" }, -- tweak to taste
		},
	},
	config = function(_, opts)
		require("nightfox").setup(opts)
		vim.cmd.colorscheme("terafox") -- set the scheme
	end,
}
