return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- Install these parsers up front (edit to taste)
			ensure_installed = {
				"lua", "vim", "vimdoc", "query", "regex",
				"bash", "python", "json", "jsonc", "yaml", "toml",
				"markdown", "markdown_inline",
				"html", "css", "javascript", "typescript", "tsx",
				"go", "rust",
			},
			auto_install = true, -- install missing parsers on open
			sync_install = false, -- async is usually fine
			ignore_install = {}, -- parsers you want to skip

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false, -- avoid duplicate highlights
			},
			indent = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- Optional: textobjects (keep minimal; you already use mini.ai)
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup({ textobjects = { select = opts.select } })
		end,
	},
}
