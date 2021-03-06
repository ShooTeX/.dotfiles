let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']

let g:neoformat_enabled_lua = ['stylua']

let g:neoformat_enabled_rust = ['rustfmt']

let g:neoformat_enabled_toml = ['taplo']

let g:neoformat_enabled_csharp = ['clang-format']

let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_javascript = ['eslint_d', 'prettier']
let g:neoformat_enabled_typescript = ['eslint_d', 'prettier']
let g:neoformat_enabled_html = ['eslint_d', 'prettier']
let g:neoformat_enabled_json = ['eslint_d', 'prettier']
let g:neoformat_enabled_jsonc = ['eslint_d', 'prettier']
let g:neoformat_enabled_markdown = ['prettier']

let g:neoformat_enabled_go = ['gofumpt']

augroup fmt_dart
  autocmd!
  autocmd BufWritePre *.dart undojoin | Neoformat
augroup END

augroup fmt_js
  autocmd!
  autocmd BufWritePre *.ts,*.js,*.tsx,*.jsx undojoin | Neoformat
augroup END


augroup fmt_lua
  autocmd!
  autocmd BufWritePre *.lua undojoin | Neoformat
augroup END

augroup fmt_rust
  autocmd!
  autocmd BufWritePre *.rs undojoin | Neoformat
augroup END

augroup fmt_go
  autocmd!
  autocmd BufWritePre *.go undojoin | Neoformat
augroup END

augroup fmt_csharp
  autocmd!
  autocmd BufWritePre *.cs undojoin | Neoformat
augroup END
