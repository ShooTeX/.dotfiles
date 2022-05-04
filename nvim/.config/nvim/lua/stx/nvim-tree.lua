require("nvim-tree").setup({
	diagnostics = {
		enable = true,
	},
	view = {
		width = 50,
		relativenumber = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	renderer = {
		indent_markers = {
			enable = true,
		},
	},
})
