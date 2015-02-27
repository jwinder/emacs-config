(use-package afternoon-theme :ensure t
  :config (progn (load-theme 'afternoon t)
                 (set-cursor-color "dark grey")
                 (set-background-color "black")
                 (set-face-background 'fringe nil)))

(use-package scratch :ensure t)

(use-package org :ensure t)
(use-package gist :ensure t)
(use-package undo-tree :ensure t)

(use-package ag :ensure t
  :bind (("C-c a f" . ag))
  :config (setq ag-highlight-search t))

(use-package magit :ensure t
  :bind (("C-M-g" . magit-status)))

(use-package expand-region :ensure t
  :bind ("C-=" . er/expand-region))

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

(use-package flycheck :ensure t
  :idle (global-flycheck-mode)
  :config (progn (setq flycheck-standard-error-navigation nil)
                 (setq flycheck-display-errors-function nil)))


(use-package projectile :ensure t
  :idle (projectile-global-mode))

;; (define-key projectile-command-map (kbd "a") 'projectile-ag)

;; (use-package projectile :ensure t) ;; projectile + helm?

(use-package helm :ensure t)
(use-package helm-projectile :ensure t)
(use-package helm-descbinds :ensure t)


;; (setq projectile-completion-system 'helm)
;; (use-package helm-projectile
;;   :ensure t
;;   :idle (progn (helm-projectile-on)
;;                (define-key projectile-command-map (kbd "a") 'projectile-ag))
;;   :config (setq projectile-switch-project-action 'helm-projectile))
