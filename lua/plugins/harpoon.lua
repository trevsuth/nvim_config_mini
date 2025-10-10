return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local h = require("harpoon")
      h:setup()

      vim.keymap.set("n", "<leader>ha", function() h:list():add() end, { desc = "Harpoon add" })
      vim.keymap.set("n", "<leader>hm", function() h.ui:toggle_quick_menu(h:list()) end, { desc = "Harpoon menu" })
      vim.keymap.set("n", "<leader>h1", function() h:list():select(1) end, { desc = "Harpoon 1" })
      vim.keymap.set("n", "<leader>h2", function() h:list():select(2) end, { desc = "Harpoon 2" })
      vim.keymap.set("n", "<leader>h3", function() h:list():select(3) end, { desc = "Harpoon 3" })
      vim.keymap.set("n", "<leader>h4", function() h:list():select(4) end, { desc = "Harpoon 4" })

      local ok, clue = pcall(require, "mini.clue")
      if ok then
        table.insert(clue.config.clues, { mode = "n", keys = "<leader>h", desc = "+harpoon" })
      end
    end,
  },
}
