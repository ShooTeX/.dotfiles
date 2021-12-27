let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']

let g:neoformat_enabled_lua = ['stylua']

let g:neoformat_enabled_rust = ['rustfmt']

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
