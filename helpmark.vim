let g:zmb = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9','0','`','~','!','@','#','$','%','^','&','*','(',')','-','_','=','+','[',']','{','}','\',';',':',',','<','.','>','/','?']

let g:vis = [[[]]]
let g:km = ""
let g:fd = {}

func Helplp()
    let X = line('.')
    let Y = col('.')
    let val = get(get(g:vis,X,[[]]),Y,[])
    if val == []
        return 
    endif
    let flag = 0
    let g:km = "This mark is "
    for ch in val
        if flag == 0
            let flag = 1
            let g:km = g:km . ch
        else
            let g:km = g:km . "," . ch
        endif
    endfor
    exec "echo g:km"
endfunc

func AddMark(c)
    exec "normal! m" . a:c . "<CR>"
    while get(g:vis,line('.'),[['default']]) == [['default']]
        call add(g:vis,[[]])
    endwhile
    while get(g:vis[line('.')],col('.'),['default']) == ['default']
        call add(g:vis[line('.')],[])
    endwhile
    call add(g:vis[line('.')][col('.')],a:c)
endfunc

autocmd CursorMoved * :call Helplp()

for ch in zmb
    exec "nmap m" . ch . " :call AddMark('" . ch . "')\<CR>"
endfor
