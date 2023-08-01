(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless (file-exists-p package-user-dir) (package-refresh-contents))

(require 'org)
(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))
