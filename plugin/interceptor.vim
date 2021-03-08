" Vim replace for missed gx functionality from netrw
" Maintainer:	Vik Voinikoff <policarpov2@gmail.com>
" Last Change: 2021-03-08 09:12:17  

" just simple function 

" global firefox setting
" let g:InterceptorGxBrowser="x-www-browser"
" in vimrc

function! Interceptor()

    if exists("g:InterceptorGxBrowser")
        let l:Brwsr = g:InterceptorGxBrowser
    else
        let l:Brwsr = "firefox"
        " or
        " let l:browser="x-www-browser"
    endif


    " get current line under cursor
    let line = getline (".")

    " get first test pattern (url http:// or https://)
    let l:www = matchstr(line, "http[^\"\)\} ]*")

    " if we found url: 
    if l:www != "" 
        let l:url = escape(www, "#?&;|%")

    elseif matchstr(line, "file[^\"\) ]*") != ""
        let l:f = matchstr(line, "file[^\"\) ]*")
        let l:url = escape(f, "#?&;|%")
        let l:Brwsr = "xdg-open"

    elseif    matchstr(line, "\/home\/[^\"\)\} ]*") != ""
        let l:f = matchstr(line, "\/home\/[^\"\\} ]*")
        let l:url = escape(f, "#?&;|%")
        let l:Brwsr = "xdg-open"


    elseif matchstr (line, "ftp[^\"\) ]*") != ""

        let l:ftp = matchstr(line, "ftp[^\"\) ]*")
        let l:url = escape(ftp, "#?&;|%")

    " for opening e-mail adresses (cgosorio proposal)
    elseif        matchstr(line, "mailto:[^\"\) ]*") != ""
        let l:m = matchstr(line, "mailto:[^\"\) ]*")
        let l:url = escape(l:m, "#?&;|%")

    "buggy and problem branch :(
    "elseif   matchstr(line,  "\~\/\S*") != ""
    "    let l:f = matchstr(line, "\~\/\S*")
    "    let l:url = escape(f, "#?&;|%")
    "    let l:Brwsr = "xdg-open"

    endif

    if url != ""
        exec ':silent !' . Brwsr . ' ' . url
    endif


endfunction

nnoremap <silent> gx :call Interceptor()<CR>
