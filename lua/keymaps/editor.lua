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

	vim.keymap.set("n", "<F5>", "<Cmd>source $HOME/.config/nvim/init.vim<CR>")
	vim.keymap.set("n", "<F9>", "gg=G")

	vim.keymap.set("n", "<F2>", "<Cmd>set invpaste paste?<CR>")
	vim.o.showmode = true

	vim.keymap.set("n", "<Leader>q", "q")
	vim.keymap.set("n", "q", "<Nop>")
end

return M
