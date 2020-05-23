" Vim replace for missed gx functionality from netrw
" Maintainer:	Vik Voinikoff <policarpov2@gmail.com>
" Last Change:  2020-05-24 01:12:53 	

" just simple function 

function! Interceptor()

  let line0=getline (".")
  let line=matchstr (line0, "http[^]\"\) ]*")

  if line==""
      let line=matchstr (line0, "ftp[^\"\) ]*")
  endif

  if line==""
      let line=matchstr (line0, "file[^\"\) ]*")
  endif

  let line= escape (line, "#?&;|%")
  exec ':silent !firefox ' . line

endfunction

nnoremap gx :call Interceptor()<CR>
