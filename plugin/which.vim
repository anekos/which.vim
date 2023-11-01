function! s:which(command_name) abort
  let l:path = systemlist(printf('which %s', shellescape(a:command_name)))
  if v:shell_error == 0
    execute 'edit' path[0]
  else
    echo printf('Ugh! Command not found: %s', a:command_name)
  endif
endfunction


function! s:executables(...)
  let l:files = []

  for l:file in globpath(substitute($PATH, ':', ',', 'g'), '*', v:false, v:true)
    if executable(l:file)
      call add(l:files, fnamemodify(l:file, ':t'))
    endif
  endfor

  call sort(l:files)
  call uniq(l:files)

  return l:files
endfunction


command! -nargs=* -complete=customlist,s:executables Which call s:which(<q-args>)
