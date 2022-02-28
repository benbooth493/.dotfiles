local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

catppuccin.setup({
	integrations = {
		feline = true,
		lsp_trouble = true,
		which_key = true,
		barbar = true,
	},
})
