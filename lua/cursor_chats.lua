-- FZF picker for Cursor Agent chats (~/.cursor/chats/<md5(workspace)>/<chatId>/store.db).
-- Needs: sqlite3, fzf.vim, cursor-agent on PATH.

local M = {}

local function md5_hex(str)
	str = str:gsub("/$", "")
	local out = vim.fn.system(
		{ "python3", "-c", "import hashlib,sys; print(hashlib.md5(sys.stdin.read().encode()).hexdigest())" },
		str
	)
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return vim.trim(out)
end

local function hex_to_string(hex)
	if #hex % 2 == 1 then
		return nil
	end
	local t = {}
	for i = 1, #hex, 2 do
		t[#t + 1] = string.char(tonumber(hex:sub(i, i + 1), 16))
	end
	return table.concat(t)
end

local function collect_rows()
	local home = vim.fn.expand("~")
	local paths = vim.fn.glob(home .. "/.cursor/chats/*/*/store.db", false, true)
	local rows = {}
	for _, db in ipairs(paths) do
		local hex = vim.trim(vim.fn.system({ "sqlite3", db, "SELECT value FROM meta LIMIT 1;" }))
		if vim.v.shell_error == 0 and hex ~= "" then
			local json_str = hex_to_string(hex)
			if json_str then
				local ok, data = pcall(vim.json.decode, json_str)
				if ok and type(data) == "table" and data.agentId then
					local ws_hash = db:match("/chats/([^/]+)/")
					local created = data.createdAt or 0
					local name = (data.name or "(no name)"):gsub("\n", " "):gsub("%c", " ")
					local ts = created > 0 and os.date("%Y-%m-%d %H:%M", math.floor(created / 1000)) or "?"
					-- Single visible line for fzf (no --with-nth / tab delimiter — avoids broken columns).
					local short_id = data.agentId:sub(1, 8)
					local display = string.format("%s  %s  · %s", ts, name, short_id)
					table.insert(rows, {
						display = display,
						created = created,
						chat_id = data.agentId,
						ws_hash = ws_hash or "",
						db = db,
					})
				end
			end
		end
	end
	table.sort(rows, function(a, b)
		return a.created > b.created
	end)
	return rows
end

function M.open_pick()
	if vim.fn.executable("sqlite3") == 0 then
		vim.notify("cursor chats: install sqlite3 (e.g. pacman -S sqlite)", vim.log.levels.ERROR)
		return
	end
	if vim.fn.exists("*fzf#run") == 0 then
		vim.notify("cursor chats: fzf.vim not loaded", vim.log.levels.ERROR)
		return
	end
	if vim.fn.executable("cursor-agent") == 0 and vim.fn.executable("agent") == 0 then
		vim.notify("cursor chats: cursor-agent not in PATH", vim.log.levels.WARN)
	end

	local rows = collect_rows()
	if #rows == 0 then
		vim.notify("No Cursor chats found under ~/.cursor/chats", vim.log.levels.INFO)
		return
	end

	local source = vim.tbl_map(function(r)
		return r.display
	end, rows)

	local cwd = vim.fn.fnamemodify(vim.loop.cwd() or "", ":p"):gsub("/$", "")
	local cwd_hash = md5_hex(cwd)

	-- sink* = one callback with all lines (avoids duplicate sink calls if multiple lines).
	vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
		source = source,
		options = "--prompt='Cursor chats> '",
		["sink*"] = function(lines)
			vim.schedule(function()
				local line = type(lines) == "table" and lines[1] or lines
				if type(line) ~= "string" or line == "" then
					return
				end
				local chat_id, ws_hash
				for _, r in ipairs(rows) do
					if r.display == line then
						chat_id = r.chat_id
						ws_hash = r.ws_hash
						break
					end
				end
				if not chat_id or chat_id == "" then
					return
				end
				local cmd = { "cursor-agent" }
				if vim.fn.executable("cursor-agent") == 0 then
					cmd = { "agent" }
				end
				vim.list_extend(cmd, { "--resume=" .. chat_id })
				if cwd_hash and ws_hash == cwd_hash then
					table.insert(cmd, "--workspace=" .. cwd)
				end

				-- Avoid a second Cursor Agent split (cursoragent.nvim) + our termopen = duplicate UIs.
				pcall(function()
					require("cursoragent.terminal").close()
				end)

				-- Same idea as cursoragent.nvim native: new vsplit on the right, fresh buffer (no :split on file).
				local pct = 0.4
				local ok_pct, mod = pcall(require, "cursoragent.terminal")
				if ok_pct and mod and mod.defaults and type(mod.defaults.split_width_percentage) == "number" then
					pct = mod.defaults.split_width_percentage
				end
				local width = math.max(20, math.floor(vim.o.columns * pct))
				vim.cmd("vertical botright " .. width .. "vsplit")
				vim.cmd("enew")
				vim.fn.termopen(cmd, { cwd = cwd })
				local win = vim.api.nvim_get_current_win()
				vim.api.nvim_win_set_option(win, "number", false)
				vim.api.nvim_win_set_option(win, "relativenumber", false)
				vim.api.nvim_win_set_option(win, "signcolumn", "no")
				vim.cmd("startinsert")
			end)
		end,
	}))
end

return M
