-- Unified Neovim entrypoint (former init.vim).

vim.g.ale_disable_lsp = 1
vim.g.ale_completion_enabled = 0

require("options").setup()
require("commands").setup()
require("keymaps").setup()
require("autocmds").setup()
require("config.lazy")

for _, rel in ipairs({
	"settings/commands.vim",
	"settings/config.vim",
	"settings/mappings.vim",
}) do
	local path = vim.fn.stdpath("config") .. "/" .. rel
	path = vim.fn.expand(path)
	if vim.fn.filereadable(path) == 1 then
		vim.cmd.source(vim.fn.fnameescape(path))
	end
end
