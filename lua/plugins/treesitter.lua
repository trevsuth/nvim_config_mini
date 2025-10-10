return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true },
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
  -- Optional: extra textobjects (keep small to avoid overlap with mini.ai)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      select = {
        enable = true, lookahead = true,
        keymaps = {
          ["af"] = "@function.outer", ["if"] = "@function.inner",
          ["ac"] = "@class.outer",    ["ic"] = "@class.inner",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup({ textobjects = { select = opts.select } })
    end,
  },
}

