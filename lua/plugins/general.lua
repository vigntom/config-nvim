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
	{
		"preservim/nerdtree",
		cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFocus", "NERDTreeClose", "NERDTreeFind" },
	},
	{ "easymotion/vim-easymotion" },

	{ "tpope/vim-commentary" },
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
			-- Tagbar shells out to `ctags` (Exuberant-compatible). Arch/Manjaro: `pacman -S ctags`.
			if vim.fn.executable("ctags") == 1 then
				vim.g.tagbar_ctags_bin = "ctags"
			end
		end,
	},
	{ "Chrisbra/Colorizer", cmd = "ColorToggle" },
}
