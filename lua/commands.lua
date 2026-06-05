local M = {}

function M.setup()
	-- Former vim-plug `command! PU PlugUpdate | so $MYVIMRC | ...` — now lazy.nvim only.
	vim.api.nvim_create_user_command("PU", function()
		vim.cmd("Lazy sync")
	end, { desc = "Plugin update: Lazy sync (replaces vim-plug PlugUpdate)" })

	vim.api.nvim_create_user_command("CursorChats", function()
		require("cursor_chats").open_pick()
	end, { desc = "FZF: pick Cursor Agent chat and resume (needs sqlite3, fzf.vim, cursor-agent)" })

	vim.api.nvim_create_user_command("AIChatOpen", function(opts)
		local exe = nil
		if vim.fn.executable("cursor-agent") == 1 then
			exe = "cursor-agent"
		elseif vim.fn.executable("agent") == 1 then
			exe = "agent"
		end
		if not exe then
			vim.notify("cursor-agent/agent not found in PATH", vim.log.levels.ERROR)
			return
		end

		local cmd = { exe }
		for _, arg in ipairs(opts.fargs or {}) do
			table.insert(cmd, arg)
		end

		vim.cmd("tabnew")
		vim.cmd("enew")
		vim.fn.termopen(cmd, { cwd = vim.loop.cwd() })
		vim.cmd("startinsert")
	end, {
		nargs = "*",
		complete = "file",
		desc = "Open cursor-agent in dedicated tab (example: :AIChatOpen --resume)",
	})

	vim.api.nvim_create_user_command("AIChatClose", function()
		-- Close chat tab when more than one tab is open.
		if #vim.api.nvim_list_tabpages() > 1 then
			vim.cmd("tabclose")
		end
	end, { desc = "Close Cursor Agent and return by closing chat tab" })
end

return M
