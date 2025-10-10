return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    config = function(_, opts)
      local gs = require("gitsigns")
      gs.setup(opts)

      -- lightweight keys
      vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Git: next hunk" })
      vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Git: prev hunk" })
      vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Git: stage hunk" })
      vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Git: reset hunk" })
    end,
  },
}
