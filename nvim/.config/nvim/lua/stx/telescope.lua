local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
	defaults = {
    path_display={"smart"},
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
	extensions = {
		project = {
			base_dirs = {
				"~/.dotfiles/nvim/.config/nvim",
			},
			hidden_files = true,
		},
	},
})
