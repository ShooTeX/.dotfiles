require("stx.lualine")
require("stx.treesitter")
require("stx.gitsigns")
require("stx.trouble")
require("stx.lsp")
require("stx.cmp-init")
require("stx.telescope")
require("stx.update")
require("stx.nvim-tree")
require("stx.other")
require("stx.theme").init()

require("todo-comments").setup({})

require("nvim-autopairs").setup({
	fast_wrap = {},
})

require("cmp_tabnine.config"):setup({
	max_lines = 1000,
	max_num_results = 10,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	},
})
