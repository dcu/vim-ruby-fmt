if exists("b:did_ftplugin_ruby_fmt")
    finish
endif

if !exists("g:ruby_fmt_commands")
    let g:ruby_fmt_commands = 1
endif

if !exists("g:rubyfmt_command")
    let g:rubyfmt_command = "rubocop --require ~/autocorrect_formatter.rb --format AutocorrectFormatter"
endif

if g:ruby_fmt_commands
    command! -buffer Fmt call s:RubyFormat()
endif

function! s:RubyFormat()
    let view = winsaveview()
    silent execute "!" . g:rubyfmt_command . " " . bufname("%")
    if v:shell_error
        let errors = []
        for line in getline(1, line('$'))
            let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
            if !empty(tokens)
                call add(errors, {"filename": @%,
                                 \"lnum":     tokens[2],
                                 \"col":      tokens[3],
                                 \"text":     tokens[4]})
            endif
        endfor
        if empty(errors)
            % | " Couldn't detect gofmt error format, output errors
        endif
        undo
        if !empty(errors)
            call setqflist(errors, 'r')
        endif
        echohl Error | echomsg "Rubyfmt returned error" | echohl None
    endif
    call winrestview(view)
endfunction

let b:did_ftplugin_ruby_fmt = 1
