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
	},
}

M.dap = {
	n = {
		["<leader>dE"] = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
		["<leader>dC"] = {
			"<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
			"Conditional Breakpoint",
		},
		["<leader>dU"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
		["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		["<leader>de"] = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
		["<leader>dg"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		["<leader>dh"] = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
		["<leader>dS"] = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
		["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		["<leader>dp"] = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
		["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
		["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		["<leader>ds"] = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
		["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		["<leader>dx"] = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	},
}

M.zenmode = {
	n = {
		["<C-w>m"] = { "<cmd>ZenMode<cr>", "Zen mode" },
	},
}

return M
