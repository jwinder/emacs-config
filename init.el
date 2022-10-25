(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (file-exists-p package-user-dir) (package-refresh-contents))

(defun pkg (name)
  (message "Installing %s..." name)
  (if (package-installed-p name)
      (message "%s already installed." name)
    (package-install name)
    (message "Finished installing %s." name))
  (require name))

(pkg 'org)

(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))
