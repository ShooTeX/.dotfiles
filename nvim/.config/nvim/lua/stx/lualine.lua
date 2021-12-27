require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { "|", "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		lualine_b = { "branch" },
		lualine_c = { "" },
		lualine_x = { "require'lsp-status'.status()", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = { { "filename", separator = { left = "" }, right_padding = 2 } },
		lualine_b = { "filetype" },
		lualine_c = { "diagnostics", "diff" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
})
