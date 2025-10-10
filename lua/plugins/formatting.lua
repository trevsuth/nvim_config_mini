return {
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      format_on_save = function()
        return not vim.g.disable_autoformat and { timeout_ms = 2000, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        json = { "jq" },
        sh = { "shfmt" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      -- toggle formatting-on-save quickly
      vim.keymap.set("n", "<leader>tf", function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify("Format on save: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
      end, { desc = "[T]oggle → [F]ormat on save" })
    end,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff" },
        sh = { "shellcheck" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
}
