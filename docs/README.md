# nvim-mini Documentation Hub

_Last updated: 2025-11-08_

This folder explains how the Neovim mini-config is stitched together so you can trace any behavior back to the file that owns it.

## How the config boots
1. `init.lua` sets the leaders and `require`s the config entry points.
2. `lua/config/lazy.lua` bootstraps `lazy.nvim`, declares that everything under `lua/plugins` is a plugin spec, and enables the lazy checker.
3. `lua/core/settings.lua` and `lua/core/keys.lua` apply editor defaults and global keymaps that are safe before plugins load.
4. `lua/config/project_tree.lua` registers the `:ProjectTree` helper (and keymaps that call it) so you can regenerate the repository tree snapshot.
5. `lazy.nvim` loads each module under `lua/plugins/**`, which in turn configures language servers, completion, UI polish, tooling, etc.

## Directory cheat sheet
| Path | What it contains |
| --- | --- |
| `init.lua` | Minimal entry point that wires leaders and loads config/core modules. |
| `lua/config/` | Bootstrapping helpers (`lazy.lua`) plus reusable utilities (`project_tree.lua`). |
| `lua/core/` | Editor defaults and cross-plugin keymaps that should exist even without plugins. |
| `lua/plugins/` | One Lua file per concern (LSP, UI, testing, formatting, etc.); lazy.nvim discovers them automatically. |
| `lua/plugins/lsp/` | Submodules that keep the LSP stack tidy (`init`, `on_attach`, `servers`). |
| `lazy-lock.json` | The resolver output from lazy.nvim so plugin versions stay pinned. |
| `PROJECT_TREE.md` | Generated snapshot of the repo layout (via `:ProjectTree!`). |

See `docs/directories.md` for a prose walkthrough of every directory/file, and `docs/plugins.md` for plugin-by-plugin notes.

## Keeping the docs in sync
- Regenerate `PROJECT_TREE.md` after adding/removing files so the structure map matches reality.
- When you introduce a new top-level directory or plugin spec, add a short entry to the corresponding doc file in this folder.

