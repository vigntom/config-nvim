local M = {}

--- Plugin globals that must run after plug#end() (sourced from plugins.vim).
function M.setup()
	-- seiya.vim (Plug line may be commented; vars are harmless)
	vim.g.seiya_target_groups = vim.fn.has("nvim") == 1 and { "guibg" } or { "ctermbg" }
	vim.g.seiya_auto_enable = 1

	if vim.fn.exists("g:airline_symbols") == 0 then
		vim.g.airline_symbols = vim.empty_dict()
	end
	vim.g.airline_powerline_fonts = 1
	-- legacy commented: g:airline_theme, g:airline_symbols.space

	vim.g.tmuxline_preset = "full"
	vim.g["airline#extensions#tmuxline#enabled"] = 1
	vim.g["airline#extensions#ale#enabled"] = 1

	-- legacy commented: g:indentLine_setColors = 0
	vim.g.indentLine_color_gui = "#3b3b3b"
	vim.g.indentLine_char = "┆"

	vim.g.polyglot_disabled = {
		"javascript",
		"javascript.jsx",
		"javascriptreact",
		"typescript",
	}

	vim.g.choosewin_overlay_enable = 1
end

return M
