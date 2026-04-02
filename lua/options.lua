local M = {}

function M.setup()
  -- Editor / windows (Neovim defaults for vsplit/split: new window placement)
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  vim.opt.cmdheight = 2
  -- Merge gitgutter/LSP signs into number column (no layout shift)
  vim.opt.signcolumn = "number"

  -- coc-friendly baseline (also former settings/config.vim)
  vim.opt.hidden = true
  vim.opt.backup = false
  vim.opt.writebackup = false
  vim.opt.updatetime = 300
  vim.opt.shortmess:append("c")
  vim.opt.termguicolors = true
  vim.opt.clipboard = "unnamedplus"
  vim.opt.completeopt:remove("preview")

  -- Indent / buffer text (from settings/config.vim)
  vim.opt.autoindent = true
  -- legacy: set backspace=2 (indent + eol, not "start")
  vim.opt.backspace = { "indent", "eol" }
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.smarttab = true
  vim.opt.encoding = "utf-8"

  -- Search
  vim.opt.incsearch = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- List chars (when :set list)
  vim.opt.listchars =
    "space:·,tab:▸ ,trail:▫,extends:>,precedes:<,nbsp:+,eol:¬"

  -- Hybrid: absolute on cursor line, relative elsewhere
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.ruler = true
  vim.opt.mouse = "a"

  vim.opt.undofile = true
  vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")

  vim.opt.wrap = false
  vim.opt.linebreak = true
  vim.opt.autoread = true

  vim.opt.backupcopy = "yes"

  -- Swap files: legacy had `directory-=.`, then later `directory=/var/tmp` (final)
  vim.opt.directory = "/var/tmp"

  -- Quiet bell (legacy: noerrorbells visualbell t_vb=)
  vim.opt.errorbells = false
  vim.opt.visualbell = true
  -- t_vb is not exposed via vim.opt in Neovim; keep Vim-compatible clearing
  vim.cmd("set t_vb=")

  local aug = vim.api.nvim_create_augroup("nvim_user_legacy_ux", { clear = true })

  vim.api.nvim_create_autocmd("GUIEnter", {
    group = aug,
    callback = function()
      vim.opt.visualbell = true
      vim.cmd("set t_vb=")
    end,
  })

  local js_ts = { "*.js", "*.jsx", "*.ts", "*.tsx" }
  vim.api.nvim_create_autocmd("BufEnter", {
    group = aug,
    pattern = js_ts,
    command = "syntax sync fromstart",
  })
  vim.api.nvim_create_autocmd("BufLeave", {
    group = aug,
    pattern = js_ts,
    command = "syntax sync clear",
  })
end

return M
