(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(unless (file-exists-p package-user-dir) (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-install 'use-package))
(setq use-package-always-ensure t)

(require 'use-package)
(use-package org-plus-contrib)

(setq package-enable-at-startup nil)
(org-babel-load-file (concat user-emacs-directory "emacs.org"))
