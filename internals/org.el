(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-speed-commands-user
      '(("P" . org-shiftmetaup) ;; move item up
        ("N" . org-shiftmetadown) ;; move item down
        ("h" . org-speed-command-help)))

(setq org-use-speed-commands t
      org-completion-use-ido t
      org-return-follows-link t
      org-hide-leading-stars t
      org-enforce-todo-dependencies t
      org-clock-out-when-done nil
      org-clock-clocked-in-display 'mode-line
      org-agenda-start-with-follow-mode t
      org-refile-targets '((org-agenda-files :maxlevel . 10))
      org-refile-use-outline-path t
      org-refile-allow-creating-parent-nodes '(confirm)
      org-tags-column -100)

(setq org-todo-keywords
      '((sequence "todo" "blocked" "delegated" "doing" "|" "done")
        (sequence "|" "cancelled")))

(setq org-todo-keyword-faces
      '(("todo" :background "DarkRed" :foreground "white" :box (:line-width 1 :style released-button))
        ("blocked" :background "DarkRed" :foreground "white" :box (:line-width 1 :style released-button))
        ("delegated" :background "DeepSkyBlue4" :foreground "white" :box (:line-width 1 :style released-button))
        ("doing" :background "DeepSkyBlue4" :foreground "white" :box (:line-width 1 :style released-button))
        ("done" :background "DarkGreen" :foreground "white" :box (:line-width 1 :style released-button))
        ("cancelled" :background "DarkGreen" :foreground "white" :box (:line-width 1 :style released-button))))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook '(lambda () (text-scale-set 2)))
