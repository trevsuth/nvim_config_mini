return {
	-- tweak your existing sidekick spec if you already have one; otherwise use this
	"folke/sidekick.nvim",
	event = "VeryLazy",
	opts = {
		-- leave NES off or on as you like:
		-- nes = { enabled = true },
		-- set a preferred CLI command; Sidekick will open the tool in its terminal
		cli = {
			default = { cmd = { "codex" } }, -- run Codex CLI
		},
	},
	keys = {
		{
			"<C-.>",
			function() require("sidekick.cli").toggle() end,
			desc = "Sidekick: Toggle",
			mode = { "n", "i", "x", "t" }
		},
		{ "<leader>aa", function() require("sidekick.cli").toggle() end,                 desc = "Sidekick: Toggle CLI" },
		{ "<leader>ap", function() require("sidekick.cli").prompt() end,                 desc = "Sidekick: Prompt" },
		{ "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Sidekick: Send {file}" },
		{
			"<leader>av",
			function() require("sidekick.cli").send({ msg = "{selection}" }) end,
			desc = "Sidekick: Send {visual selection}",
			mode = "x"
		},
		-- NES helpers (don’t bind <Tab> to avoid conflicts)
		{ "]e",         function() require("sidekick.nes").jump() end,   desc = "NES: jump to edit" },
		{ "<leader>aE", function() require("sidekick.nes").toggle() end, desc = "NES: toggle" },
		{ "<leader>aU", function() require("sidekick.nes").update() end, desc = "NES: update" },
	},
	config = function(_, opts)
		require("sidekick").setup(opts)
		local ok, clue = pcall(require, "mini.clue")
		if ok then table.insert(clue.config.clues, { mode = "n", keys = "<leader>a", desc = "+ai" }) end
	end,
}
