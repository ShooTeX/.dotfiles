require("stx.lualine")
require("stx.treesitter")
require("stx.gitsigns")
require("stx.trouble")
require("stx.lsp")
require("stx.cmp-init")
require("stx.telescope")
require("stx.update")

require("todo-comments").setup({})

require("stabilize").setup({})

require("zen-mode").setup({})

require("nvim-tree").setup({
	diagnostics = {
		enabled = true,
	},
	view = {
		width = 60,
		auto_resize = true,
		relativenumber = true,
	},
})

require("nvim-autopairs").setup({
	fast_wrap = {},
})

require("cmp_tabnine.config"):setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	},
})
