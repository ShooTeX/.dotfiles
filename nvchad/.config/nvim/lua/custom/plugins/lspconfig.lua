local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = { "html", "cssls", "tsserver", "angularls", "graphql", "sumneko_lua", "rnix", "jsonls", "tailwindcss", "prismals" }

for _, lsp in ipairs(servers) do
	local setup = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if lsp == "jsonls" then
		setup["settings"] = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		}
	end

	lspconfig[lsp].setup(setup)
end
