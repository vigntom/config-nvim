-- ALE: lint/fix via CLI; TS/HTML/CSS LSP diagnostics come from coc (see g:coc_global_extensions).
-- Avoid duplicate tsserver/vls with coc-tsserver-dev + @yaegassy/coc-volar (diagnostic.displayByAle).
return {
	{
		"w0rp/ale",
		init = function()
			-- g:ale_disable_lsp / g:ale_completion_enabled: init.lua (before lazy)
			-- legacy: g:ale_typescript_standard_executable = 'ts-standard' (uncomment if needed)
			vim.g.ale_lint_on_save = 1
			vim.g.ale_lint_on_text_changed = 1
			vim.g.ale_sign_column_always = 1
			vim.g.ale_sign_error = ">>"
			vim.g.ale_sign_warning = "--"
			vim.g.ale_linter_aliases = {
				jsx = { "css", "javascript" },
				vue = { "javascript", "vue" },
			}
			local composer_bin = vim.fn.expand("~/.config/composer/vendor/bin")
			if vim.fn.executable(composer_bin .. "/phpcs") == 1 then
				vim.g.ale_php_phpcs_executable = composer_bin .. "/phpcs"
				vim.g.ale_php_phpcbf_executable = composer_bin .. "/phpcbf"
				vim.g.ale_php_phpcs_standard = "PSR12"
				vim.g.ale_php_phpcbf_standard = "PSR12"
			end

			vim.g.ale_linters = {
				-- eslint only for JS/TS stack — tsserver from coc-tsserver-dev / Volar
				javascript = { "eslint" },
				javascriptreact = { "eslint" },
				typescript = { "eslint", "standard" },
				typescriptreact = { "eslint", "standard" },
				astro = { "eslint" },
				vue = { "eslint" },
				haskell = { "hlint", "hdevtools", "ghc_mod" },
				cpp = { "clang", "clang-check" },
				python = { "flake8" },
				php = { "phpcs" },
				-- HTML/CSS diagnostics: coc-html, coc-htmlhint, coc-stylelint (no ALE linters here)
				html = {},
				css = {},
				scss = {},
			}
			vim.g.ale_fixers = {
				javascript = { "prettier", "eslint" },
				["javascript.jsx"] = { "prettier", "eslint" },
				javascriptreact = { "prettier", "eslint" },
				typescript = { "prettier", "eslint" },
				typescriptreact = { "prettier", "eslint" },
				astro = { "prettier", "eslint" },
				vue = { "prettier", "eslint" },
				lua = { "stylua" },
				json = { "prettier" },
				yaml = { "prettier" },
				-- prettier only — stylelint fixes via coc-stylelint if needed
				css = { "prettier" },
				scss = { "prettier" },
				sh = { "shfmt" },
				php = { "phpcbf" },
			}
			vim.g.ale_fix_on_save = 1
			vim.g.ale_virtualtext_cursor = "disabled"
			vim.g.ale_use_neovim_diagnostics_api = 1
		end,
		config = function()
			vim.keymap.set("n", "<C-k>", "<Plug>(ale_previous_wrap)", { remap = true, silent = true })
			vim.keymap.set("n", "<C-j>", "<Plug>(ale_next_wrap)", { remap = true, silent = true })

			local aug = vim.api.nvim_create_augroup("nvim_user_ale_haskell_maps", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = aug,
				pattern = "haskell",
				callback = function()
					vim.keymap.set("n", "<leader>?", function()
						vim.cmd("call ale#cursor#ShowCursorDetail()")
					end, { buffer = true })
				end,
			})
		end,
	},
}
