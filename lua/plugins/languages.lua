return {
	{
		"pangloss/vim-javascript",
		init = function()
			-- indent guides / polyglot (plugins may be absent; g: kept for when installed)
			vim.g.indentLine_color_gui = "#3b3b3b"
			vim.g.indentLine_char = "┆"
			vim.g.polyglot_disabled = {
				"javascript",
				"javascript.jsx",
				"javascriptreact",
				"typescript",
			}
		end,
	},
	{ "yuezk/vim-js" },
	{ "maxmellon/vim-jsx-pretty" },
	{ "elzr/vim-json" },
	{ "othree/yajs.vim" },
	{ "othree/jspc.vim" },
	{ "mustache/vim-mustache-handlebars" },
	{ "ruanyl/vim-sort-imports" },
	{
		"neoclide/coc.nvim",
		branch = "release",
		init = function()
			vim.g.coc_global_extensions = {
				"coc-json",
				"coc-tsserver-dev",
				"coc-go",
				"coc-graphql",
				"coc-highlight",
				"coc-html",
				"coc-htmlhint",
				"coc-html-css-support",
				"@yaegassy/coc-laravel",
				"coc-lists",
				"coc-lua",
				"coc-markdownlint",
				"coc-webview",
				"coc-prisma",
				"coc-stylelint",
				"coc-sql",
				"coc-svg",
				"coc-swagger",
				"coc-xml",
				"coc-yaml",
				"coc-yank",
				"coc-markdown-preview-enhanced",
				"coc-blade",
				"coc-fzf-preview",
				"coc-cssmodules",
				"coc-docker",
				"coc-css",
				"@yaegassy/coc-astro",
				"coc-class-css",
				-- "coc-copilot" — off while copilot.vim / CopilotChat are disabled (extras.lua)
				"coc-emmet",
				"@yaegassy/coc-nginx",
				"@yaegassy/coc-tailwindcss3",
				"@yaegassy/coc-volar",
			}
		end,
	},

	{ "leafgarland/typescript-vim" },
	{ "peitalin/vim-jsx-typescript" },
	{ "jparise/vim-graphql" },

	{ "othree/html5.vim" },
	{
		"mattn/emmet-vim",
		init = function()
			vim.g.user_emmet_install_global = 0
			vim.g.user_emmet_settings = {
				jsx = {
					attribute_name = {
						["for"] = "htmlFor",
						class = "className",
						quote_char = "''",
					},
				},
				javascriptreact = { extends = "jsx" },
				javascript = { extends = "jsx" },
				typescript = { extends = "jsx" },
				typescriptreact = { extends = "jsx" },
				astro = { extends = "html" },
				["vue-html"] = { extends = "html" },
				vue = { extends = "html" },
			}
		end,
		config = function()
			local aug = vim.api.nvim_create_augroup("nvim_user_emmet_install", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = aug,
				pattern = {
					"html",
					"css",
					"html.mustache",
					"eruby",
					"jst",
					"html.handlebars",
					"pug",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"astro",
					"vue",
					"html.vue",
				},
				command = "EmmetInstall",
			})
		end,
	},
	{
		"andymass/vim-matchup",
		init = function()
			vim.g.loaded_matchit = 1
		end,
	},
	{ "digitaltoad/vim-pug" },

	{ "Shougo/vimproc.vim", build = "make" },
	{
		"bitc/vim-hdevtools",
		config = function()
			local aug = vim.api.nvim_create_augroup("nvim_user_hdevtools_maps", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = aug,
				pattern = "haskell",
				callback = function(args)
					vim.keymap.set("n", "<F1>", ":HdevtoolsType<CR>", { buffer = args.buf })
					vim.keymap.set("n", "<F2>", ":HdevtoolsClear<CR>", { buffer = args.buf, silent = true })
				end,
			})
		end,
	},
	{ "eagletmt/ghcmod-vim" },
	{ "eagletmt/neco-ghc" },

	{ "fidian/hexmode" },
	{ "edkolev/tmuxline.vim" },
	{
		"justinmk/vim-sneak",
		init = function()
			vim.g["sneak#label"] = 1
		end,
	},
	{
		"unblevable/quick-scope",
		init = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
		end,
	},
	{ "reasonml-editor/vim-reason-plus" },
	{ "vim-erlang/vim-erlang-runtime" },
	{
		"luochen1990/rainbow",
		init = function()
			vim.g.rainbow_active = 1
		end,
	},
	{ "pantharshit00/vim-prisma" },

	{ "StanAngeloff/php.vim" },
	{ "stephpy/vim-php-cs-fixer" },
	{ "tpope/vim-dispatch" },
	{ "tpope/vim-projectionist" },
	{ "noahfrederick/vim-composer" },
	{ "noahfrederick/vim-laravel" },
	{ "2072/PHP-Indenting-for-VIm" },

	{
		"leafoftree/vim-vue-plugin",
		init = function()
			vim.g.vue_disable_pre_processors = 1
		end,
	},
	{ "posva/vim-vue" },
	{
		"yaegassy/coc-volar",
		-- yarn may append "packageManager" to package.json; restore so lazy git stays clean
		build = "yarn install --frozen-lockfile && git checkout -- package.json 2>/dev/null || true",
	},
	{
		"yaegassy/coc-volar-tools",
		build = "yarn install --frozen-lockfile && git checkout -- package.json 2>/dev/null || true",
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "(cd app && npx --yes yarn install); git checkout -- package.json 2>/dev/null || true",
	},

	{ "hashivim/vim-terraform" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- Keep treesitter scoped to daily languages to avoid broad behavior changes.
			local ts_languages = {
				"astro",
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"json",
				"yaml",
				"bash",
				"markdown",
				"markdown_inline",
				"vue",
			}
			local ts_enabled = {}
			for _, lang in ipairs(ts_languages) do
				ts_enabled[lang] = true
			end

			local ok, ts_install = pcall(require, "nvim-treesitter.install")
			if ok and ts_install and type(ts_install.ensure_installed) == "function" then
				pcall(ts_install.ensure_installed, ts_languages)
			end
			local ok_cfg, ts_cfg = pcall(require, "nvim-treesitter.configs")
			if ok_cfg and ts_cfg and type(ts_cfg.setup) == "function" then
				ts_cfg.setup({
					highlight = {
						enable = true,
						-- Do not enable globally for every parser; keep an explicit whitelist.
						disable = function(lang)
							return not ts_enabled[lang]
						end,
					},
				})
			end
		end,
	},

	{ "pearofducks/ansible-vim" },
}
