-- Cursor Agent via ACP (official recipe): https://cursor.com/docs/cli/acp#neovim-avantenvim
-- Prereq: `agent login` in terminal; binary often at ~/.local/bin/agent (adjust command if needed).

local agent_cmd = vim.fn.expand("~/.local/bin/agent")
if vim.fn.executable(agent_cmd) == 0 then
	agent_cmd = vim.fn.exepath("agent")
	if agent_cmd == "" then
		agent_cmd = "agent"
	end
end

-- No upstream opts for hint text/position; keep in sync with avante `show_input_hint`.
local INPUT_HINT_USER_NS = vim.api.nvim_create_namespace("avante_input_hint_user")
local INPUT_HINT_GAP_ROWS = 2

local function avante_patch_input_hint_once()
	local Sidebar = require("avante.sidebar")
	if Sidebar.__patched_input_hint then
		return
	end
	Sidebar.__patched_input_hint = true

	local api = vim.api
	local Config = require("avante.config")
	local Utils = require("avante.utils")

	local function acp_model_bits(sidebar)
		if not Config.acp_providers[Config.provider] then
			return nil
		end
		if not sidebar.acp_client or not sidebar.acp_client.config_options then
			return nil
		end
		local bits = {}
		for _, opt in ipairs(sidebar.acp_client.config_options) do
			if opt.category == "model" and opt.currentValue and opt.currentValue ~= "" then
				table.insert(bits, opt.currentValue)
			end
			if opt.category == "mode" and opt.currentValue and opt.currentValue ~= "" then
				table.insert(bits, opt.currentValue)
			end
		end
		if #bits == 0 then
			return nil
		end
		return bits
	end

	function Sidebar:show_input_hint()
		self:close_input_hint()
		local hint_text = (vim.fn.mode() ~= "i" and Config.mappings.submit.normal or Config.mappings.submit.insert)
			.. ": submit"
		if Config.behaviour.enable_token_counting then
			local input_value = table.concat(api.nvim_buf_get_lines(self.containers.input.bufnr, 0, -1, false), "\n")
			if self.token_count == nil then
				self:initialize_token_count()
			end
			local tokens = self.token_count + Utils.tokens.calculate_tokens(input_value)
			hint_text = "Tokens: " .. tostring(tokens) .. "; " .. hint_text
		end
		local bits = acp_model_bits(self)
		if bits then
			hint_text = hint_text .. " · " .. table.concat(bits, " · ")
		end

		local buf = api.nvim_create_buf(false, true)
		api.nvim_buf_set_lines(buf, 0, -1, false, { hint_text })
		api.nvim_buf_set_extmark(buf, INPUT_HINT_USER_NS, 0, 0, { line_hl_group = "AvantePopupHint" })

		local width = math.max(1, vim.fn.strdisplaywidth(hint_text))
		local win_h = api.nvim_win_get_height(self.containers.input.winid)
		local base_row = self:get_input_float_window_row()
		local row = math.min(win_h - 1, base_row + INPUT_HINT_GAP_ROWS)

		self.input_hint_window = api.nvim_open_win(buf, false, {
			relative = "win",
			win = self.containers.input.winid,
			width = width,
			height = 1,
			row = row,
			col = 0,
			style = "minimal",
			border = "none",
			focusable = false,
			zindex = 100,
		})
	end
end

