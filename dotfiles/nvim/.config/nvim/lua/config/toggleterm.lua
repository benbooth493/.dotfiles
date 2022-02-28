local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end
