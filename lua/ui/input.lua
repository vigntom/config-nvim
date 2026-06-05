local M = {}

local installed = false

function M.setup()
	if installed then
		return
	end
	installed = true

	local ok_input, Input = pcall(require, "nui.input")
	local ok_autocmd, autocmd = pcall(require, "nui.utils.autocmd")
	if not ok_input or not ok_autocmd then
		return
	end
	local event = autocmd.event

	local default_input = vim.ui.input

	vim.ui.input = function(opts, on_confirm)
		opts = opts or {}
		on_confirm = on_confirm or function() end

		local done = false
		local function finish(value)
			if done then
				return
			end
			done = true
			on_confirm(value)
		end

		local popup = Input({
			position = "50%",
			size = {
				width = math.max(40, math.floor(vim.o.columns * 0.5)),
			},
			border = {
				style = "rounded",
				text = {
					top = opts.prompt or "Input",
					top_align = "left",
				},
			},
			win_options = {
				winblend = 0,
			},
		}, {
			prompt = " ",
			default_value = opts.default or "",
			on_submit = function(value)
				finish(value)
			end,
		})

		popup:map("n", "<Esc>", function()
			popup:unmount()
			finish(nil)
		end, { noremap = true, nowait = true })

		popup:on(event.BufLeave, function()
			popup:unmount()
			finish(nil)
		end, { once = true })

		local ok = pcall(popup.mount, popup)
		if not ok then
			finish(nil)
			if default_input and default_input ~= vim.ui.input then
				default_input(opts, on_confirm)
			end
		end
	end
end

return M
