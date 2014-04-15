vim-ruby-fmt
============

Using the wonderful [Rubocop](https://github.com/bbatsov/rubocop) gem, this adds [gofmt](http://golang.org/cmd/gofmt)-like stylewise autocorrections on save to Vim.


## Why?

If your team has adopted a [style guide](https://github.com/bbatsov/ruby-style-guide) and/or started using something like [HoundCI](http://houndci.com), you are probably used to having your pull requests annotated with style violations.

If you have used GoFmt, then you know how liberating it is to not have to worry about these things as your editor of choice automatically fixes all those things for you.

That's what this does for Vim and Ruby.

## Installation

I use [Vundle](https://github.com/gmarik/Vundle.vim) so it is as easy as adding to my vundles.vim:

    Bundle 'zhubert/vim-ruby-fmt'

and running ```:BundleInstall``` from within Vim.

Finally, within your ```.vimrc``` add the following for autocorrect on save (experimental, double check things!):

    " should already have the first line, adding the second
    filetype plugin indent on
    autocmd FileType ruby autocmd BufWritePost <buffer> Fmt
    
If you want to be safer, I'd recommend binding the ```Fmt``` call to a map, like so:

    nmap ff :Fmt<CR>

## Experimental

This can mess up your code!

There is also an annoying flicker from the redraw, which when I have more time I can figure out.
