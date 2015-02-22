(global-set-key (kbd "C-c m") 'eshell)

(global-set-key (kbd "C-x n") 'switch-to-buffer)
(global-set-key (kbd "C-c a r") 'align-regexp)
(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "C-M-9") 'winner-undo)
(global-set-key (kbd "C-M-0") 'winner-redo)

(global-set-key (kbd "C-x 9") 'toggle-window-split)

(global-set-key [remap move-beginning-of-line] 'beginning-of-line-or-indentation) ;; C-a
(global-set-key [remap open-line] 'open-line-previous) ;; C-o
(global-set-key (kbd "C-j") 'newline-and-open-line-previous)

(global-set-key (kbd "M-;") 'comment-dwim-region-or-line)

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
