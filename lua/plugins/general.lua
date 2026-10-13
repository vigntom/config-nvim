return {
	-- ==========================================
	-- МОДУЛИ MINI.NVIM (Современная база)
	-- ==========================================
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Выравнивание колонок (ga + `)
			require("mini.align").setup({
				mappings = { start = "ga", start_with_preview = "gA" },
				modifiers = {
					["`"] = function(steps, opts)
						opts.filter = "first"
					end,
				},
			})

			require("mini.pairs").setup() -- Автозакрытие скобок
			require("mini.surround").setup() -- Окружение (кавычки)
			require("mini.comment").setup() -- Комментарии (gcc)
			require("mini.jump2d").setup({ -- Прыжки по экрану
				mappings = { start_jumping = "<Leader>j" },
			})

			require("mini.indentscope").setup() -- Подсветка блоков кода линиями
			require("mini.bufremove").setup() -- Умное удаление буферов без закрытия окон
			require("mini.cursorword").setup() -- Подсветка слова под курсором
		end,
	},

	-- ==========================================
	-- ОСТАЛЬНЫЕ ВАШИ ПЛАГИНЫ
	-- ==========================================
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				hint = "floating-big-letter", -- Большие буквы по центру окон
				selection_chars = "FJDKSLA;CMRUEIWOQP", -- Удобные клавиши под пальцы
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					-- Игнорируем технические окна вроде Neo-tree или всплывающих окон подсказок
					bo = {
						filetype = { "neon-tree", "NvimTree", "notify" },
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	},
	{ "isobit/vim-caddyfile" },
	{
		"junegunn/fzf",
		dir = vim.fn.expand("~/.config/nvim/plugsrc/fzf"),
		build = "./install --all",
	},
	{ "junegunn/fzf.vim" },
	{ "lvht/fzf-mru" },
	{ "mbbill/undotree" },
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({ view_options = { show_hidden = true } })
		end,
	},
	{ "tpope/vim-fugitive" },
	{ "rhysd/committia.vim" },
	{ "airblade/vim-gitgutter" },
	{
		"skywind3000/asyncrun.vim",
		config = function()
			local aug = vim.api.nvim_create_augroup("nvim_user_standard_fix", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = aug,
				pattern = "*.js",
				callback = function()
					if vim.bo.filetype == "javascript" then
						vim.cmd("AsyncRun -post=checktime ./node_modules/.bin/standard --fix %")
					end
				end,
			})
		end,
	},
	{
		"majutsushi/tagbar",
		init = function()
			if vim.fn.executable("ctags") == 1 then
				vim.g.tagbar_ctags_bin = "ctags"
			end
		end,
	},
	{ "Chrisbra/Colorizer", cmd = "ColorToggle" },
}
