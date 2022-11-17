local M = {}

M.general = {
	n = {
		[";"] = { ":", "command mode", opts = { nowait = true } },
	},
}

M.trouble = {
	n = {
		["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "open trouble" },
		["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "open trouble workspace" },
		["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "open trouble document" },
		["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "open trouble loclist" },
		["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "open trouble quickfix" },
		["gR"] = { "<cmd>TroubleToggle lsp_references<cr>", "open trouble lsp references" },
	},
}

M.iswap = {
  n = {
		["<leader>ss"] = { "<Plug>ISwapWith", "swap element" },
		["<leader>sn"] = { "<Plug>ISwapNodeWith", "swap node" },
  }
}

M.zenmode = {
  n = {
		["<C-w>m"] = { "<cmd>ZenMode<cr>", "Zen mode" },
  }
}

-- more keybinds!

return M
