# Repository Guidelines

## Project Structure & Module Organization
`init.lua` is the single entry point: it sets leaders, bootstraps `lua/config/lazy.lua`, applies `lua/core/{settings,keys}.lua`, and wires helpers such as `lua/config/project_tree.lua`. Feature work lives under `lua/plugins/`, one file per concern (LSP, testing, UI, etc.), so add new behavior by dropping an additional spec module there. Keep shared utilities under `lua/config/`, editor defaults under `lua/core/`, and long-form explanations inside `docs/`. Regenerate `PROJECT_TREE.md` whenever you add or delete files so contributors understand the layout snapshot.

## Build, Test, and Development Commands
- `nvim --headless '+Lazy sync' +qa`: install or update plugins exactly as defined in the specs; run after dependency changes.
- `:Lazy check`: verify the lockfile matches upstream and discover pending updates.
- `:ProjectTree!`: rebuild `PROJECT_TREE.md` after structural edits.
- `:checkhealth` (within Neovim): confirm core providers, Python, and clipboard integrations are ready before debugging plugin issues.

## Coding Style & Naming Conventions
Use two-space indentation in Lua, keep trailing commas in tables, and favor concise local helpers over sprawling modules. Name plugin specs by feature (e.g., `lua/plugins/testing.lua`, `lua/plugins/formatting.lua`) and keep submodules grouped (`lua/plugins/lsp/{init,on_attach,servers}.lua`). Formatting runs through `conform.nvim` (Stylua, Ruff Format, jq, shfmt); avoid manual whitespace fixes—toggle format-on-save with `<leader>tf` when needed. Linting is handled by `nvim-lint` (Ruff, ShellCheck) so keep language-specific settings centralized there.

## Testing Guidelines
Neotest drives the workflow via `<leader>nt` (nearest), `<leader>nT` (project), `<leader>ns` (summary), and `<leader>no` (output). Tests should mirror project modules (`*_spec.lua`, `*_test.py`, etc.) so adapters can resolve them. Extend adapters in `lua/plugins/testing.lua` if you introduce new languages. Run the suite before commits and capture failures in pull requests so reviewers know the state.

## Commit & Pull Request Guidelines
Commits follow the existing short, imperative summaries seen in `git log` (e.g., `added sidekick / codex`). Keep them under ~70 characters, scope one logical change per commit, and mention touched modules when useful. Pull requests should describe the problem, list user-facing impacts, call out new commands or keymaps, and reference related issues. Attach screenshots or asciinema clips when UI or keymap behavior changes, and state whether `lazy-lock.json` or docs were regenerated so reviewers can focus on substantive diffs.

## Documentation & Maintenance
Whenever you add a plugin spec or top-level directory, update `docs/plugins.md`, `docs/directories.md`, and regenerate the tree to keep the knowledge base trustworthy. Call out new keymaps or commands in the docs so operators and other agents can find them quickly.
