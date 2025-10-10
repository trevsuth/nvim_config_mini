return {
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP: continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP: step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "DAP: step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "DAP: step out" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI toggle" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"] = function() dapui.close() end

      local ok, clue = pcall(require, "mini.clue")
      if ok then
        table.insert(clue.config.clues, { mode = "n", keys = "<leader>d", desc = "+debug" })
      end
    end,
  },
}
