return {
	{
		"vim-airline/vim-airline",
		init = function()
			-- seiya.vim optional (Plug was commented in legacy); vars harmless
			vim.g.seiya_target_groups = vim.fn.has("nvim") == 1 and { "guibg" } or { "ctermbg" }
			vim.g.seiya_auto_enable = 1
			if vim.fn.exists("g:airline_symbols") == 0 then
				vim.g.airline_symbols = vim.empty_dict()
			end
			vim.g.airline_powerline_fonts = 1
			vim.g.tmuxline_preset = "full"
			vim.g["airline#extensions#tmuxline#enabled"] = 1
			vim.g["airline#extensions#ale#enabled"] = 1
		end,
	},
	{ "vim-airline/vim-airline-themes" },
	{
		"mhinz/vim-startify",
		init = function()
			vim.g.startify_bookmarks = {
				{ i = vim.fn.expand("~/.config/nvim/init.vim") },
				{ l = vim.fn.expand("~/.config/nvim/lua/config/lazy.lua") },
				{ p = vim.fn.expand("~/.config/nvim/lua/plugins/init.lua") },
				{ c = vim.fn.expand("~/.config/nvim/settings/config.vim") },
				{ m = vim.fn.expand("~/.config/nvim/lua/keymaps.lua") },
			}
			vim.g.startify_commands = {
				{ r = { "Reload", "source $MYVIMRC" } },
				{ u = { "Reload + Lazy sync", "source $MYVIMRC | Lazy sync" } },
				{ U = { "Lazy sync", "Lazy sync" } },
				{ g = { "Lazy UI", "Lazy" } },
				{ [";"] = { "Restart Startify", "Startify" } },
			}
		end,
	},
	{ "vim-scripts/BufOnly.vim" },
	{ "editorconfig/editorconfig-vim" },
	{ "chrisbra/NrrwRgn" },
	{ "christoomey/vim-titlecase" },
}
