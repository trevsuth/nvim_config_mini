return {
  "nvim-mini/mini.nvim",
  version = false,   -- or version = "*" for stable
  lazy = false,      -- load at startup; mini is tiny
  priority = 900,    -- so statusline/tabline/etc are ready early
  config = function()
    -- helper so missing modules never hard-crash
    local function setup(mod, opts)
      local ok, pkg = pcall(require, "mini." .. mod)
      if ok then pkg.setup(opts or {}) end
    end

    -- enable the modules you want (add/remove freely)
    setup("ai")
    setup("align")
    setup("basics")
    setup("bracketed")
    setup("bufremove")

    -- ── which-key style hints (mini.clue) ───────────────────────────
    setup("clue", {
      -- keep only valuable prefixes to reduce overhead
      triggers = {
        { mode = "n", keys = "<Leader>" }, -- your leader menus
        { mode = "x", keys = "<Leader>" },

        -- helpful families
        { mode = "n", keys = "g" },
        { mode = "n", keys = "z" },
        { mode = "n", keys = "'" },       -- marks
        { mode = "n", keys = '"' },       -- registers
        { mode = "n", keys = "<C-w>" },   -- window commands
      },
      clues = {
        -- generated clues
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.z(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),

        -- leader groups (match your leader layout)
        { mode = "n", keys = "<leader>f", desc = "+files/find" },
        { mode = "n", keys = "<leader>b", desc = "+buffer" },
        { mode = "n", keys = "<leader>g", desc = "+git" },
        { mode = "n", keys = "<leader>l", desc = "+lsp" },
        { mode = "n", keys = "<leader>w", desc = "+windows" },
        { mode = "n", keys = "<leader>t", desc = "+toggles" },
        { mode = "n", keys = "<leader>s", desc = "+symbols/search" },
        { mode = "n", keys = "<leader>S", desc = "+sessions" }, -- NEW: sessions menu
      },
      window = { delay = 200 }, -- default is 1000; this feels snappy
    })

    setup("colors")
    setup("comment")
    -- If you use nvim-cmp, DO NOT enable mini.completion (remove or comment):
    -- setup("completion")

    setup("cursorword")
    setup("diff", { view = { style = "sign" } })
    setup("extra")
    setup("files")
    setup("fuzzy")  -- used by pick; harmless to enable
    setup("git")
    setup("hipatterns")
    setup("icons")
    setup("indentscope", { symbol = "│" })
    setup("jump")
    setup("jump2d")
    setup("map")
    setup("misc")
    setup("move")
    setup("operators")
    setup("pairs")

    -- Picker (like a mini Telescope). Needs ripgrep for grep builtin.
    setup("pick", { window = { config = { border = "rounded" } } })

    -- Sessions (with friendly defaults)
    setup("sessions", {
      directory = vim.fn.stdpath("data") .. "/sessions",
      autoread = true,   -- auto-restore if session matches cwd
      autowrite = true,  -- auto-save on quit
    })

    setup("splitjoin")
    setup("starter")     -- dashboard (optional)
    setup("statusline")
    setup("surround")
    setup("tabline")     -- optional
    setup("trailspace")
    setup("visit")

    -- ensure Clue captures buffer-local maps created after LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local ok, clue = pcall(require, "mini.clue")
        if ok then clue.ensure_buf_triggers(args.buf) end
      end,
    })

    -- some handy default keymaps (load after modules)
    local map = function(mode, lhs, rhs, desc, opts)
      opts = vim.tbl_extend("force", { silent = true, noremap = true, desc = desc }, opts or {})
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- explorer
    map("n", "<leader>e", function() require("mini.files").open() end, "MiniFiles: Explorer")

    -- pickers
    local pick = require("mini.pick").builtin
    map("n", "<leader>ff", pick.files,   "Find files")
    map("n", "<leader>fg", pick.grep,    "Live grep")  -- requires ripgrep (`rg`) in PATH
    map("n", "<leader>fb", pick.buffers, "Buffers")
    map("n", "<leader>fr", pick.resume,  "Resume picker")

    -- buffers
    map("n", "<leader>bd", function() require("mini.bufremove").delete(0, false) end, "Delete buffer")

    -- git/diff (remove these if you prefer gitsigns)
    map("n", "<leader>gs", function() require("mini.git").show() end, "Git status (mini.git)")
    map("n", "<leader>gd", function() require("mini.diff").toggle_overlay(0) end, "Toggle diff overlay")

    -- sessions leader menu (capital S) to match clue group
    do
      local MS = require("mini.sessions")
      local function default_name()
        return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end
      map("n", "<leader>Ss", function() MS.write(default_name()) end, "[S]essions → [s]ave (project)")
      map("n", "<leader>SS", function() MS.write(vim.fn.input("Session name: ", default_name())) end, "[S]essions → [S]ave as…")
      map("n", "<leader>Sr", function() MS.read(default_name()) end, "[S]essions → [r]estore (project)")
      map("n", "<leader>SL", function() MS.select() end,            "[S]essions → [L]ist/select")
      map("n", "<leader>Sd", function() MS.delete() end,            "[S]essions → [d]elete")
    end
  end,
}

