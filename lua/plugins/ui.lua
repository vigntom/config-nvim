return {
	{
		"folke/snacks.nvim",
		enabled = false,
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},
	{
		"MunifTanjim/nui.nvim",
		lazy = false,
		config = function()
			require("ui.input").setup()
		end,
	},
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
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				delay = 300,
			})
		end,
	},
	{
		"mhinz/vim-startify",
		init = function()
			vim.g.startify_bookmarks = {
				{ i = vim.fn.stdpath("config") .. "/init.lua" },
				{ l = vim.fn.expand("~/.config/nvim/lua/config/lazy.lua") },
				{ p = vim.fn.expand("~/.config/nvim/lua/plugins/init.lua") },
				{ c = vim.fn.stdpath("config") .. "/coc-settings.json" },
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
