(setq helm-split-window-in-side-p t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-scroll-amount 8
      helm-ff-file-name-history-use-recentf t
      helm-buffers-fuzzy-matching t
      helm-M-x-fuzzy-match t
      ;; helm-recentf-fuzzy-match t
      ;; helm-semantic-fuzzy-match t
      ;; helm-imenu-fuzzy-match t
      ;; helm-locate-fuzzy-match t
      helm-quick-update t)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(defalias 'kill-ring-show 'helm-show-kill-ring)

(helm-mode 1)
(helm-autoresize-mode 1)
