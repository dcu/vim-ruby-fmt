if exists("b:did_ftplugin_ruby_fmt")
    finish
endif

if !exists("g:ruby_fmt_commands")
    let g:ruby_fmt_commands = 1
endif

if !exists("g:rubyfmt_command")
    let g:rubyfmt_command = "rubocop -o /dev/null -a "
endif

if g:ruby_fmt_commands
    command! Fmt call s:RubyFormat()
endif

function! s:RubyFormat()
    let view = winsaveview()
    try | silent undojoin | catch | endtry
    let default_srr = &srr
    set srr=>%s

    silent execute "!" . "cp % /tmp/%:t.tmp"
    silent execute "%!" . g:rubyfmt_command . " /tmp/%:t.tmp; cat /tmp/%:t.tmp"

    silent execute "!rm /tmp/%:t.tmp"

    let &srr = default_srr

    call winrestview(view)
endfunction

nmap ff :Fmt<CR>
autocmd BufWritePre <buffer> Fmt

let b:did_ftplugin_ruby_fmt = 1
