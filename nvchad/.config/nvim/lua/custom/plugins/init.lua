local overrides = require("custom.plugins.overrides")

return {

	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},

	["hrsh7th/nvim-cmp"] = {
		override_options = {
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "luasnip" },
			},
		},
	},

	["nvim-treesitter/nvim-treesitter"] = {
		override_options = overrides.treesitter,
	},

	["williamboman/mason.nvim"] = {
		override_options = overrides.mason,
	},

	["kyazdani42/nvim-tree.lua"] = {
		override_options = overrides.nvimtree,
	},

	["mizlan/iswap.nvim"] = {},

	["folke/zen-mode.nvim"] = {},

	["max397574/better-escape.nvim"] = {
		event = "InsertEnter",
		config = function()
			require("better_escape").setup({
				mapping = { ";a" },
				timeout = vim.o.timeoutlen,
				clear_empty_lines = false,
				keys = "<Esc>",
			})
		end,
	},

	["folke/trouble.nvim"] = {
		requires = "kyazdani42/nvim-web-devicons",
	},

	["kylechui/nvim-surround"] = {
		tag = "*",
	},

	["windwp/nvim-ts-autotag"] = {},

	["b0o/SchemaStore.nvim"] = {},

	["will133/vim-dirdiff"] = {},

	["kdheepak/lazygit.nvim"] = {},

	["sindrets/diffview.nvim"] = {
		requires = { "nvim-lua/plenary.nvim" },
	},

	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
	},

	["NvChad/ui"] = {
		override_options = {
			tabufline = {
				enabled = false,
			},
		},
	},

	["nvim-neotest/neotest"] = {
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npx jest --",
						jestConfigFile = "custom.jest.config.ts",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
				},
			})
		end,
	},
}
