" Vim replace for missed gx functionality from netrw
" Maintainer:	Vik Voinikoff <policarpov2@gmail.com>
" Last Change:  2020-06-10 14:29:39  

" just simple function 

" global firefox setting
" let g:InterceptorGxBrowser="x-www-browser"
" in vimrc

function! Interceptor()

    if exists("g:InterceptorGxBrowser")
        let Brwsr=g:InterceptorGxBrowser
    else
        let Brwsr="firefox"
        " or
        " let l:browser="x-www-browser"
    endif


  let line0=getline (".")

  let line=matchstr(line0, "http[^\"\)\} ]*")

  if line==""
      let line=matchstr (line0, "ftp[^\"\) ]*")
  endif

  if line==""
      let line=matchstr (line0, "file[^\"\) ]*")
      let Brwsr="thunar"
  endif

  " for opening e-mail adresses (cgosorio proposal)
  if line==""
      let line=matchstr (line0, "mailto:[^\"\) ]*")
  endif

  let line=escape (line, "#?&;|%")
  exec ':silent !'.Brwsr.' '. line

endfunction

nnoremap <silent> gx :call Interceptor()<CR>
