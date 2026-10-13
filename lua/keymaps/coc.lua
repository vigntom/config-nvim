--- coc.nvim-related mappings.

local M = {}

local function check_backspace()
	local col = vim.fn.col(".") - 1
	if col <= 0 then
		return true
	end
	local line = vim.fn.getline(".")
	local ch = vim.fn.strpart(line, col - 1, 1)
	return ch:match("%s") ~= nil
end

local function show_documentation()
	local ft = vim.bo.filetype
	if ft == "vim" or ft == "help" then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.fn["coc#rpc#ready"]() ~= 0 then
		vim.cmd("call CocActionAsync('doHover')")
	else
		vim.cmd("!" .. vim.o.keywordprg .. " " .. vim.fn.expand("<cword>"))
	end
end

function M.setup()
	-- 1. ИДЕАЛЬНЫЙ TAB: Если меню открыто, строго и четко выбирает СЛЕДУЮЩИЙ (первый) элемент без проскоков
	vim.keymap.set("i", "<Tab>", function()
		if vim.fn["coc#pum#visible"]() ~= 0 then
			-- Используем нативный встроенный селектор coc, который сразу берет фокус
			return vim.fn["coc#pum#next"](1)
		elseif check_backspace() then
			return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
		else
			return vim.fn["coc#refresh"]()
		end
	end, { expr = true, silent = true })

	-- 2. SHIFT+TAB: Строго листает меню подсказок ВВЕРХ
	vim.keymap.set("i", "<S-Tab>", function()
		if vim.fn["coc#pum#visible"]() ~= 0 then
			return vim.fn["coc#pum#prev"](1)
		else
			return vim.api.nvim_replace_termcodes("<C-h>", true, true, true)
		end
	end, { expr = true, silent = true })

	-- 3. ENTER: Всегда только переносит строку (как мы уже настроили)
	vim.keymap.set("i", "<CR>", function()
		if vim.fn["coc#pum#visible"]() ~= 0 then
			return vim.api.nvim_replace_termcodes("<C-g>u<CR>", true, true, true)
		else
			return vim.api.nvim_replace_termcodes("<CR>", true, true, true)
		end
	end, { expr = true, silent = true })

	if vim.fn.has("nvim") == 1 then
		vim.keymap.set("i", "<C-Space>", function()
			return vim.fn["coc#refresh"]()
		end, { expr = true, silent = true })
	else
		vim.keymap.set("i", "<C-@>", function()
			return vim.fn["coc#refresh"]()
		end, { expr = true, silent = true })
	end

	vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { remap = true, silent = true })
	vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { remap = true, silent = true })

	vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { remap = true, silent = true })
	vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { remap = true, silent = true })
	vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { remap = true, silent = true })
	vim.keymap.set("n", "gr", "<Plug>(coc-references)", { remap = true, silent = true })

	vim.keymap.set("n", "K", show_documentation, { silent = true })

	local coc_au = vim.api.nvim_create_augroup("KeymapsCocHighlight", { clear = true })
	vim.api.nvim_create_autocmd("CursorHold", {
		group = coc_au,
		pattern = "*",
		callback = function()
			vim.cmd("silent call CocActionAsync('highlight')")
		end,
	})

	vim.keymap.set("x", "<leader>f", "<Plug>(coc-format-selected)", { remap = true })
	vim.keymap.set("n", "<leader>f", "<Plug>(coc-format-selected)", { remap = true })

	vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction)", { remap = true })
	vim.keymap.set("n", "<leader>qf", "<Plug>(coc-fix-current)", { remap = true })

	vim.cmd([[
command! -nargs=0 Format call CocAction('format')
command! -nargs=? Fold call CocAction('fold', <f-args>)
command! -nargs=0 OR call CocAction('runCommand', 'editor.action.organizeImport')
]])
end

return M
