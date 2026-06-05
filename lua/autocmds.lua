local M = {}

function M.setup()
	local aug = vim.api.nvim_create_augroup("nvim_user_autocmds", { clear = true })

	-- Filetype detection (legacy settings/config.vim "File detect")
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "*asterisk*/*.conf",
		command = "set filetype=asterisk",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "*Xresources.d/*",
		command = "set filetype=xdefaults",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "sed.*",
		command = "set filetype=sed",
	})
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = aug,
		pattern = { ".gemrc", ".irbrc", ".pryrc" },
		callback = function()
			vim.cmd("setf ruby")
		end,
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "/etc/sudoers.d/*",
		command = "set filetype=sudoers",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = vim.fn.expand("~/.moe/config/Xresources.d/xsession.*/*"),
		command = "set filetype=sh",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "xmonad.hs",
		callback = function()
			vim.g.hdevtools_options = "-g -i" .. vim.fn.expand("$HOME/.xmonad/lib")
		end,
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "named.conf",
		command = "set filetype=named",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "named.zone",
		command = "set filetype=bindzone",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = vim.fn.expand("~/.ghci"),
		command = "set filetype=haskell",
	})
	for _, name in ipairs({
		".babelrc",
		".eslintrc",
		".haskyrc",
		".lintstagerc",
		".prettierrc",
	}) do
		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			group = aug,
			pattern = name,
			command = "set filetype=json",
		})
	end
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "*.scss",
		command = "set filetype=scss.css",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = vim.fn.expand("~/.xmonad/*"),
		callback = function()
			local flag = "-i" .. vim.fn.expand("~/.xmonad/lib")
			if vim.b.ghcmod_ghc_options == nil then
				vim.b.ghcmod_ghc_options = {}
			end
			local opts = vim.b.ghcmod_ghc_options
			for _, v in ipairs(opts) do
				if v == flag then
					return
				end
			end
			table.insert(opts, flag)
		end,
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "*nginx/*.template",
		command = "set filetype=nginx",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "*nginx/*.inc",
		command = "set filetype=nginx",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "*.graphql",
		command = "setfiletype graphql",
	})
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = aug,
		pattern = "*.tf",
		command = "setfiletype terraform",
	})

	-- Per-filetype tab / width (legacy config.vim)
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "ruby",
		callback = function()
			vim.opt_local.tabstop = 2
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "eruby",
		callback = function()
			vim.opt_local.tabstop = 3
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "html",
		callback = function()
			vim.opt_local.tabstop = 2
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "javascript",
		callback = function()
			vim.opt_local.tabstop = 2
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "astro",
		callback = function()
			vim.opt_local.tabstop = 2
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "vue",
		callback = function()
			vim.opt_local.tabstop = 4
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 4
			vim.opt_local.expandtab = false
		end,
	})
	for _, ft in ipairs({ "css", "sass" }) do
		vim.api.nvim_create_autocmd("FileType", {
			group = aug,
			pattern = ft,
			callback = function()
				vim.opt_local.tabstop = 2
				vim.opt_local.softtabstop = 0
				vim.opt_local.shiftwidth = 2
				vim.opt_local.expandtab = true
			end,
		})
	end
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "scss",
		callback = function()
			vim.opt_local.tabstop = 2
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
			vim.cmd("setlocal iskeyword+=-")
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "conf",
		callback = function()
			vim.opt_local.tabstop = 4
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 4
			vim.opt_local.expandtab = false
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "asterisk",
		callback = function()
			vim.opt_local.tabstop = 4
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 4
			vim.opt_local.expandtab = true
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "php",
		callback = function()
			vim.opt_local.tabstop = 4
			vim.opt_local.softtabstop = 0
			vim.opt_local.shiftwidth = 4
			vim.opt_local.expandtab = true
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "gitcommit",
		callback = function()
			vim.opt_local.spell = true
			vim.opt_local.textwidth = 72
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "yaml",
		callback = function()
			vim.opt_local.textwidth = 120
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = aug,
		pattern = "lua",
		callback = function()
			vim.opt_local.expandtab = false
		end,
	})

	-- Trim trailing whitespace on save (selected filetypes)
	local trim_tail_fts = {
		javascript = true,
		astro = true,
		css = true,
		scss = true,
		sass = true,
		haskell = true,
		html = true,
	}
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = aug,
		callback = function()
			local ft = vim.bo.filetype
			if trim_tail_fts[ft] then
				local view = vim.fn.winsaveview()
				vim.cmd("keeppatterns silent! %s/\\s\\+$//e")
				vim.fn.winrestview(view)
			end
		end,
	})

	-- Terminal streaming (cursor-agent, :terminal, etc.) can leave stale pixels in splits.
	-- Throttle redraw instead of global lazyredraw (which needs resize/C-L to recover).
	local term_redraw_timer = vim.loop.new_timer()
	local term_redraw_pending = false
	vim.api.nvim_create_autocmd("TermOpen", {
		group = aug,
		callback = function(args)
			local win = vim.api.nvim_get_current_win()
			vim.wo[win].number = false
			vim.wo[win].relativenumber = false
			vim.wo[win].signcolumn = "no"

			local buf = args.buf
			vim.api.nvim_buf_attach(buf, false, {
				on_lines = function()
					if term_redraw_pending then
						return false
					end
					term_redraw_pending = true
					term_redraw_timer:start(80, 0, function()
						term_redraw_pending = false
						vim.schedule(function()
							if vim.api.nvim_buf_is_valid(buf) then
								vim.cmd("redraw")
							end
						end)
					end)
					return false
				end,
			})
			vim.cmd("redraw")
		end,
	})
end

return M
