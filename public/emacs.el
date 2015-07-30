(defun emacs-reload-config ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

(defun emacs-archive-packages-and-reload-config ()
  (interactive)
  (emacs-archive-packages)
  (emacs-reload-config))

(defun emacs-archive-packages-and-die ()
  (interactive)
  (emacs-archive-packages)
  (save-buffers-kill-terminal))

(defun emacs-archive-packages ()
  (when (file-exists-p package-user-dir)
    (let ((archive-dir (format "/tmp/emacs-elpa--%s" (current-time-string))))
      (copy-directory package-user-dir archive-dir)
      (delete-directory package-user-dir t))))
