return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Installer stack
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- UX
    { "j-hui/fidget.nvim", opts = {} },

    -- Completion capabilities (blink.cmp)
    "saghen/blink.cmp",

    -- Better Lua types for your config/plugins
    { "folke/lazydev.nvim", ft = "lua",
      opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } } },
  },

  config = function()
    -- 1) Diagnostics UI
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      virtual_text = { source = "if_many", spacing = 2, format = function(d) return d.message end },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN]  = "󰀪 ",
          [vim.diagnostic.severity.INFO]  = "󰋽 ",
          [vim.diagnostic.severity.HINT]  = "󰌶 ",
        },
      } or {},
    })

    -- 2) On-attach behavior (keymaps, inlay hints, highlights)
    local on_attach = require("plugins.lsp.on_attach").on_attach

    -- 3) Capabilities from blink.cmp (autocompletion)
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- 4) Server definitions
    local servers = require("plugins.lsp.servers")

    -- 5) Ensure tools are installed
    local ensure = vim.tbl_keys(servers)
    require("mason-tool-installer").setup({ ensure_installed = ensure })

    -- 6) Setup each server via mason-lspconfig
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          server.on_attach = require("plugins.lsp.on_attach").compose(server.on_attach, on_attach)
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
