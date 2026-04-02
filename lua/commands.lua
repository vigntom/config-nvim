local M = {}

function M.setup()
	-- Former vim-plug `command! PU PlugUpdate | so $MYVIMRC | ...` — now lazy.nvim only.
	vim.api.nvim_create_user_command("PU", function()
		vim.cmd("Lazy sync")
	end, { desc = "Plugin update: Lazy sync (replaces vim-plug PlugUpdate)" })
end

return M
