-- lua/plugins/ai_completion.lua
return {
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local ai = require("config.ai")
			require("minuet").setup(ai.minuet.get_setup())

			-- FZF-пикер моделей
			vim.api.nvim_create_user_command("MinuetPick", function()
				local items = {}
				for _, m in ipairs(ai.minuet.models) do
					table.insert(items, string.format("%s  (%s)", m.label, m.provider))
				end

				vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
					source = items,
					options = '--prompt="Model> "',
					["sink*"] = function(lines)
						local line = lines[1]
						if not line then
							return
						end

						for _, m in ipairs(ai.minuet.models) do
							local label = string.format("%s  (%s)", m.label, m.provider)
							if label == line then
								require("minuet").setup(ai.minuet.build_for(m))
								vim.notify("Minuet: switched to " .. m.label, vim.log.levels.INFO)
								break
							end
						end
					end,
				}))
			end, { desc = "Pick Minuet model via FZF" })

			vim.keymap.set("n", "<leader>zm", "<cmd>MinuetPick<cr>", { desc = "Minuet: pick model" })
		end,
	},
}
