local M = { enabled = false }

function M.enable()
	vim.cmd("Minuet virtualtext enable")
	vim.notify("Autocomplete: ON", vim.log.levels.INFO)
end

function M.disable()
	vim.cmd("Minuet virtualtext disable")
	vim.notify("Autocomplete: OFF", vim.log.levels.WARN)
end

function M.toggle()
	M.enabled = not M.enabled
	if M.enabled then
		M.enable()
	else
		M.disable()
	end
end

return M
