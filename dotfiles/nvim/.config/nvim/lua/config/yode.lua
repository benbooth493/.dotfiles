local status_ok, yode = pcall(require, "yode-nvim")
if not status_ok then
	return
end

require("yode-nvim").setup({})
