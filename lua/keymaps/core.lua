--- Non–coc.nvim mappings (from settings/mappings.vim).

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
	-- <C-Space> for omnifunc is superseded by coc#refresh() in keymaps/coc.lua (same key).

	vim.keymap.set("n", "<Leader>tt", "<Cmd>TagbarToggle<CR>")

	vim.keymap.set("n", "<Leader>rr", relative_number_toggle)
	vim.keymap.set("n", "<Leader>rn", number_toggle)

	vim.keymap.set("n", "<Leader>zf", "<Cmd>Files<CR>")
	vim.keymap.set("n", "<Leader>zb", "<Cmd>Buffers<CR>")
	vim.keymap.set("n", "<Leader>zl", "<Cmd>FZFMru<CR>")

	if vim.fn.maparg("<C-L>", "n") == "" then
		vim.keymap.set("n", "<C-L>", "<Cmd>nohlsearch<CR><C-L>", { silent = true })
	end

	vim.keymap.set("n", "<Leader>p", "pV`]=`]a<Esc>")

	vim.keymap.set("n", "<F5>", "<Cmd>source $HOME/.config/nvim/init.vim<CR>")
	vim.keymap.set("n", "<F6>", "<Cmd>NERDTreeToggle<CR>")
	vim.keymap.set("n", "<F7>", "<Cmd>UndotreeToggle<CR>")
	vim.keymap.set("n", "<F8>", "<Cmd>TagbarToggle<CR>")
	vim.keymap.set("n", "<F9>", "gg=G")

	vim.keymap.set("n", "<F2>", "<Cmd>set invpaste paste?<CR>")
	vim.o.showmode = true

	vim.keymap.set("n", "<Leader>tc", "<Cmd>ColorToggle<CR>")

	vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { remap = true })
	vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { remap = true })

	vim.keymap.set("c", "w!!", "%!sudo tee > /dev/null %", { silent = true })

	-- :map (Normal, Visual, Select, Operator-pending), same as original.
	vim.keymap.set({ "n", "x", "s", "o" }, "<Leader>j", "<Plug>(easymotion-j)", { remap = true })
	vim.keymap.set({ "n", "x", "s", "o" }, "<Leader>k", "<Plug>(easymotion-k)", { remap = true })

	vim.keymap.set("n", "<C-k>", "<Plug>(ale_previous_wrap)", { remap = true, silent = true })
	vim.keymap.set("n", "<C-j>", "<Plug>(ale_next_wrap)", { remap = true, silent = true })

	vim.keymap.set("n", "<Leader>q", "q")
	vim.keymap.set("n", "q", "<Nop>")

	vim.keymap.set("n", "<Leader>ht", "<Cmd>GhcModType<CR>")
	vim.keymap.set("n", "<Leader>htc", "<Cmd>GhcModTypeClear<CR>")

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "haskell",
		callback = function()
			vim.keymap.set("n", "<leader>?", function()
				vim.cmd("call ale#cursor#ShowCursorDetail()")
			end, { buffer = true })
		end,
	})

	-- Legacy helper (was unused by maps; kept for plugins / manual :call).
	vim.cmd([[
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
]])

	vim.keymap.set("n", "-", "<Plug>(choosewin)", { remap = true })
end

return M
