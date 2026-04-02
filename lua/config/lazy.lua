local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("plugins"), {
	-- Match vim-plug style startup until we tune lazy-loading per plugin
	defaults = { lazy = false },
	install = { colorscheme = { "mustang" } },
	change_detection = { notify = false },
})

-- Same order as legacy plugins.vim (after plug#end): globals then CopilotChat
require("plugin_globals").setup()
