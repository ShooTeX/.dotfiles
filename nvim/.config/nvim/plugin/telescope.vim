nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>:lua require'telescope'.extensions.project.project{}<cr>
nnoremap <leader>fs <cmd>:lua require'telescope.builtin'.symbols{ sources = {'emoji'} }<cr>
nnoremap <leader>fn <cmd>:lua require'telescope'.load_extension('gkeep').gkeep{}<cr>
