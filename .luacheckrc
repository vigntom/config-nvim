-- Neovim injects `vim`; luacheck otherwise reports undefined global.
return {
	globals = {
		vim = true,
	},
}
