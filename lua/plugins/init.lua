-- Plugin specs split by area (historical order ~ former vim-plug list).
return {
	{ import = "plugins.colorscheme" },
	{ import = "plugins.ui" },
	{ import = "plugins.ale" },
	{ import = "plugins.general" },
	{ import = "plugins.languages" },
	{ import = "plugins.extras" },
	-- Avante / Agentic: disabled in specs (see plugins/*.lua). Chats: :CursorChats, <leader>zc → cursor_chats.lua
	-- { import = "plugins.avante" },
	-- { import = "plugins.agentic" },
	{ import = "plugins.cursor_cli" },
}
