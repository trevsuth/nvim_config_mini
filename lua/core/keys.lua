-- core/keys.lua
local map = vim.keymap.set

-- ── Search ──────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- ── Diagnostics (pairs well with ]d / [d from your maps) ───────────
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics → Loclist" })
map("n", "[d", function() vim.diagnostic.goto_prev({ float = true }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.goto_next({ float = true }) end, { desc = "Next diagnostic" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "[L]SP: Line [D]iagnostic" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "[L]SP: Diagnostics → loclist" })

-- ── Terminal ───────────────────────────────────────────────────────
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ── Windows  <leader>w* + Ctrl-arrows ──────────────────────────────
map("n", "<C-h>", "<C-w><C-h>", { desc = "Window: focus left" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Window: focus right" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Window: focus down" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Window: focus up" })

map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Window: taller" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Window: shorter" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Window: thinner" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Window: wider" })

map("n", "<leader>wh", "<cmd>split | wincmd j<CR>", { desc = "Horizontal split + move" })
map("n", "<leader>wv", "<cmd>vsplit | wincmd l<CR>", { desc = "Vertical split + move" })

-- ── Files   <leader>f*  (keep light; Mini handles the rest) ────────
map("n", "<leader>fw", "<cmd>w<CR>", { desc = "[F]ile → [W]rite" })
map("n", "<leader>fx", "<cmd>x<CR>", { desc = "[F]ile → Save & E[x]it" })
map("n", "<leader>fa", "ggVG", { desc = "[F]ile → Select [A]ll" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write file" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })

-- ── Buffers  <leader>b*  (navigation via mini.bracketed: ]b / [b) ──
-- Prefer MiniBufremove for deletion (already bound in mini.lua).
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "[B]uffer → [N]ext" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "[B]uffer → [P]revious" })

-- ── Motion tweaks ──────────────────────────────────────────────────
map("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true, desc = "Down (wrapped lines)" })
map("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true, desc = "Up (wrapped lines)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up (centered)" })

-- ── Clipboard (system)  <leader>y/p ────────────────────────────────
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank → system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line → system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste after ← system clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste before ← system clipboard" })

-- ── Editing QoL ────────────────────────────────────────────────────
map("x", "p", [["_dP]], { desc = "Paste over (keep default register)" })
map("n", "<leader>cw", [[:%s/\s\+$//e<CR>]], { desc = "Clear trailing whitespace" })

-- ── Toggles  <leader>t* ────────────────────────────────────────────
map("n", "<leader>tr", function() vim.o.relativenumber = not vim.o.relativenumber end, { desc = "[T]oggle → [R]elative numbers" })
map("n", "<leader>ts", function() vim.o.spell = not vim.o.spell end, { desc = "[T]oggle → [S]pell" })

-- ── UX nudges (keep if you like) ───────────────────────────────────
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- ── Yank highlight ─────────────────────────────────────────────────
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- ── LSP jumps / actions (tooling-agnostic) ─────────────────────────
map("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Goto definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Goto declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP: References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP: Implementations" })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP: Type definition" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "[L]SP: [R]ename symbol" })
map({ "n", "x" }, "<leader>la", vim.lsp.buf.code_action, { desc = "[L]SP: Code [A]ction" })
map("n", "<leader>lk", vim.lsp.buf.signature_help, { desc = "[L]SP: Signature help" })

