return {
	{ "nvim-lua/plenary.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{
		"ervandew/supertab",
		init = function()
			vim.g.SuperTabDefaultCompletionType = "<c-n>"
		end,
	},
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{
		"t9md/vim-choosewin",
		init = function()
			vim.g.choosewin_overlay_enable = 1
		end,
	},
	{ "github/copilot.vim" },

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "github/copilot.vim" },
		},
		config = function()
			require("CopilotChat").setup({
				debug = true,
				mappings = {
					complete = {
						normal = "<C-Space>",
						insert = "<C-Space>",
					},
				},
			})
		end,
	},
}
