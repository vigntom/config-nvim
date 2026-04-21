local M = {}

function M.setup()
	-- Former vim-plug `command! PU PlugUpdate | so $MYVIMRC | ...` — now lazy.nvim only.
	vim.api.nvim_create_user_command("PU", function()
		vim.cmd("Lazy sync")
	end, { desc = "Plugin update: Lazy sync (replaces vim-plug PlugUpdate)" })

	vim.api.nvim_create_user_command("CursorChats", function()
		require("cursor_chats").open_pick()
	end, { desc = "FZF: pick Cursor Agent chat and resume (needs sqlite3, fzf.vim, cursor-agent)" })
end

return M
