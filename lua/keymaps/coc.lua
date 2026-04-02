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
	vim.keymap.set("i", "<Tab>", function()
		if vim.fn["coc#pum#visible"]() ~= 0 then
			return vim.fn["coc#pum#next"](1)
		elseif check_backspace() then
			return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
		else
			return vim.fn["coc#refresh"]()
		end
	end, { expr = true, silent = true })

	vim.keymap.set("i", "<S-Tab>", function()
		if vim.fn["coc#pum#visible"]() ~= 0 then
			return vim.fn["coc#pum#prev"](1)
		else
			return vim.api.nvim_replace_termcodes("<C-h>", true, true, true)
		end
	end, { expr = true })

	-- Kept as Vimscript for correct coc#pum#confirm / coc#on_enter() sequencing.
	vim.cmd([[
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]])

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
