local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	"eslint",
	"html",
	"cssls",
	"tsserver",
	"angularls",
	"graphql",
	"sumneko_lua",
	"rnix",
	"jsonls",
	"tailwindcss",
	"prismals",
	"rust_analyzer",
	"astro",
}

for _, lsp in ipairs(servers) do
	local setup = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	-- if lsp == "angularls" then
	-- 	local clients = vim.lsp.get_active_clients({
	-- 		name = "tsserver",
	-- 	})
	--
	-- 	if clients[0] then
	-- 		clients[0].server_capabilities.renameProvider = false
	-- 	end
	-- end

	if lsp == "rust_analyzer" then
		setup["on_attach"] = function(client, bufnr)
			on_attach(client, bufnr)

			client.server_capabilities.semanticTokensProvider = nil
		end

		setup["settings"] = {
			["rust-analyzer"] = {
				extraArgs = { "+nightly" },
				checkOnSave = {
					allFeatures = true,
					overrideCommand = {
						"cargo",
						"+nightly",
						"clippy",
						"--workspace",
						"--message-format=json",
						"--all-targets",
						"--all-features",
					},
				},
			},
		}
	end

	if lsp == "jsonls" then
		setup["settings"] = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		}
	end

	if lsp == "eslint" then
		setup["settings"] = {
			eslint = {
				codeActionOnSave = {
					enable = true,
					mode = "all",
				},
				packageManager = "pnpm",
			},
		}
	end

	if lsp == "tailwindcss" then
		setup = {
			filetypes = {
				"aspnetcorerazor",
				"astro",
				"astro-markdown",
				"blade",
				"django-html",
				"htmldjango",
				"edge",
				"eelixir",
				"elixir",
				"ejs",
				"erb",
				"eruby",
				"gohtml",
				"haml",
				"handlebars",
				"hbs",
				"html",
				"html-eex",
				"heex",
				"jade",
				"leaf",
				"liquid",
				"markdown",
				"mdx",
				"mustache",
				"njk",
				"nunjucks",
				"php",
				"razor",
				"slim",
				"twig",
				"css",
				"less",
				"postcss",
				"sass",
				"scss",
				"stylus",
				"sugarss",
				"javascript",
				"javascriptreact",
				"reason",
				"rescript",
				"rust",
				"typescript",
				"typescriptreact",
				"vue",
				"svelte",
			},
			init_options = {
				userLanguages = {
					rust = "html",
				},
			},
		}
	end

	lspconfig[lsp].setup(setup)
end
