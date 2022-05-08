local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
	defaults = {
		path_display = { "truncate" },
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_cursor({}),
		},
		project = {
			base_dirs = {
				"~/.dotfiles/nvim/.config/nvim",
			},
			hidden_files = true,
		},
	},
})

require("telescope").load_extension("ui-select")
