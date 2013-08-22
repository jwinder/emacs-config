(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook (lambda () (text-scale-set 2)))

;; bindings references: http://orgmode.org/orgcard.txt

(setq org-speed-commands-user
      '(
        ("P" . org-shiftmetaup) ;; move item up
        ("N" . org-shiftmetadown) ;; move item down
        ("h" . org-speed-command-help)
        ))

(setq org-use-speed-commands t)
(setq org-completion-use-ido t)
(setq org-return-follows-link t)
(setq org-hide-leading-stars t)
(setq org-enforce-todo-dependencies t)
(setq org-clock-out-when-done nil)
(setq org-agenda-start-with-follow-mode t)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a a") 'org-agenda)

(setq org-tags-column -75)

;; remove priority of item on DONE state
(setq org-after-todo-state-change-hook
      (lambda ()
        (when (string= org-state "DONE")
            (org-priority '?\s)
          )))

(defun org-get-weekly-clock-report (week)
  (end-of-line)
  (org-return t)
  (insert (format "#+BEGIN: clocktable :maxlevel 25 :narrow 200! :block %s :step day :scope tree1" week))
  (org-return t)
  (insert "#+END:")
  (org-clock-report))

(defun org-clock-report-last-week ()
  (interactive)
  (org-get-weekly-clock-report "lastweek"))

(defun org-clock-report-this-week ()
  (interactive)
  (org-get-weekly-clock-report "thisweek"))

(setq org-todo-keywords
      '((sequence "TODO" "CAPTURED" "BLOCKED" "DELEGATED" "DOING" "|" "DONE")))

(setq org-todo-keyword-faces
      '(("TODO" :background "DarkRed" :foreground "white" :box (:line-width 1 :style released-button))
        ("CAPTURED" :background "DarkBlue" :foreground "gray" :box (:line-width 1 :style released-button))
        ("DELEGATED" :background "DeepSkyBlue4" :foreground "white" :box (:line-width 1 :style released-button))
        ("DOING" :background "DeepSkyBlue4" :foreground "white" :box (:line-width 1 :style released-button))
        ("DONE" :background "DarkGreen" :foreground "white" :box (:line-width 1 :style released-button))))

(require 'org-install)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (ruby . t)
   ))

(custom-set-faces
 '(outline-1 ((t (:foreground "#D6B163" :bold t))))
 '(outline-2 ((t (:foreground "#A5F26E" :bold t))))
 '(outline-3 ((t (:foreground "#B150E7" :bold nil))))
 '(outline-4 ((t (:foreground "#529DB0" :bold nil))))
 '(outline-5 ((t (:foreground "#CC7832" :bold nil))))
 '(org-level-1 ((t (:inherit outline-1))))
 '(org-level-2 ((t (:inherit outline-2))))
 '(org-level-3 ((t (:inherit outline-3))))
 '(org-level-4 ((t (:inherit outline-4))))
 '(org-level-5 ((t (:inherit outline-5))))
 '(org-agenda-date ((t (:inherit font-lock-type-face))))
 '(org-agenda-date-weekend ((t (:inherit org-agenda-date))))
 '(org-scheduled-today ((t (:foreground "#ff6ab9" :italic t))))
 '(org-scheduled-previously ((t (:foreground "#d74b4b"))))
 '(org-upcoming-deadline ((t (:foreground "#d6ff9c"))))
 '(org-warning ((t (:foreground "#8f6aff" :italic t))))
 '(org-date ((t (:inherit font-lock-constant-face))))
 '(org-tag ((t (:inherit font-lock-comment-delimiter-face))))
 '(org-hide ((t (:foreground "#191919"))))
 '(org-column ((t (:background "#222222"))))
 '(org-column-title ((t (:background "DarkGreen" :foreground "white" :bold t :box (:line-width 1 :style released-button))))))

(provide 'mine-org)
