autocmd BufNewFile,BufRead *.j2 execute "doautocmd BufRead " . expand("<afile>:r") | set filetype+=.jinja
