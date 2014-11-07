(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)
(unless (file-exists-p package-user-dir)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(use-package afternoon-theme
  :ensure t
  :config
  (progn
    (load-theme 'afternoon t)
    (set-cursor-color "dark grey")
    (set-background-color "black")))

(use-package diminish
  :ensure t
  :config
  (progn
    (eval-after-load 'eldoc '(diminish 'eldoc-mode))
    (eval-after-load 'flyspell '(diminish 'flyspell-mode))
    (diminish 'abbrev-mode)))

(use-package ido-vertical-mode
  :ensure t
  :config (ido-vertical-mode t))

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package ag
  :ensure t
  :bind (("C-M-s" . ag)
         ("C-c a g" . ag))
  :config (setq ag-highlight-search t))

(use-package switch-window
  :ensure t
  :bind ("C-x o" . switch-window))

(use-package scratch
  :ensure t)

(use-package edit-server
  :ensure t
  :idle (edit-server-start)
  :config (progn
            (add-to-list 'edit-server-url-major-mode-alist '("github\\.com" . markdown-mode))
            (add-to-list 'edit-server-url-major-mode-alist '("trello\\.com" . markdown-mode))
            (add-hook 'edit-server-edit-mode-hook
                      '(lambda () (set-frame-position (selected-frame) 360 200)))
            (add-hook 'edit-server-edit-mode-hook 'beginning-of-buffer)
            (add-hook 'edit-server-done-hook 'ns-raise-chrome)))

;; (use-package gmail-message-mode
;;   :ensure t)

(use-package org
  :ensure t
  :pre-load
  (unless (package-activate 'org '(20140519))
    (package-install 'org)))

(use-package htmlize
  :ensure t)

(use-package gist
  :ensure t)

(use-package restclient
  :ensure t
  :mode (("\\.http$" . restclient-mode)))

;; (use-package projectile
;;   :ensure t
;;   :idle (projectile-global-mode)
;;   :diminish projectile-mode
;;   :config (define-key projectile-command-map (kbd "a") 'projectile-ag))

(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status))
  :diminish magit-auto-revert-mode
  :config
  (progn (add-hook 'magit-log-edit-mode-hook '(lambda () (flyspell-mode t)))
         (add-hook 'magit-log-edit-mode-hook
                   '(lambda ()
                      (set (make-local-variable 'whitespace-style) '(face lines-tail))
                      (set (make-local-variable 'whitespace-line-column) 72)
                      (whitespace-mode t)))))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :idle (smartparens-global-mode t)
  :config (progn
            (require 'smartparens-config)
            (add-hook 'smartparens-enabled-hook '(lambda () (setq smartparens-strict-mode t)))
            (setq sp-highlight-wrap-overlay nil)
            (setq sp-highlight-wrap-tag-overlay nil)
            (setq sp-highlight-pair-overlay nil)
            (sp-use-smartparens-bindings)
            (define-key sp-keymap (kbd "M-<backspace>") nil)
            (define-key sp-keymap (kbd "C-M-p") nil)
            (define-key sp-keymap (kbd "C-M-n") nil)))

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-*" . mc/mark-all-like-this)))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package browse-kill-ring
  :ensure t
  :bind (("C-c C-y" . browse-kill-ring)
         ("C-c y" . browse-kill-ring)))

(use-package undo-tree
  :ensure t
  :bind (("C-/" . undo-tree-undo)
         ("C-?" . undo-tree-redo)
         ("C-x v" . undo-tree-visualize)))

;; (use-package yasnippet
;;   :ensure t
;;   :diminish yas-minor-mode
;;   :idle (yas-global-mode t)
;;   :config
;;   (progn
;;     (setq yas-snippet-dirs (remove "~/.emacs.d/snippets" yas-snippet-dirs))
;;     (add-to-list 'yas-snippet-dirs "~/.emacs.d/custom/snippets")
;;     (add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t)))))

(use-package flycheck
  :ensure t
  :idle (global-flycheck-mode)
  :config (progn
            (diminish 'flycheck-mode " Φ")
            (setq flycheck-standard-error-navigation nil)
            (setq flycheck-display-errors-function nil)))

(use-package json-reformat
  :ensure t)

(use-package markdown-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
            (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))))

(use-package coffee-mode
  :ensure t
  :config (setq coffee-tab-width 2))

(use-package yaml-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package scala-mode2
  :ensure t
  :mode (("\\.scala\\'" . scala-mode)
         ("\\.sbt\\'" . scala-mode))
  :config
  (progn
    (add-hook 'scala-mode-hook '(lambda ()
                             (c-subword-mode t)))
    (setq scala-indent:align-parameters t)
    (setq scala-indent:align-forms t)))

(use-package sbt-mode
  :ensure t
  :config
  (add-hook 'sbt-mode-hook '(lambda ()
                              (setq compilation-skip-threshold 2)
                              (local-set-key (kbd "C-a") 'comint-bol)
                              (local-set-key (kbd "M-RET") 'comint-accumulate)))
  :bind (("C-c s s" . sbt-start)
         ("C-c s o" . mine-sbt-test-only-current-test)))

(defun mine-sbt-current-test-in-buffer ()
  (save-excursion
    (goto-char (point-min))
    (let* ((pkg-name (progn
                       (re-search-forward "package ")
                       (filter-buffer-substring (point) (point-at-eol))))
           (test-name (progn
                        (re-search-forward "\\(object\\|class\\) ")
                        (filter-buffer-substring
                         (point)
                         (progn
                           (re-search-forward " ")
                           (forward-char -1)
                           (point))))))
      (concat pkg-name "." test-name))))

(defun mine-sbt-test-only-current-test ()
  (interactive)
  (sbt-command (concat "test-only " (mine-sbt-current-test-in-buffer))))

;; (use-package haskell-mode
;;   :ensure t
;;   :config
;;   (progn
;;     (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;     (add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
;;     (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)

;;     (setq haskell-process-suggest-remove-import-lines t
;;           haskell-process-auto-import-loaded-modules t
;;           haskell-process-suggest-hoogle-imports nil ;; 'cabal install hoogle' fails
;;           haskell-process-log t
;;           haskell-process-type 'cabal-repl
;;           haskell-interactive-mode-eval-mode 'haskell-mode
;;           haskell-process-show-debug-tips nil)

;;     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;;     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-bring)
;;     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;;     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;;     (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;;     (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;;     (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
;;     (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def-or-tag)
;;     (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
;;     (eval-after-load 'haskell-cabal '(define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal))))

(use-package ruby-mode
  :mode (("Vagrantfile$" . ruby-mode)
         ("Rakefile$" . ruby-mode)
         ("Gemfile$" . ruby-mode)
         ("Berksfile$" . ruby-mode)))

(use-package ox-reveal
  :ensure t)

(provide 'mine-packages)
