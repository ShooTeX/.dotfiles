vim.api.nvim_add_user_command("Update", function()
	vim.api.nvim_command("!git -C ~/.dotfiles pull")
	vim.api.nvim_command("so ~/.config/nvim/init.vim")
end, {})
