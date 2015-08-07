(use-package afternoon-theme :ensure t
  :config (progn (load-theme 'afternoon t)
                 (set-cursor-color "dark grey")
                 (set-background-color "black")
                 (set-face-background 'fringe nil)))

(use-package scratch :ensure t)

(use-package org :ensure t)

(use-package gist :ensure t)

(use-package undo-tree :ensure t
  :config (global-undo-tree-mode 1))

(use-package magit :ensure t)

(use-package expand-region :ensure t
  :bind (("C-=" . er/expand-region)))

(use-package multiple-cursors :ensure t
  :bind (("C-*" . mc/mark-all-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-x r t" . mc/edit-lines)))

(use-package smartparens :ensure t
  :config (progn (require 'smartparens-config)
                 (smartparens-global-mode t)
                 (sp-use-smartparens-bindings)
                 (define-key sp-keymap (kbd "M-<backspace>") nil)
                 (define-key sp-keymap (kbd "C-M-p") nil)
                 (define-key sp-keymap (kbd "C-M-n") nil)))

(use-package helm :ensure t)
(use-package helm-ag :ensure t)
(use-package helm-swoop :ensure t)
(use-package helm-projectile :ensure t)
(use-package helm-flycheck :ensure t)
(use-package helm-flyspell :ensure t)
(use-package helm-descbinds :ensure t)

(use-package sx :ensure t
  :bind (("C-c x" . sx-search)))

(use-package hackernews :ensure t
  :config (progn (require 'hackernews)
                 (setq hackernews-top-story-limit 100)
                 (set-face-attribute 'hackernews-link-face nil :foreground "SkyBlue1")
                 (advice-add 'hackernews :after #'(lambda () (when (string= (buffer-name) "*hackernews*") (text-scale-set 2))))))
