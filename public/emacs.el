(defun emacs-reload-config ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

(defun emacs-archive-deps-and-reload-config ()
  (interactive)
  (emacs-archive-deps-dir)
  (emacs-reload-config))

(defun emacs-archive-deps-and-die ()
  (interactive)
  (emacs-archive-deps-dir)
  (save-buffers-kill-terminal))

(defun emacs-archive-deps-dir ()
  (when (file-exists-p package-user-dir)
    (let ((archive-dir (format "/tmp/emacs-elpa--%s" (current-time-string))))
      (copy-directory package-user-dir archive-dir)
      (delete-directory package-user-dir t))))
