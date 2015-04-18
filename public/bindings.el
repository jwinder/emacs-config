(global-set-key (kbd "C-c M-e") 'eshell-and-cd-pwd)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

(global-set-key (kbd "C-M-g") 'goto-line)

(global-set-key (kbd "C-M-9") 'winner-undo)
(global-set-key (kbd "C-M-0") 'winner-redo)

(global-set-key (kbd "C-x 9") 'toggle-window-split)

(global-set-key (kbd "C-a") 'beginning-of-line-or-indentation)
(global-set-key (kbd "C-o") 'open-line-previous)
(global-set-key (kbd "C-j") 'newline-and-open-line-previous)

(global-set-key (kbd "M-;") 'comment-dwim-region-or-line)

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
