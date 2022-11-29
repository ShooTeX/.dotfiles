local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local eslint_filetypes = { "graphql", "html" }

local sources = {

	b.formatting.prettierd.with({
		filetypes = { "json", "jsonc" },
	}),

	b.diagnostics.actionlint,

	b.formatting.stylelint,
	b.diagnostics.stylelint,

	b.formatting.eslint_d.with({
		extra_filetypes = eslint_filetypes,
	}),
	b.code_actions.eslint_d.with({
		extra_filetypes = eslint_filetypes,
	}),
	b.diagnostics.eslint_d.with({
		extra_filetypes = eslint_filetypes,
	}),

	b.formatting.stylua,

  b.formatting.nixfmt,

	b.formatting.codespell,
	b.diagnostics.codespell,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
