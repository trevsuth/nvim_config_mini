return {
	-- Lua (your Neovim config/plugins)
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = { globals = { "vim" } },
			},
		},
	},

	-- Python
	pyright = {}, -- or prefer ruff_lsp + pyright; add ruff_lsp if you use it
	ruff = {},

	-- Go
	gopls = {},

	-- Rust
	rust_analyzer = {},

	-- Web stuff
	html = {},
	cssls = {},
	jsonls = {},
	yamlls = {},

	-- Shell / Markdown / Docker
	bashls = {},
	marksman = {},
	dockerls = {},
	docker_compose_language_service = {},
}
