return {
	{ "nvim-lua/plenary.nvim" },
	-- Stack: coc.nvim (+ ale_* flags in init.lua). cmp had no setup(); loading both risks noise.
	{ "hrsh7th/nvim-cmp", enabled = false },
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
	-- GitHub Copilot stack off for now (completion via coc; avoid <C-Space> clash with coc#refresh).
	-- Re-enable both and restore coc-copilot in languages.lua when you want Copilot back.
	{ "github/copilot.vim", enabled = false },
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		enabled = false,
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
