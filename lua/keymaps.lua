local M = {}

function M.setup()
	-- Must run before lazy.nvim (see require order in init.lua).
	vim.g.mapleader = " "
	vim.g.maplocalleader = "/"

	require("keymaps.editor").setup()
	require("keymaps.integrations").setup()
	require("keymaps.coc").setup()
end

return M
