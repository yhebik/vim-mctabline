if expand('<sfile>:p')!=#expand('%:p') && exists('g:loaded_mctabline')| finish| endif| let g:loaded_mctabline = 1
set guioptions-=e
set showtabline=2
function! s:tabpage_label(n)
    let title = gettabvar(a:n, 'title')
    if title !=# ''
        return title
    endif
    let bufnrs = tabpagebuflist(a:n)
    let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    let no = a:n
    let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]
    let fname = pathshorten(bufname(curbufnr))
    let fname = substitute(fname, '.*\/', '', '')
    let label = '[' . no . ']'. fname
    return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction
function! MakeTabLine()
    let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
    let sep = '|'  " separator
    let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
    let hostname = system('hostname')
    let info = ' [' . hostname[:len(hostname)-2] . ':' . fnamemodify(getcwd(), ":~") . ']'
    return tabpages . '%=' . info
endfunction
set tabline=%!MakeTabLine()
