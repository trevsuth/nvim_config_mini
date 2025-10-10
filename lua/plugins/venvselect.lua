return {
	-- Python venv picker (supports mini.pick)
	-- https://github.com/linux-cultist/venv-selector.nvim
	"linux-cultist/venv-selector.nvim",
	name = "venv-selector.nvim",
	lazy = true,
	-- still available on demand:
	cmd = { "VenvSelect", "VenvSelectCached", "VenvDeactivate" },
	-- handy keys (fits your <leader>u… uv.nvim group)
	keys = {
		{ "<leader>uv", "<cmd>VenvSelect<cr>",       desc = "Venv: select" },
		{ "<leader>uV", "<cmd>VenvSelectCached<cr>", desc = "Venv: select (cached)" },
		{ "<leader>uD", "<cmd>VenvDeactivate<cr>",   desc = "Venv: deactivate" },
	},
	-- load only when a Python *project* is detected
	init = function()
		local function has_python_project(start)
			local markers = {
				"pyproject.toml", "requirements.txt", "setup.py",
				"Pipfile", "poetry.lock", "uv.lock",
			}
			return #vim.fs.find(markers, { upward = true, path = start or vim.loop.cwd() }) > 0
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "python",
			callback = function(args)
				local buf = args.buf
				local file = vim.api.nvim_buf_get_name(buf)
				local dir = (file == "" and vim.loop.cwd()) or vim.fs.dirname(file)
				if has_python_project(dir) then
					require("lazy").load({ plugins = { "venv-selector.nvim" } })
				end
			end,
		})
	end,
	dependencies = {
		"neovim/nvim-lspconfig",
		-- picker is required; we’ll use your Mini one:
		-- (You can swap to "telescope.nvim" / "fzf-lua" if preferred.)
	},
	opts = {
		options = {
			picker = "mini-pick", -- use your mini.pick UI
			-- other nice defaults live here if you want them later
		},
		-- `search = { ... }` if you want to add custom fd searches
	},
	config = function(_, opts)
		require("venv-selector").setup(opts)

		-- Make it discoverable in mini.clue
		local ok, clue = pcall(require, "mini.clue")
		if ok then
			table.insert(clue.config.clues, { mode = "n", keys = "<leader>u", desc = "+uv / venv" })
		end
	end,
}
