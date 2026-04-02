return {
	{
		"Raimondi/delimitMate",
		init = function()
			vim.g.delimitMate_expanded_cr = 1
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
	{ "junegunn/vim-easy-align" },
	{ "mbbill/undotree" },

	{ "tpope/vim-commentary" },
	{ "tpope/vim-fugitive" },
	{ "rhysd/committia.vim" },
	{ "airblade/vim-gitgutter" },

	{ "skywind3000/asyncrun.vim" },
	{ "majutsushi/tagbar" },
	{ "Chrisbra/Colorizer", cmd = "ColorToggle" },
}
