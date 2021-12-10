require("stx.lualine")
require("stx.treesitter")
require("stx.gitsigns")
require("stx.trouble")

require'todo-comments'.setup {}

require'nvim-comment-frame'.setup {}

require'telescope'.setup{
  pickers = {
    find_files = {
      theme = "dropdown",
      path_display = {"truncate"}
    }
  }
}
