-- Agent Client Protocol (ACP) chat UI; provider = Cursor CLI (`cursor-acp`).
-- See https://github.com/carlos-algms/agentic.nvim — we spawn `agent acp` (same as Cursor Avante recipe), not `cursor-agent`.

--- Current model label for winbar (Cursor ACP may omit model list — then selector can no-op).
local function agentic_model_label()
	local ok, reg = pcall(require, "agentic.session_registry")
	if not ok or not reg then
		return nil
	end
	local session = reg.get_session_for_tab_page(nil)
	if not session or not session.config_options then
		return nil
	end
	local co = session.config_options
	local id = co.model and co.model.currentValue or co.legacy_agent_models.current_model_id
	if not id or id == "" then
		return nil
	end
	local opt = co:get_model(id)
	if opt and opt.name and opt.name ~= "" then
		return opt.name
	end
	local leg = co.legacy_agent_models:get_model(id)
	if leg and leg.name and leg.name ~= "" then
		return leg.name
	end
	return id
end

--- Winbar: default parts + "Model: …" when known (plugin only sets Mode in context).
local function agentic_chat_header(parts)
	local bits = {}
	if parts.title and parts.title ~= "" then
		table.insert(bits, parts.title)
	end
	if parts.context and parts.context ~= "" then
		table.insert(bits, parts.context)
	end
	local ml = agentic_model_label()
	if ml then
		table.insert(bits, "Model: " .. ml)
	end
	if parts.suffix and parts.suffix ~= "" then
		table.insert(bits, parts.suffix)
	end
	return table.concat(bits, " | ")
end

return {
	{
		"carlos-algms/agentic.nvim",
		-- Off: stable path is FZF + `cursor-agent --resume` (`lua/cursor_chats.lua`, :CursorChats).
		-- Set `enabled = true` to try ACP UI again; future: optional local plugin may wrap the same flow.
		enabled = false,
		dependencies = {
			{ "hakonharnes/img-clip.nvim", opts = {} },
		},
		--- @type agentic.PartialUserConfig
		opts = {
			provider = "cursor-acp",
			acp_providers = {
				["cursor-acp"] = {
					command = "agent",
					args = { "acp" },
				},
			},
			diff_preview = {
				enabled = true,
				layout = "split",
				center_on_navigate_hunks = true,
			},
			headers = {
				chat = agentic_chat_header,
			},
			hooks = {
				on_session_update = function(data)
					if data.update.sessionUpdate ~= "config_option_update" then
						return
					end
					vim.schedule(function()
						local reg = require("agentic.session_registry")
						local session = reg.get_session_for_tab_page(data.tab_page_id)
						if session and session.widget and session.widget:is_open() then
							session.widget:render_header("chat")
						end
					end)
				end,
			},
		},
		-- Reuse former cursoragent prefix `<leader>o` (cursor_cli.lua is disabled).
		keys = {
			{
				"<leader>oc",
				function()
					require("agentic").toggle()
				end,
				mode = { "n", "v" },
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
				mode = { "n", "v" },
				desc = "Agentic: new session",
			},
			{
				"<leader>or",
				function()
					require("agentic").restore_session()
				end,
				mode = { "n", "v" },
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
			{
				"<leader>od",
				function()
					if vim.fn.exists(":Git") == 2 then
						vim.cmd("vert Git diff -- %")
						return
					end
					vim.cmd("vert rightbelow split | terminal git diff -- " .. vim.fn.shellescape(vim.fn.expand("%:p")))
				end,
				mode = { "n" },
				desc = "Agentic: git diff current file",
			},
		},
	},
}
