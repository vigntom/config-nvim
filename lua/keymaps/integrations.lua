--- Plugin and tool integrations (FZF, Tagbar, etc.) — not pure :h map-default.

local M = {}

function M.setup()
	vim.keymap.set("n", "<Leader>tt", "<Cmd>TagbarToggle<CR>")

	vim.keymap.set("n", "<Leader>zf", "<Cmd>Files<CR>")
	vim.keymap.set("n", "<Leader>zb", "<Cmd>Buffers<CR>")
	vim.keymap.set("n", "<Leader>zl", "<Cmd>FZFMru<CR>")

	vim.keymap.set("n", "<F6>", "<Cmd>NERDTreeToggle<CR>")
	vim.keymap.set("n", "<F7>", "<Cmd>UndotreeToggle<CR>")
	vim.keymap.set("n", "<F8>", "<Cmd>TagbarToggle<CR>")

	vim.keymap.set("n", "<Leader>tc", "<Cmd>ColorToggle<CR>")

	vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { remap = true })
	vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { remap = true })

	vim.keymap.set("c", "w!!", "%!sudo tee > /dev/null %", { silent = true })

	vim.keymap.set({ "n", "x", "s", "o" }, "<Leader>j", "<Plug>(easymotion-j)", { remap = true })
	vim.keymap.set({ "n", "x", "s", "o" }, "<Leader>k", "<Plug>(easymotion-k)", { remap = true })

	vim.keymap.set("n", "<Leader>ht", "<Cmd>GhcModType<CR>")
	vim.keymap.set("n", "<Leader>htc", "<Cmd>GhcModTypeClear<CR>")

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
