local M = {}

function M.setup()
	-- Must run before lazy.nvim (see require order in init.vim).
	vim.g.mapleader = " "

	require("keymaps.core").setup()
	require("keymaps.coc").setup()
end

return M
