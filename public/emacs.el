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
  (let ((ns (emacs--get-version-components)))
    (emacs--make-version-number `(,(car ns) ,(nth 1 ns) ,(+ 1 (nth 2 ns))))))

(defun emacs-config--get-next-minor-version ()
  (let ((ns (emacs--get-version-components)))
    (emacs--make-version-number `(,(car ns) ,(+ 1 (nth 1 ns)) 0))))

(defun emacs-config--get-next-major-version ()
  (let ((ns (emacs--get-version-components)))
    (emacs--make-version-number `(,(+ 1 (car ns)) 0 0))))

(defun emacs-config--update-readme ()
  (let* ((header "Emacs Config")
         (content (replace-regexp-in-string ";; " "" (make-initial-hello-message)))
         (file (concat user-emacs-directory "README.md"))
         (readme (concat "## " header "\n\n" content)))
    (write-region readme nil file)))

(defun emacs-config--commit-tag-push (tag-version)
  (let ((git-command (format "cd %s && git add -A && git commit -m \"Next release %s\" && git tag %s && git push --tags origin master"
                             user-emacs-directory tag-version tag-version)))
    (shell-command git-command)))

(defun emacs-config--release-version (next-version)
  (setq jw-config-version next-version)
  (emacs-config--commit-tag-push next-version))

(defun emacs-config-bump-bugfix-version ()
  (interactive)
  (emacs-config--release-version (emacs-config--get-next-bugfix-version)))

(defun emacs-config-bump-minor-version ()
  (interactive)
  (emacs-config--release-version (emacs-config--get-next-minor-version)))

(defun emacs-config-bump-major-version ()
  (interactive)
  (emacs-config--release-version (emacs-config--get-next-major-version)))
