local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"typescript",
		"c",
	},
}

M.mason = {
	ensure_installed = {
		"lua-language-server",
		"stylua",
		"angular-language-server",
		"graphql-language-service-cli",
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"eslint_d",
		"prettierd",
		"json-lsp",
		"tailwindcss-language-server",
		"rnix-lsp",
		"prisma-language-server",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

return M
