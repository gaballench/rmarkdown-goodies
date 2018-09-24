; invented a function and keybinding for inserting an r code chunk in markdown-mode:)
(defun rmarkdown-goodies-r-code-chunk ()
  (interactive)
  (insert "```{r}")
  (newline)
  (newline)
  (insert-before-markers "```")
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char))

;; rmarkdown-goodies-compile will compile the current buffer with Rscript and the render function of the rmarkdown package
(defun rmarkdown-goodies-compile ()
  (interactive)
  (shell-command (concat "Rscript -e 'rmarkdown::render("
			       (concat "\"" buffer-file-name "\"") 
			       ")'")))


;; Keybinds
; bind the insert code chunk function to C-c C-c C-c:
(global-set-key (kbd "C-c C-c C-c") 'rmarkdown-goodies-r-code-chunk)
; bind with a key C-c m d:
(global-set-key (kbd "C-c m d") 'rmarkdown-goodies-compile)

