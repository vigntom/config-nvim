local M = {}

function M.setup()
	-- Environment (legacy top of settings/config.vim)
	vim.opt.shell = "zsh"

	if vim.fn.has("gui") == 1 then
		vim.cmd("set guioptions-=m")
		vim.cmd("set guioptions-=T")
		vim.cmd("set guioptions-=r")
	end

	-- 256-color title bar hints (legacy let &t_AB / &t_AF; was outside ConEmu if)
	vim.cmd([[let &t_AB="\e[48;5;%dm"]])
	vim.cmd([[let &t_AF="\e[38;5;%dm"]])

	-- Syntax & filetype (legacy settings/config.vim)
	vim.cmd("syntax on")
	vim.cmd("syntax enable")
	vim.cmd("filetype plugin indent on")

	-- Disable automatic comment leader on new line (legacy settings/config.vim)
	local aug_fo = vim.api.nvim_create_augroup("nvim_user_formatoptions", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = aug_fo,
		pattern = "*",
		command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
	})

	-- After startup: helptags (plugins on rtp via lazy) + colors (mustang) + GUI font
	local aug_enter = vim.api.nvim_create_augroup("nvim_user_vimenter", { clear = true })
	vim.api.nvim_create_autocmd("VimEnter", {
		group = aug_enter,
		once = true,
		callback = function()
			vim.cmd("silent! helptags ALL")
			vim.opt.background = "dark"
			vim.cmd("colorscheme mustang")
			vim.opt.guifont = "Terminess Powerline:h12"
			vim.opt.guicursor = ""
			vim.opt.colorcolumn = "120"
			vim.cmd("highlight ColorColumn ctermbg=9")
		end,
	})

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
	-- indent,eol,start — "start" needed to backspace after moving cursor in Insert (e.g. Agentic prompt).
	vim.opt.backspace = { "indent", "eol", "start" }
	vim.opt.tabstop = 4
	vim.opt.softtabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.expandtab = true
	vim.opt.smarttab = true
	vim.opt.encoding = "utf-8"

	-- Russian JCUKEN: same physical keys as Latin in Normal/Visual/Cmdline (:h langmap).
	-- e.g. press key at QWERTY `i` (types `ш`) → behaves as `i` / `I` without switching layout.
	-- Also map RU `ю` key to `/` so <LocalLeader> ("/") works in EN/RU layouts.
	vim.opt.langmap = "ш;i,Ш;I,ю;/,Ю;?"

	-- Search
	vim.opt.incsearch = true
	vim.opt.ignorecase = true
	vim.opt.smartcase = true

	-- List chars (when :set list)
	vim.opt.listchars = "space:·,tab:▸ ,trail:▫,extends:>,precedes:<,nbsp:+,eol:¬"

	-- Hybrid: absolute on cursor line, relative elsewhere
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.ruler = true
	vim.opt.mouse = "a"
	-- lazyredraw defers full redraw → ghost lines until resize/C-L; see TermOpen handler in autocmds.lua.

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

	-- TMUX vs terminal cursor shape (legacy settings/config.vim)
	if vim.env.TMUX ~= nil and vim.env.TMUX ~= "" then
		vim.cmd([[let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"]])
		vim.cmd([[let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"]])
	else
		vim.cmd([[let &t_SI = "\<Esc>]50;CursorShape=1\x7"]])
		vim.cmd([[let &t_EI = "\<Esc>]50;CursorShape=0\x7"]])
	end

	vim.opt.tags:append("gems.tags")

	vim.keymap.set("v", "p", '"_dP', { desc = "Paste without replacing unnamed register" })

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
