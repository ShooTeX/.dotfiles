vim.g.nvim_tree_icons = {
	default = "",
	git = {
		unstaged = "",
		staged = "",
		unmerged = "",
		renamed = "➜",
		untracked = "",
		deleted = "",
		ignored = "◌",
	},
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
    width = 50,
		indent_markers = {
			enable = true,
		},
	},
})
