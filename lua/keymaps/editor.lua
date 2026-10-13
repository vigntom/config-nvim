--- Editor-only mappings (no plugin commands / <Plug>).

local M = {}

local function relative_number_toggle()
	if vim.o.relativenumber then
		vim.o.relativenumber = false
	else
		vim.o.relativenumber = true
	end
end

local function number_toggle()
	if vim.o.number then
		vim.o.number = false
	else
		vim.o.number = true
	end
end

function M.setup()
	vim.keymap.set("i", "jk", "<Esc>")

	vim.keymap.set("n", "<Leader>rr", relative_number_toggle)
	vim.keymap.set("n", "<Leader>rn", number_toggle)

	if vim.fn.maparg("<C-L>", "n") == "" then
		vim.keymap.set("n", "<C-L>", "<Cmd>nohlsearch<CR><C-L>", { silent = true })
	end

	vim.keymap.set("n", "<Leader>p", "pV`]=`]a<Esc>")

	vim.keymap.set("n", "<F5>", "<Cmd>source $MYVIMRC<CR>")
	vim.keymap.set("n", "<F9>", "gg=G")

	vim.keymap.set("n", "<F2>", "<Cmd>set invpaste paste?<CR>")
	vim.o.showmode = true

	vim.keymap.set("n", "<Leader>q", "q")
	vim.keymap.set("n", "q", "<Nop>")
	vim.keymap.set(
		"n",
		"<Leader>x",
		"<Cmd>lua MiniBufremove.delete()<CR>",
		{ silent = true, desc = "Закрыть буфер" }
	)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "markdown", "text" },
		callback = function()
			vim.opt_local.textwidth = 80
			vim.opt_local.wrap = true -- Включает визуальный перенос, если строка все же длинная
		end,
	})

	local md_format_group = vim.api.nvim_create_augroup("MarkdownAutoFormat", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = md_format_group,
		pattern = "*.md",
		callback = function()
			-- Запоминаем текущую позицию курсора, чтобы он не прыгал
			local view = vim.fn.winsaveview()

			-- Устанавливаем жесткий лимит строки в 80 символов
			vim.opt_local.textwidth = 80

			-- Выполняем встроенное форматирование 'gq' для ВСЕГО файла
			vim.cmd([[silent! normal! gggqG]])

			-- Возвращаем курсор точно на то место, где он стоял
			vim.fn.winrestview(view)
		end,
	})
end

return M
