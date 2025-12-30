autocmd BufEnter *.typ silent! let b:watchfile = expand('%:r') . '.watch.' . expand('%:e')
autocmd TextChanged,TextChangedI *.typ silent! execute 'write! ' . b:watchfile
autocmd BufUnload *.typ silent! execute '!rm ' . b:watchfile
