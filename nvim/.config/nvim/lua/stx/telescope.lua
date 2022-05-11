local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
	defaults = {
		path_display = { "truncate" },
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
		prompt_prefix = "     ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "flex",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			vertical = {
				mirror = false,
			},
			width = 0.8,
			height = 0.8,
			preview_cutoff = 120,
		},
		winblend = 0,
		border = {},
		borderchars = { "" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" },
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
require("telescope").load_extension("fzf")
