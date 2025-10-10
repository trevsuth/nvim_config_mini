return {
  "benomahony/uv.nvim",
  -- optional: only load when editing Python
  ft = { "python" },
  opts = {
    picker_integration = true,
    keymaps = { prefix = "<leader>u" }, -- WAS <leader>x (conflicts)
  },
  config = function(_, opts)
    require("uv").setup(opts)

    -- Nice: add a clue group so mini.clue shows the menu
    local ok, clue = pcall(require, "mini.clue")
    if ok then
      table.insert(clue.config.clues, { mode = "n", keys = "<leader>u", desc = "+uv" })
    end
  end,
}
