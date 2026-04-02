local M = {}

function M.setup()
	-- Must run before lazy.nvim (see require order in init.vim); mappings.vim sets the same later.
	vim.g.mapleader = " "

	-- Lua keymaps will be moved here incrementally.
end

return M
