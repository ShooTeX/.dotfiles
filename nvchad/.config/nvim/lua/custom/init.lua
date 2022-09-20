local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local command = vim.api.nvim_command

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

command "set relativenumber"
command "set wrap nowrap"

local yankGrp = augroup("YankHighlight", { clear = true })

autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})
