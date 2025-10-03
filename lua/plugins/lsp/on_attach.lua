local M = {}

local function has(mod)
  local ok = pcall(require, mod)
  return ok
end

function M.on_attach(client, bufnr)
  local map = function(keys, fn, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- Prefer Telescope pickers if present
  local tb = has("telescope.builtin") and require("telescope.builtin") or nil

  map("grn", vim.lsp.buf.rename,                     "[R]e[n]ame")
  map("gra", vim.lsp.buf.code_action,                "Code [A]ction", { "n", "x" })

  map("grd", tb and tb.lsp_definitions or vim.lsp.buf.definition,      "[D]efinition")
  map("grt", tb and tb.lsp_type_definitions or vim.lsp.buf.type_definition, "[T]ype Definition")
  map("gri", tb and tb.lsp_implementations or vim.lsp.buf.implementation,   "[I]mplementation")
  map("grr", tb and tb.lsp_references or vim.lsp.buf.references,       "[R]eferences")

  map("gO",  tb and tb.lsp_document_symbols or vim.lsp.buf.document_symbol, "Document Symbols")
  map("gW",  tb and tb.lsp_dynamic_workspace_symbols or vim.lsp.buf.workspace_symbol, "Workspace Symbols")

  -- Inlay hints toggle (if supported)
  if client and vim.lsp.inlay_hint then
    if type(vim.lsp.inlay_hint.enable) == "function" then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, "[T]oggle Inlay [H]ints")
    else
      -- Older API variant
      map("<leader>th", function()
        vim.lsp.inlay_hint(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
      end, "[T]oggle Inlay [H]ints")
    end
  end

  -- Highlight references while idle (if supported)
  local function supports(method)
    return client and client.supports_method and client:supports_method(method)
  end
  if supports(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local aug = vim.api.nvim_create_augroup("lsp-highlight-" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = aug, buffer = bufnr, callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "LspDetach" }, {
      group = aug, buffer = bufnr, callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Small helper to compose two on_attach funcs
function M.compose(a, b)
  if not a then return b end
  if not b then return a end
  return function(client, bufnr) a(client, bufnr); b(client, bufnr) end
end

return M

