(defun reload-emacs-config ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

(defun ping-google ()
  (interactive)
  (ping "google.com"))

(defun uuid ()
  (interactive)
  (insert (downcase (shell-command-to-string "uuidgen | tr -d '\n'"))))

(defalias 'qrr 'query-replace-regex)
(defalias 'filter-lines 'keep-lines)
(defalias 'filter-out-lines 'flush-lines)
(defalias 'elisp-shell 'ielm)
