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
	{ "neoclide/coc.nvim", branch = "release" },

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
				["vue-html"] = { extends = "html" },
				vue = { extends = "html" },
			}
		end,
	},
	{ "andymass/vim-matchup" },
	{ "digitaltoad/vim-pug" },

	{ "Shougo/vimproc.vim", build = "make" },
	{ "bitc/vim-hdevtools" },
	{ "eagletmt/ghcmod-vim" },
	{ "eagletmt/neco-ghc" },

	{ "fidian/hexmode" },
	{ "edkolev/tmuxline.vim" },
	{ "justinmk/vim-sneak" },
	{ "unblevable/quick-scope" },
	{ "reasonml-editor/vim-reason-plus" },
	{ "vim-erlang/vim-erlang-runtime" },
	{ "luochen1990/rainbow" },
	{ "pantharshit00/vim-prisma" },

	{ "StanAngeloff/php.vim" },
	{ "stephpy/vim-php-cs-fixer" },
	{ "tpope/vim-dispatch" },
	{ "tpope/vim-projectionist" },
	{ "noahfrederick/vim-composer" },
	{ "noahfrederick/vim-laravel" },
	{ "2072/PHP-Indenting-for-VIm" },

	{ "leafoftree/vim-vue-plugin" },
	{ "posva/vim-vue" },
	{
		"yaegassy/coc-volar",
		build = "yarn install --frozen-lockfile",
	},
	{
		"yaegassy/coc-volar-tools",
		build = "yarn install --frozen-lockfile",
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npx --yes yarn install",
	},

	{ "hashivim/vim-terraform" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	{ "pearofducks/ansible-vim" },
}
