" The version of this plugin is 1.1.
let g:zmb = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9','0','`','~','!','@','#','$','%','^','&','*','(',')','-','_','=','+','[',']','{','}','\',';',':',',','<','.','>','/','?']
let g:vis = [[[]]]
let g:km = ""
let g:fd = {}

func Helplp()
    let X = line('.')
    let Y = col('.')
    let val = get(get(g:vis,X,[[]]),Y,[])
    if val == []
        exec "echo "
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
    let g:fd[a:c] = [line('.'),col('.')]
    exec "normal! m" . a:c
    while get(g:vis,line('.'),[['default']]) == [['default']]
        call add(g:vis,[[]])
    endwhile
    while get(g:vis[line('.')],col('.'),['default']) == ['default']
        call add(g:vis[line('.')],[])
    endwhile
    call add(g:vis[line('.')][col('.')],a:c)
endfunc

func ToMark(c)
    if has_key(g:fd,a:c) == 0 || g:fd[a:c][0] == -1 
        exec "echo 'This mark non-existent'"
        return 
    endif
    exec g:fd[a:c][0]
    exec "normal " . g:fd[a:c][1] . "|"
endfunc

func DeleteMark(c)
    if has_key(g:fd,a:c) == 0 || g:fd[a:c][0] == -1 
        exec "echo 'This mark non-existent'"
        return 
    endif
    let tmpp = index(g:vis[g:fd[a:c][0]][g:fd[a:c][1]],a:c)
    let lt = []
    if tmpp-1 >= 0
        let lt = g:vis[g:fd[a:c][0]][g:fd[a:c][1]][:tmpp-1]
    endif
    let rt = []
    if tmpp+1 < len(g:vis[g:fd[a:c][0]][g:fd[a:c][1]])
        let rt = g:vis[g:fd[a:c][0]][g:fd[a:c][1]][tmpp+1:]
    endif
    let g:vis[g:fd[a:c][0]][g:fd[a:c][1]] = lt + rt
    let g:fd[a:c][0] = -1
endfunc

autocmd CursorMoved * :call Helplp()
for ch in g:zmb
    exec "nmap m" . ch . " :call AddMark('" . ch . "')\<CR>"
    exec "nmap `" . ch . " :call ToMark('" . ch . "')\<CR>"
    exec "nmap '" . ch . " :call ToMark('" . ch . "')\<CR>^"
    exec "nmap dm" . ch . " :call DeleteMark('" . ch . "')\<CR>"
endfor
