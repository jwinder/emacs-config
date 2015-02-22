(defun reload-emacs-config ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

(defun ping-google ()
  (interactive)
  (ping "google.com"))

(defun uuid ()
  (interactive)
  (insert (downcase (shell-command-to-string "uuidgen | tr -d '\n'"))))
