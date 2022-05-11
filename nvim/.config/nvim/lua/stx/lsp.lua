local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Mappings.
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		if
			vim.fn.filereadable(require("lspconfig").util.find_git_ancestor(client.config.root_dir) .. "/angular.json")
			== 1
		then
			client.resolved_capabilities.rename = false
		end
	end

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		"n",
		"<leader>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	vim.api.nvim_buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
end

-- lua
require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		cmd = { "lua-language-server" },
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- vscode html/css/json/eslint
require("lspconfig").cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
})

require("lspconfig").eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"graphql",
		"json",
	},
})

-- typescript
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	commands = {
		OR = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

-- angular
-- /home/stx/.nvm/versions/node/v17.2.0/lib/@angular/language-server
local languageServerPath = vim.fn.stdpath("config") .. "/language-servers/node_modules"
local cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	languageServerPath,
	"--ngProbeLocations",
	languageServerPath,
}

require("lspconfig").angularls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = cmd,
	on_new_config = function(new_config)
		new_config.cmd = cmd
	end,
})

require("lspconfig").rust_analyzer.setup({})

require("lspconfig").prismals.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		prisma = {
			prismaFmtBinPath = "",
		},
	},
})

require("lspconfig").graphql.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").dartls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
