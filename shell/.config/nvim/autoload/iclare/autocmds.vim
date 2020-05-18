let g:IclareMkviewFiletypeBlacklist = ['diff', 'hgcommit', 'gitcommit']

" Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
function! iclare#autocmds#should_mkview() abort
  return
        \ &buftype ==# '' &&
        \ index(g:IclareMkviewFiletypeBlacklist, &filetype) == -1 &&
        \ !exists('$SUDO_USER') " Don't create root-owned files.
endfunction

function! iclare#autocmds#mkview() abort
  try
    if exists('*haslocaldir') && haslocaldir()
      " We never want to save an :lcd command, so hack around it...
      cd -
      mkview
      lcd -
    else
      mkview
    endif
  catch /\<E186\>/
    " No previous directory: probably a `git` operation.
  catch /\<E190\>/
    " Could be name or path length exceeding NAME_MAX or PATH_MAX.
  endtry
endfunction
