-- lua/config/ai/init.lua
local M = {}

M.minuet = require("config.ai.minuet") -- бывший init.lua
M.autocomplete = require("config.ai.autocomplete")

function M.setup()
	require("minuet").setup(M.minuet.get_setup())
end

return M
