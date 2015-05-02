(defun emacs-reload-config ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

(defun emacs-destructively-reload-config ()
  (interactive)
  (when (file-exists-p package-user-dir)
    (delete-directory package-user-dir t))
  (emacs-reload-config))

(defun emacs-uptime ()
  (interactive)
  (message (format "%d days" (random 100))))

;; Bumping the current emacs config version

(defun emacs-config--get-version-components ()
  (mapcar 'string-to-number (split-string jw-config-version "\\.")))

(defun emacs-config--make-version-number (components)
  (mapconcat 'number-to-string components "."))

(defun emacs-config--get-next-bugfix-version ()
  (let ((ns (emacs-config--get-version-components)))
    (emacs-config--make-version-number `(,(car ns) ,(nth 1 ns) ,(+ 1 (nth 2 ns))))))

(defun emacs-config--get-next-minor-version ()
  (let ((ns (emacs-config--get-version-components)))
    (emacs-config--make-version-number `(,(car ns) ,(+ 1 (nth 1 ns)) 0))))

(defun emacs-config--get-next-major-version ()
  (let ((ns (emacs-config--get-version-components)))
    (emacs-config--make-version-number `(,(+ 1 (car ns)) 0 0))))

(defun emacs-config--update-version-in-emacs-config (old-version next-version)
  (let* ((filename (concat user-emacs-directory "internals/init.el"))
         (contents (mapconcat 'identity (jw--read-file-lines-to-string filename) "\n"))
         (updated-contents (replace-regexp-in-string old-version next-version contents)))
    (write-region updated-contents nil filename)))

(defun emacs-config--commit-tag-push (tag-version)
  (let ((git-command (format "cd %s && git add -A && git commit -m \"Next release %s\" && git tag %s && git push --tags origin master"
                             user-emacs-directory tag-version tag-version)))
    (shell-command git-command)))

(defun emacs-config--release-version (previous-version next-version)
  (if (yes-or-no-p (format "Push release %s? " next-version))
      (progn (setq jw-config-version next-version)
             (emacs-config--update-version-in-emacs-config previous-version next-version)
             (emacs-config--commit-tag-push next-version)
             (message "Release of %s finished!" next-version))
    (message "Release of %s aborted." next-version)))

(defun emacs-config-bump-bugfix-version ()
  (interactive)
  (emacs-config--release-version jw-config-version (emacs-config--get-next-bugfix-version)))

(defun emacs-config-bump-minor-version ()
  (interactive)
  (emacs-config--release-version jw-config-version (emacs-config--get-next-minor-version)))

(defun emacs-config-bump-major-version ()
  (interactive)
  (emacs-config--release-version jw-config-version (emacs-config--get-next-major-version)))
