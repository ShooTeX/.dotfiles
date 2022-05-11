vim.g.nvim_tree_icons = {
	folder = {
		empty = "",
		empty_open = "",
		default = "",
		open = "",
	},
}

require("nvim-tree").setup({
	diagnostics = {
		enable = true,
	},
	view = {
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
