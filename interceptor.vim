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

nmap gx :call Interceptor()<CR>
nmap <F3> :call Interceptor()<CR>
