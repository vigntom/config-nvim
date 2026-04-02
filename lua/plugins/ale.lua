-- ALE: lint/fix via CLI; TS/HTML/CSS LSP diagnostics come from coc (see g:coc_global_extensions).
-- Avoid duplicate tsserver/vls with coc-tsserver-dev + @yaegassy/coc-volar (diagnostic.displayByAle).
return {
	{
		"w0rp/ale",
		init = function()
			-- g:ale_disable_lsp / g:ale_completion_enabled: init.vim (before lazy)
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
			vim.g.ale_linters = {
				-- eslint only for JS/TS stack — tsserver from coc-tsserver-dev / Volar
				javascript = { "eslint" },
				javascriptreact = { "eslint" },
				typescript = { "eslint", "standard" },
				typescriptreact = { "eslint", "standard" },
				vue = { "eslint" },
				haskell = { "hlint", "hdevtools", "ghc_mod" },
				cpp = { "clang", "clang-check" },
				python = { "flake8" },
				-- no tsserver — coc-html / coc-htmlhint / coc-stylelint
				html = { "htmlhint", "stylelint" },
				css = { "stylelint" },
				scss = { "stylelint" },
			}
			vim.g.ale_fixers = {
				javascript = { "prettier", "eslint" },
				["javascript.jsx"] = { "prettier", "eslint" },
				javascriptreact = { "prettier", "eslint" },
				typescript = { "prettier", "eslint" },
				typescriptreact = { "prettier", "eslint" },
				vue = { "prettier", "eslint" },
				lua = { "stylua" },
				json = { "prettier" },
				yaml = { "prettier" },
				css = { "prettier", "stylelint" },
				scss = { "prettier", "stylelint" },
				sh = { "shfmt" },
			}
			vim.g.ale_fix_on_save = 1
			vim.g.ale_virtualtext_cursor = "disabled"
			vim.g.ale_use_neovim_diagnostics_api = 1
		end,
	},
}
