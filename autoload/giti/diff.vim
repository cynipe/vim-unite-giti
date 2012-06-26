" File:    diff.vim
" Author:  kmnk <kmnknmk+vim@gmail.com>
" Version: 0.1.0
" License: MIT Licence

let s:save_cpo = &cpo
set cpo&vim

" variables {{{
" }}}

function! giti#diff#run(param)"{{{
  let files = exists('a:param.files') ? a:param.files : []
  return s:run({'command' : 'diff', 'files' : files})
endfunction"}}}

function! giti#diff#cached(param)"{{{
  let files = exists('a:param.files') ? a:param.files : []
  return s:run({'command' : 'diff --cached', 'files' : files})
endfunction"}}}

function! giti#diff#head(param)"{{{
  let files = exists('a:param.files') ? a:param.files : []
  return s:run({'command' : 'diff HEAD', 'files' : files})
endfunction"}}}

function! giti#diff#specify(param)"{{{
  let files = exists('a:param.files') ? a:param.files : []
  let command
\   = !exists('a:param.to') ? printf('diff %s', a:param.from)
\   : a:param.to == ''      ? printf('diff %s', a:param.from)
\   :                         printf('diff %s..%s', a:param.from, a:param.to)
  return s:run({'command' : command, 'files' : files})
endfunction"}}}

" local functions {{{
function! s:run(param)"{{{
  let files = exists('a:param.files') ? a:param.files : []
  let diff = giti#system(a:param.command . ' -- ' . join(files))

  if !strlen(diff)
    echo 'no difference'
    return
  endif

  call giti#new_buffer({
\   'method' : giti#edit_command(),
\   'string' : diff,
\   'filetype' : 'diff',
\   'buftype'  : 'nofile',
\ })
  return 1
endfunction"}}}
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
