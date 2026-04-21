-- Cursor Agent CLI (`cursor-agent` on PATH). See :h and cursor-user/PLUGINS-HANDBOOK.md.
-- Disabled in favor of `plugins/agentic.lua` (ACP). Set `enabled = true` to bring back `<leader>o*`.
return {
	{
		"aug6th/cursoragent.nvim",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("cursoragent").setup({
				terminal = {
					split_side = "right",
					split_width_percentage = 0.4,
				},
			})

			local d = function(lhs, rhs, modes, desc)
				vim.keymap.set(modes, lhs, rhs, { desc = desc })
			end

			-- Prefix <leader>o — kept free of coc (<leader>f/ac/qf) and fzf (zf/zb/zl).
			d("<leader>oc", "<Cmd>CursorAgent<CR>", "n", "Cursor Agent: toggle")
			d("<leader>oa", "<Cmd>CursorAgentAsk<CR>", "n", "Cursor Agent: ask mode")
			d("<leader>op", "<Cmd>CursorAgentPlan<CR>", "n", "Cursor Agent: plan mode")
			d("<leader>or", "<Cmd>CursorAgentResume<CR>", "n", "Cursor Agent: resume")
			d("<leader>ob", "<Cmd>CursorAgentBuffer<CR>", "n", "Cursor Agent: send buffer")
			d("<leader>os", "<Cmd>CursorAgentSelection<CR>", "x", "Cursor Agent: send selection")
		end,
	},
}
