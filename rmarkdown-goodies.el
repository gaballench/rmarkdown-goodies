;;; rmarkdown-goodies.el ---  An extension for authoring R markdown -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Gustavo  A. Ballen

;; Author: Gustavo A. Ballen <gaballench@gmail.com>
;; Keywords: lisp, languages, wp, files
;; Created: 19 Sep 2018
;; Version: 0.0.1
;; Package-Requires: ((ess "0.1") (markdown-mode "0.1") (polymode "0.1"))
;; URL: https://github.com/gaballench/rmarkdown-goodies

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; rmarkdown-goodies is a small package for extending the scope of markdown-mode so  that it makes it easier to author R markdown documents.  Such extensions allow to insert R code chunks with several special-case arguments (mostly echo = FALSE and eval =  FALSE) and a function for compilation using the rmarkdown R package.  Please note that correct behavior is ensured if Emacs dependencies (ESS, markdown-mode, polymode) and system dependencies (R and its rmarkdown package) are installed.

;;; Code:

;insert an R code chunk without arguments
(defun rmarkdown-goodies-r-code-chunk ()
  "Insert an R code chunk without arguments.
For the different options available see https://yihui.name/knitr/options/.
`rmarkdown-goodies-r-text-only-chunk and `rmarkdown-r-silent-chunk are
special cases of this function.  See documentation for these functions for details."
  (interactive)
  (newline)
  (backward-char 1)
  (insert "```{r}")
  (newline 2)
  (insert-before-markers "```")
  (backward-char 4))

; insert an R code chunk that will not evaluate, i.e., text-only chunk, eval = FALSE
(defun rmarkdown-goodies-r-text-only-chunk ()
  "Insert an R code chunk without arguments.
For the different options available see https://yihui.name/knitr/options/.
It is a special case of `rmarkdown-goodies-r-code-chunk with the argument
eval = FALSE and hence the 'text-only', its code is not evaluated."
  (interactive)
  (newline)
  (backward-char 1)
  (insert "```{r eval = FALSE}")
  (newline 2)
  (insert-before-markers "```")
  (backward-char 4))

; insert an R code chunk that will not output the code, i.e., silently-evaluated chunk, echo = FALSE
(defun rmarkdown-goodies-r-silent-chunk ()
  "Insert an R code chunk without arguments.
For the different options available see https://yihui.name/knitr/options/.
It is a special case of `rmarkdown-goodies-r-code-chunk with the argument
echo = FALSE and hence the 'silent', its code is executed but the code itself
is not rendered."
  (interactive)
  (newline)
  (backward-char 1)
  (insert "```{r echo = FALSE}")
  (newline 2)
  (insert-before-markers "```")
  (backward-char 4))

;insert a bash code chunk without arguments
(defun rmarkdown-goodies-bash-code-chunk ()
  "Insert a bash code chunk without arguments.
Please note that this will be executed when compiled.
`rmarkdown-bash-text-only-chunk is a special case of 
this function. See documentation for these functions for details."
  (interactive)
  (newline)
  (backward-char 1)
  (insert "```{bash}")
  (newline 2)
  (insert-before-markers "```")
  (backward-char 4))

; insert an R code chunk that will not evaluate, i.e., text-only chunk, eval = FALSE
(defun rmarkdown-goodies-bash-text-only-chunk ()
  "Insert a bash code chunk with the argument `eval = FALSE'.
This code chunk will not be executed when compiled, 
so it is useful for documenting stuff that is not intended 
to be executed every time the file is compiled.
It is a special case of `rmarkdown-goodies-bash-code-chunk with the argument
eval = FALSE and hence the 'text-only', its code is not evaluated."
  (interactive)
  (newline)
  (backward-char 1)
  (insert "```{bash eval = FALSE}")
  (newline 2)
  (insert-before-markers "```")
  (backward-char 4))

;; rmarkdown-goodies-compile-rmd will compile the current buffer with Rscript and the render function of the rmarkdown package
(defun rmarkdown-goodies-compile-rmd ()
  "Compiles the Rmd file.
This function calls R, and loads the render() function of the rmarkdown package
in namespace notation (rmarkdown::render) executing it on the file that is
being edited.  This function seems to be slower than calling rmarkdown::render
from an interactive session, but in contrast it does not require to switch
between buffers.  It is generally  well-behaved for simple R code.
For complex/slow code it executes although it might be very slow."
  (interactive)
  (message (concat "Compiling " (file-name-nondirectory buffer-file-name) "..."))
  (call-process-shell-command
    (concat "Rscript -e 'rmarkdown::render("
            (concat "\"" buffer-file-name "\"")
                    ")'")
    nil "*Shell Command Output*" t)
  (message (concat "Compiling " (file-name-nondirectory buffer-file-name) "..." "done")))


;; Keybinding
(add-hook
 'markdown-mode-hook
 '(lambda ()
    (define-key markdown-mode-map (kbd "C-c M-c") 'rmarkdown-goodies-r-code-chunk)
    (define-key markdown-mode-map (kbd "C-c M-t") 'rmarkdown-goodies-r-text-only-chunk)
    (define-key markdown-mode-map (kbd "C-c M-s") 'rmarkdown-goodies-r-silent-chunk)
    (define-key markdown-mode-map (kbd "C-c M-b") 'rmarkdown-goodies-bash-code-chunk)
    (define-key markdown-mode-map (kbd "C-c M-n") 'rmarkdown-goodies-bash-text-only-chunk)
    (define-key markdown-mode-map (kbd "C-c M-o") 'rmarkdown-goodies-compile-rmd)))

(provide 'rmarkdown-goodies)
;;; rmarkdown-goodies.el ends here
