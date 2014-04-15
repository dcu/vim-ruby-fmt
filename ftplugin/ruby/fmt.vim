if exists("b:did_ftplugin_ruby_fmt")
    finish
endif

if !exists("g:ruby_fmt_commands")
    let g:ruby_fmt_commands = 1
endif

if !exists("g:ruby_fmt_script_path")
    let g:ruby_fmt_script_path = expand('<sfile>:p:h') . '../../misc/autocorrect_formatter.rb'
endif

if !exists("g:rubyfmt_command")
    let g:rubyfmt_command = "rubocop --require " . g:ruby_fmt_script_path . " --format AutocorrectFormatter"
endif

if g:ruby_fmt_commands
    command! -buffer Fmt call s:RubyFormat()
endif

function! s:RubyFormat()
    let view = winsaveview()
    silent execute "%!" . g:rubyfmt_command . " %"
    write
    call winrestview(view)
endfunction

let b:did_ftplugin_ruby_fmt = 1
