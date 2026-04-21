-- Agent Client Protocol (ACP) chat UI; provider = Cursor CLI (`cursor-acp`).
-- See https://github.com/carlos-algms/agentic.nvim — requires `cursor-agent` / ACP install per upstream README.
return {
	{
		"carlos-algms/agentic.nvim",
		dependencies = {
			{ "hakonharnes/img-clip.nvim", opts = {} },
		},
		--- @type agentic.PartialUserConfig
		opts = {
			provider = "cursor-acp",
		},
		-- Reuse former cursoragent prefix `<leader>o` (cursor_cli.lua is disabled).
		keys = {
			{
				"<leader>oc",
				function()
					require("agentic").toggle()
				end,
				mode = { "n", "v", "i" },
				desc = "Agentic: toggle chat",
			},
			{
				"<leader>ox",
				function()
					require("agentic").add_selection_or_file_to_context()
				end,
				mode = { "n", "v" },
				desc = "Agentic: add file or selection to context",
			},
			{
				"<leader>on",
				function()
					require("agentic").new_session()
				end,
				mode = { "n", "v", "i" },
				desc = "Agentic: new session",
			},
			{
				"<leader>or",
				function()
					require("agentic").restore_session()
				end,
				mode = { "n", "v", "i" },
				desc = "Agentic: restore session",
			},
			{
				"<leader>ob",
				function()
					require("agentic").add_file()
				end,
				mode = { "n" },
				desc = "Agentic: add current file to context",
			},
			{
				"<leader>os",
				function()
					require("agentic").add_selection()
				end,
				mode = "x",
				desc = "Agentic: add visual selection to context",
			},
		},
	},
}
