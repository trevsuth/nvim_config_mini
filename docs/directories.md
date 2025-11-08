# Directory & File Tour

This reference explains what lives where inside `/home/trevorsutherland/.config/nvim-mini` so you can jump to the right file when you want to tweak the editor.

## Root files
- `init.lua`: Sets `mapleader`, pulls in `config.lazy`, `core.settings`, `core.keys`, and the project-tree helper. This is the only file Neovim reads directly.
- `lazy-lock.json`: Auto-managed by lazy.nvim; records exact plugin commits. Commit it to get reproducible installs.
- `PROJECT_TREE.md`: Markdown tree generated via `:ProjectTree!`. Useful when sharing the layout with others.

## `lua/`
All custom logic lives under `lua/`, split into three buckets so responsibilities stay isolated:

### `lua/config/`
- `lazy.lua`: Bootstraps lazy.nvim (clones it if missing), sets leaders early, and registers `plugins` as the root spec import.
- `project_tree.lua`: Provides `:ProjectTree` / `:ProjectTree!` commands and helper functions to walk the current repo even when the external `tree` binary is absent.

### `lua/core/`
- `settings.lua`: Canonical Neovim options (numbers, splits, indent/display behavior, yank highlight, etc.). Safe to require before plugins.
- `keys.lua`: Global keymaps for navigation, diagnostics, toggles, LSP actions, and wrappers around `config.project_tree`. These are defined once so plugins can assume consistent leader groups.

### `lua/plugins/`
Each Lua file returns one or more lazy.nvim specs for a cohesive concern. lazy.nvim automatically discovers them because `config.lazy` imports the directory. See `docs/plugins.md` for per-file detail. Highlights:
- `cmp.lua`, `formatting.lua`, `testing.lua`, `treesitter.lua`, etc. keep tooling concerns isolated.
- `lsp/` subdirectory contains the shared LSP stack:
  - `lsp/init.lua`: Wires mason, mason-lspconfig, blink.cmp capabilities, diagnostics UI, and per-server setup.
  - `lsp/on_attach.lua`: Adds buffer-local LSP keymaps, inlay-hint toggles, and highlight autocommands.
  - `lsp/servers.lua`: Declarative table of server-specific settings; mason-tool-installer uses its keys to ensure dependencies are present.

## Generated or external state
- `lazy-lock.json` (root) and `sessions/` under `stdpath('data')` are modified by plugins at runtime. Documenting them here reminds you not to hand-edit unless you know what you’re doing.

## Related helpers
- `docs/plugins.md`: Explains how each plugin spec is organized.
- `docs/README.md`: High-level boot overview plus maintenance tips.

