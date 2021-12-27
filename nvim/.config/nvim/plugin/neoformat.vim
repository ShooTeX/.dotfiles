let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']
let g:neoformat_enabled_lua = ['stylua']

let g:neoformat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_toml = ['taplo']

let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_json = ['prettier']
let g:neoformat_enabled_jsonc = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
