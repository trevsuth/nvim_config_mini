# Plugin Module Reference

Every Lua file under `lua/plugins/` returns one or more lazy.nvim specs. Because `config.lazy` imports the whole directory, new modules only need to return a spec table to participate. Use this guide to locate the knobs for each feature area.

## Core experience
- `lua/plugins/mini.lua`: Enables the curated `mini.nvim` modules (AI, align, files, pick, sessions, map, etc.), wires helper keymaps, and adds Mini integrations to `mini.clue`.
- `lua/plugins/nightfox.lua`: Configures the `terafox` colorscheme early (`lazy=false`, high priority) so the rest of the UI inherits the palette.
- `lua/plugins/ui.lua`: UI niceties—Trouble lists, Dressing prompts, `nvim-notify`, and Noice routing—loaded on demand to keep startup light.
- `lua/plugins/treesitter.lua`: Base Treesitter config plus optional textobjects. Handles parser installation lists, highlight/indent toggles, and incremental selection keymaps.

## Editing & navigation helpers
- `lua/plugins/cmp.lua`: Sets up nvim-cmp with LuaSnip snippets, standard completion sources, and compact keymaps.
- `lua/plugins/harpoon.lua`: Configures ThePrimeagen's Harpoon2 (quick file marks) with leader keymaps and a `mini.clue` group.
- `lua/plugins/formatting.lua`: Couples `conform.nvim` (format-on-save + toggle) with `nvim-lint` autocmds for Ruff/ShellCheck.
- `lua/plugins/gitsigns.lua`: Lightweight gutter signs, hunk navigation, and stage/reset mappings.
- `lua/plugins/lazygit.lua`: Declares the LazyGit floating UI commands and a `<leader>gl` binding (plugin stays lazy-loaded until used).
- `lua/plugins/overseer.lua`: Task runner commands (`OverseerRun`, `OverseerToggle`) with matching leader bindings.
- `lua/plugins/testing.lua`: Neotest core + python adapter, summary/output keymaps, and a clue group under `<leader>n`.
- `lua/plugins/dap.lua`: nvim-dap base plus dap-ui integration, keymaps for breakpoint/step workflows, and clue hints.

## Language tooling
- `lua/plugins/lsp/init.lua`: Mason + LSPConfig orchestration, diagnostic styling, blink.cmp capability wiring, and per-server setup loop.
- `lua/plugins/lsp/on_attach.lua`: Shared buffer-local LSP keymaps, Telescope fallbacks, document highlight autocommands, and inlay-hint toggles.
- `lua/plugins/lsp/servers.lua`: Declarative server list (Lua, Python, Go, Rust, web stack, YAML, Docker, etc.) that also feeds `mason-tool-installer`.
- `lua/plugins/cmp.lua`: (see above) also part of the language experience because it wires completion.
- `lua/plugins/uv.lua`: Configures `uv.nvim` (Python package manager/task runner) with `<leader>u` prefix and mini.clue integration.
- `lua/plugins/venvselect.lua`: Lazy-loads venv-selector when Python markers exist, exposes `VenvSelect*` commands, and keeps the picker consistent by using `mini.pick`.

## AI & automation
- `lua/plugins/sidekick_codex.lua`: Enables `folke/sidekick.nvim` with Codex CLI defaults, `<C-.>` toggles, extended `<leader>a` mappings, and optional NES bindings.

## How to extend
1. Drop a new `lua/plugins/your_feature.lua` file that returns a lazy spec.
2. Reference shared helpers (e.g., call `pcall(require, "mini.clue")` before editing clue tables) to match existing style.
3. Document the new file by adding a short bullet here and, if it introduces new directories, updating `docs/directories.md`.

