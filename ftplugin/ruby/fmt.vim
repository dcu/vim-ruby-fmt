if exists("b:did_ftplugin_ruby_fmt")
    finish
endif

if !exists("g:ruby_fmt_commands")
    let g:ruby_fmt_commands = 1
endif

if !exists("g:rubyfmt_command")
    let g:rubyfmt_command = "rubocop -a "
endif

if g:ruby_fmt_commands
    command! -buffer Fmt call s:RubyFormat()
endif

function! s:RubyFormat()
    let view = winsaveview()
    silent execute "!" . g:rubyfmt_command . " %"
    redraw!
    call winrestview(view)
endfunction

let b:did_ftplugin_ruby_fmt = 1
