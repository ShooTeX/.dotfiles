require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { "|", "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		globalstatus = true,
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		lualine_b = { "branch" },
		lualine_c = { "" },
		lualine_x = { "fileformat" },
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
		lualine_a = {
			{ "filetype", separator = { left = "" }, icon_only = true },
			"filename",
		},
		lualine_b = { { "diagnostics", always_visible = true } },
		lualine_c = { "diff" },
		lualine_x = {
			{
				"lsp_progress",
				separators = {
					component = " ",
					progress = " | ",
					percentage = { pre = "", post = "%% " },
					title = { pre = "", post = ": " },
					lsp_client_name = { pre = "[", post = "]" },
					spinner = { pre = "", post = "" },
					message = { pre = "(", post = ")", commenced = "In Progress", completed = "Completed" },
				},
				display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
				timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
				spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
})

if _G.Tabline_timer == nil then
	_G.Tabline_timer = vim.loop.new_timer()
else
	_G.Tabline_timer:stop()
end

_G.Tabline_timer:start(
	0, -- never timeout
	1000, -- repeat every X ms
	vim.schedule_wrap(function() -- updater function
		vim.api.nvim_command("redrawtabline")
	end)
)
