(require 'helm)
(require 'helm-dabbrev)

(setq helm-split-window-in-side-p t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-scroll-amount 8
      helm-ff-file-name-history-use-recentf t
      helm-buffers-fuzzy-matching t
      helm-M-x-fuzzy-match t
      helm-recentf-fuzzy-match t
      helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t
      helm-locate-fuzzy-match t
      helm-quick-update t)

(setq projectile-completion-system 'helm)

(setq flycheck-standard-error-navigation nil
      flycheck-display-errors-function nil)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-command-map (kbd "h") 'helm-descbinds)

(define-key helm-command-map (kbd "s") 'helm-google-suggest)
(define-key helm-command-map (kbd "w") 'helm-wikipedia-suggest)

(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-s C-s") 'helm-ag)
(global-set-key (kbd "M-s o") 'helm-occur)
(global-set-key (kbd "M-s i") 'helm-semantic-or-imenu)
(global-set-key (kbd "M-/") 'helm-dabbrev)

(defalias 'kill-ring-show 'helm-show-kill-ring)
(defalias 'list-colors-display 'helm-colors)
(defalias 'proced 'helm-top)

(set-face-attribute 'helm-source-header nil :height 1.0 :weight 'normal :family (jw--font-name) :box '(:style released-button))
(set-face-attribute 'helm-candidate-number nil :background nil :foreground "Goldenrod")

(add-hook 'eshell-mode-hook
          '(lambda ()
             (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
             (define-key eshell-mode-map (kbd "M-p") 'helm-eshell-history)))

(add-hook 'projectile-mode-hook
          '(lambda ()
             (define-key projectile-command-map (kbd "a") 'helm-projectile-ag)
             (setq projectile-switch-project-action 'helm-projectile-ag)))

(add-hook 'flycheck-mode-hook
          '(lambda ()
             (define-key flycheck-mode-map (kbd "C-c ! l") 'helm-flycheck)))

(helm-mode 1)
(helm-autoresize-mode 1)

(projectile-global-mode)
(helm-projectile-on)

(global-flycheck-mode)

(add-to-list 'helm-dabbrev-major-mode-assoc '(scala-mode . sbt-mode))

;; this allows fresh completions directly following periods
(setq helm-dabbrev--original-regexp-format helm-dabbrev--regexp)
(setq helm-dabbrev--regexp (concat helm-dabbrev--original-regexp-format "\\|\\."))
