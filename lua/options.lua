local M = {}

function M.setup()
  -- Editor / windows (Neovim defaults for vsplit/split: new window placement)
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  -- coc-friendly baseline (also former settings/config.vim)
  vim.opt.hidden = true
  vim.opt.backup = false
  vim.opt.writebackup = false
  vim.opt.updatetime = 300
  vim.opt.shortmess:append("c")
  vim.opt.termguicolors = true
  vim.opt.clipboard = "unnamedplus"
  vim.opt.completeopt:remove("preview")
end

return M
