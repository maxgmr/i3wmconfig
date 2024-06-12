local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	open_mapping = [[<c-\>]],
	direction = "horizontal",
	close_on_exit = true,
	shade_terminals = false,
	persist_mode = false,
})
