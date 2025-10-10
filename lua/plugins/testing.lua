return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python", -- add more adapters if you need
    },
    keys = {
      { "<leader>nt", function() require("neotest").run.run() end, desc = "Neotest: nearest" },
      { "<leader>nT", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Neotest: project" },
      { "<leader>ns", function() require("neotest").summary.toggle() end, desc = "Neotest: summary" },
      { "<leader>no", function() require("neotest").output.open() end, desc = "Neotest: output" },
    },
    config = function()
      require("neotest").setup({
        adapters = { require("neotest-python")({}) },
      })

      -- Add a clue group for mini.clue (if loaded)
      local ok, clue = pcall(require, "mini.clue")
      if ok then
        table.insert(clue.config.clues, { mode = "n", keys = "<leader>n", desc = "+neotest" })
      end
    end,
  },
}
