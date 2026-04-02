-- Plugin specs split by area; order matches legacy plugins.vim (vim-plug).
return {
	{ import = "plugins.colorscheme" },
	{ import = "plugins.ui" },
	{ import = "plugins.ale" },
	{ import = "plugins.general" },
	{ import = "plugins.languages" },
	{ import = "plugins.extras" },
	{ import = "plugins.cursor_cli" },
}
