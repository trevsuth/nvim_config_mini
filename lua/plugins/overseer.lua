return {
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerBuild" },
    opts = {},
    keys = {
      { "<leader>or", "<cmd>OverseerRun<cr>",    desc = "Overseer: run task" },
      { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Overseer: toggle" },
    },
  },
}
