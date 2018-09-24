# rmarkdown-goodies

Repo for the rmarkdown-goodies emacs package, intended to complement markdown-mode for R markdown.

Although `markdown-mode` is full-featured, it seems to lack a keystroke for inserting specifically an `R` code chunk; the latter is a quite specific need and therefore there wouldn't be any reason to blame such an amazing package for lacking the feature beside that an R coder would miss such functionality already availabe in RStudio. It is worthy to mention that the combination of both `markdown-mode`, `ESS`, and `polymode` make Emacs a perfect platform for writing Rmarkdown, markdown, and for interactive work.

This small need made a perfect opportunity to learn a bit more elisp for implementing a function that inserts an `R` code chunkn centering the cursor inbetween the backtick sets so that the user can start writing `R` code directly into the chunk (animation 'giffed' using [`peek`](https://github.com/phw/peek)):

![Trying r-code-chunk](anim_test.gif)

When I found a way to compile the buffer I decided to move the earlier r-code-chunk.el function to a package along with a compiler function.

# Installation

Justs clone this repo and modify your `.emacs` file (or its relevant replacement file):

```{lisp}
; load the r-code-chunk code
(load "path/to/this/repo/rmarkdown-goodies/rmarkdown-goodies.el")
```

# Notes

At present the function implements the keybinding with `global-set-key` on load when starting `Emacs`. This is a suboptimal implementation as it should be locally set when `markdown-mode` is loaded; however I have not found a fast way to do it (although I'm looking for a way). Consequently, it jsut works so far, so please be aware of any unexpected behavior. If you find this package interacting with other Emacs functions because of its keystrokes, you can modify it in the lines containing `(kbd ...)` at the end of the `rmarkdown-goodies.el` file.

# Usage

For inserting a code chunk press `C-c C-c C-c` (or its alternative if you modify the key combination as indicated above).
Compilation of the current buffer works with `C-c m d`
