local M = {}

local DEFAULT_IGNORES = {
	".git", "node_modules", ".venv", "venv", "__pycache__", ".mypy_cache",
	".pytest_cache", "dist", "build", ".direnv", ".idea", ".vscode", ".cache",
}

local function has_exe(name) return vim.fn.executable(name) == 1 end

local function repo_root()
	local out = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })
	if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then return out[1] end
	return vim.loop.cwd()
end

local function is_ignored(name, ignores)
	for _, pat in ipairs(ignores) do if name == pat then return true end end
	return false
end

-- pure-Lua walker for when `tree` isn't installed
local function lua_tree(root, ignores)
	local uv = vim.loop
	local lines = {}

	local function scan(dir, prefix)
		local handle = uv.fs_scandir(dir)
		if not handle then return end
		local dirs, files = {}, {}
		while true do
			local name, typ = uv.fs_scandir_next(handle)
			if not name then break end
			if not is_ignored(name, ignores) then
				if typ == "directory" then dirs[#dirs + 1] = name else files[#files + 1] = name end
			end
		end
		table.sort(dirs); table.sort(files)
		local items = {}
		for _, n in ipairs(dirs) do items[#items + 1] = { n, "directory" } end
		for _, n in ipairs(files) do items[#items + 1] = { n, "file" } end

		for i, it in ipairs(items) do
			local name, typ = it[1], it[2]
			local last = (i == #items)
			local branch = last and "└── " or "├── "
			lines[#lines + 1] = prefix .. branch .. name .. (typ == "directory" and "/" or "")
			if typ == "directory" then
				scan(dir .. "/" .. name, prefix .. (last and "    " or "│   "))
			end
		end
	end

	lines[#lines + 1] = vim.fn.fnamemodify(root, ":t") .. "/"
	scan(root, "")
	return lines
end

---@param opts {outfile?:string, ignores?:string[]}|nil
function M.write_tree(opts)
	opts = opts or {}
	local ignores = opts.ignores or DEFAULT_IGNORES
	local root = repo_root()
	local outpath = opts.outfile or "PROJECT_TREE.txt"
	if not outpath:match("^/") then outpath = root .. "/" .. outpath end

	local lines
	if has_exe("tree") then
		local ignore_pat = table.concat(ignores, "|")
		lines = vim.fn.systemlist({ "tree", "-a", "-F", "--dirsfirst", "-I", ignore_pat, root })
	else
		lines = lua_tree(root, ignores)
	end

	vim.fn.writefile(lines, outpath)
	vim.cmd.edit(outpath)
	vim.notify(("Project tree written to %s"):format(outpath))
end

function M.setup()
	-- :ProjectTree   -> PROJECT_TREE.txt
	-- :ProjectTree!  -> PROJECT_TREE.md wrapped in ```text fences
	vim.api.nvim_create_user_command("ProjectTree", function(a)
		if a.bang then
			M.write_tree({ outfile = "PROJECT_TREE.md" })
			local b = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_set_lines(b, 0, 0, false, { "```text" })
			vim.api.nvim_buf_set_lines(b, -1, -1, false, { "```" })
			vim.cmd.normal("gg")
		else
			M.write_tree({})
		end
	end, { bang = true, desc = "Generate a project file tree" })
end

return M
