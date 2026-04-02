-- Unified Neovim entrypoint (former init.vim).

vim.g.ale_disable_lsp = 1
vim.g.ale_completion_enabled = 0

require("options").setup()
require("commands").setup()
require("keymaps").setup()
require("autocmds").setup()
require("config.lazy")