-- Avante's vim.paste passes only lines[1] to img-clip; bracketed/binary paste often sends PNG as many
-- lines → paste_image fails → Neovim inserts IHDR/IDAT garbage. Intercept: sniff raw image bytes, then
-- paste from clipboard via Clipboard.paste_image(nil). Bracketed phases 1–3: defer paste while accumulating
-- if the stream looks like binary image.
local function avante_wrap_raw_image_paste_once()
	if vim.g.avante_raw_image_paste_guard then
		return
	end
	vim.g.avante_raw_image_paste_guard = 1

	local api = vim.api
	local Config = require("avante.config")
	local Clipboard = require("avante.clipboard")

	local function sniff_raw_image(blob)
		if type(blob) ~= "string" or #blob < 4 then
			return false
		end
		local i = 1
		if blob:byte(1) == 0xEF and blob:byte(2) == 0xBB and blob:byte(3) == 0xBF then
			i = 4
		end
		if #blob < i + 3 then
			return false
		end
		local b1, b2, b3, b4 = blob:byte(i, i + 3)
		if b1 == 137 and b2 == 78 and b3 == 71 and b4 == 71 then
			return true
		end
		if b1 == 0xFF and b2 == 0xD8 and b3 == 0xFF then
			return true
		end
		if #blob >= i + 5 and (blob:sub(i, i + 5) == "GIF87a" or blob:sub(i, i + 5) == "GIF89a") then
			return true
		end
		if #blob >= i + 11 and blob:sub(i, i + 3) == "RIFF" and blob:sub(i + 8, i + 11) == "WEBP" then
			return true
		end
		return false
	end

	local function after_clipboard_image_paste()
		local bufnr = api.nvim_get_current_buf()
		api.nvim_buf_set_lines(bufnr, -1, -1, false, { "" })
		api.nvim_win_set_cursor(0, { api.nvim_buf_line_count(bufnr), 0 })
	end

	local bracket = {}

	local inner = vim.paste
	vim.paste = function(lines, phase)
		local bufnr = api.nvim_get_current_buf()
		local ft = api.nvim_get_option_value("filetype", { buf = bufnr })
		if ft ~= "AvanteInput" or not Config.support_paste_image() then
			return inner(lines, phase)
		end

		local chunk = table.concat(lines, "\n")

		if phase == -1 then
			if sniff_raw_image(chunk) and Clipboard.paste_image(nil) then
				after_clipboard_image_paste()
				return
			end
			return inner(lines, phase)
		end

		if phase == 1 then
			local defer = sniff_raw_image(chunk)
				or (#chunk >= 1 and (chunk:byte(1) == 137 or chunk:byte(1) == 0xFF))
			bracket[bufnr] = { acc = chunk, defer = defer }
			if defer then
				return
			end
			bracket[bufnr] = nil
			return inner(lines, phase)
		end

		local st = bracket[bufnr]
		if st and st.defer then
			if phase == 2 or phase == 3 then
				st.acc = (st.acc or "") .. chunk
			end
			if phase == 3 then
				local acc = st.acc or ""
				bracket[bufnr] = nil
				if sniff_raw_image(acc) then
					if Clipboard.paste_image(nil) then
						after_clipboard_image_paste()
					else
						vim.notify(
							"avante/img-clip: image bytes in paste but clipboard capture failed (Wayland: wl-clipboard; :checkhealth img-clip)",
							vim.log.levels.WARN
						)
					end
					return
				end
				return inner(vim.split(acc, "\n", { plain = true }), -1)
			end
			return
		end

		return inner(lines, phase)
	end
end

return {
	{
		"yetone/avante.nvim",
		enabled = false,
		event = "VeryLazy",
		version = false,
		build = vim.fn.has("win32") == 1
				and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
		opts = {
			behaviour = {
				-- Paste screenshot into Avante input (needs img-clip + wl-clipboard/xclip on Linux).
				support_paste_from_clipboard = true,
				-- When ACP agent edits files, jump to first location (built-in).
				acp_follow_agent_locations = true,
			},
			provider = "cursor",
			mode = "agentic",
			acp_providers = {
				cursor = {
					command = agent_cmd,
					args = { "acp" },
					auth_method = "cursor_login",
					env = {
						HOME = vim.env.HOME,
						PATH = vim.env.PATH,
					},
				},
			},
			mappings = {
				files = {
					add_current = " aI",
				},
			},
			windows = {
				width = 45,
				sidebar_header = {
					enabled = false,
				},
			},
		},
		config = function(_, opts)
			require("avante").setup(opts)
			avante_patch_input_hint_once()
			avante_wrap_raw_image_paste_once()

			-- gf on "Filepath: …" line or just below → open file (split). ]] / [[ jump code blocks, a = apply hunk.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("avante_gf_filepath", { clear = true }),
				pattern = "Avante",
				callback = function(args)
					local buf = args.buf
					vim.keymap.set("n", "gf", function()
						local lnum = vim.fn.line(".")
						local lines = vim.api.nvim_buf_get_lines(buf, 0, lnum, false)
						local path
						for i = #lines, 1, -1 do
							local p = lines[i]:match("^%s*[Ff]ilepath:%s+(.+)%s*$")
							if p then
								path = vim.trim(p)
								break
							end
						end
						if not path or path == "" then
							vim.notify("avante: no Filepath: above this line", vim.log.levels.INFO)
							return
						end
						local root_ok, U = pcall(require, "avante.utils")
						local root = (root_ok and U.root and U.root.get) and U.root.get() or vim.fn.getcwd()
						local abs = path:match("^/") and path or (root .. "/" .. path):gsub("//+", "/")
						if vim.fn.filereadable(abs) == 1 or vim.fn.isdirectory(abs) == 1 then
							vim.cmd("split " .. vim.fn.fnameescape(abs))
						else
							vim.notify("avante: not found: " .. abs, vim.log.levels.WARN)
						end
					end, { buffer = buf, desc = "Avante: open Filepath above cursor" })
				end,
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"hakonharnes/img-clip.nvim",
				opts = {
					default = { insert_mode_after_paste = true },
					filetypes = {
						AvanteInput = {
							url_encode_path = true,
							template = "\nimage: $FILE_PATH\n",
						},
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = { file_types = { "markdown", "Avante" } },
				ft = { "markdown", "Avante" },
			},
		},
	},
}
