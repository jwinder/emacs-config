(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; bindings references: http://orgmode.org/orgcard.txt

(setq org-speed-commands-user
      '(
        ("P" . org-shiftmetaup) ;; move item up
        ("N" . org-shiftmetadown) ;; move item down
        ("h" . org-speed-command-help)
        ))

(setq org-use-speed-commands t)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a a") 'org-agenda)

(global-set-key (kbd "C-c C-x 1") 'org-ordered-list-start)
(global-set-key (kbd "C-c C-x l") 'org-checklist-start)

(global-set-key [remap org-meta-return] 'org-insert-subheading) ;; M-RET to indent another subheading level
(global-set-key [remap org-insert-todo-heading-respect-content] 'org-ordered-list-start) ;; C-S-RET starts an ordered list
(global-set-key [remap org-insert-todo-heading] 'org-checklist-start) ;; M-S-RET starts an ordered checklist

(defun org-ordered-list-start ()
  (interactive)
  (end-of-line)
  (org-return t)
  (insert "1. "))

(defun org-checklist-start ()
  (interactive)
  (end-of-line)
  (org-return t)
  (insert "1. [ ] "))

(defun org-get-weekly-clock-report (week)
  (end-of-line)
  (org-return t)
  (insert (format "#+BEGIN: clocktable :block %s :step day" week))
  (org-return t)
  (insert "#+END:")
  (org-clock-report))

(defun org-clock-report-last-week ()
  (interactive)
  (org-get-weekly-clock-report "lastweek"))

(defun org-clock-report-this-week ()
  (interactive)
  (org-get-weekly-clock-report "thisweek"))

(setq org-completion-use-ido t)

(setq org-todo-keywords
       '((type "CAPTURED" "BACKLOG" "BLOCKED" "TODO" "|" "DONE" "DELEGATED")))

;; TODO change the location to dropbox or somewhere
(setq org-default-notes-file "~/.notes")
(setq org-capture-templates '(
                              ("c" "" entry (file+headline "~/.notes/captured.org" "Captured")
                               "* CAPTURED %?\n  %i")
                              ("a c" "" entry (file+headline "~/.notes/captured.org" "All Captured")
                               "* CAPTURED %?\n  %i\n  %a")
                              ))

(define-key global-map (kbd "C-c c") (lambda () (interactive) (org-capture nil "c"))) ;; capture just text
(define-key global-map (kbd "C-c a c") (lambda () (interactive) (org-capture nil "a c"))) ;; capture text + org-link

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
 '(org-todo ((t (:background "DarkRed" :foreground "white" :box (:line-width 1 :style released-button)))))
 '(org-done ((t (:background "DarkGreen" :foreground "white" :box (:line-width 1 :style released-button)))))
 '(org-column ((t (:background "#222222"))))
 '(org-column-title ((t (:background "DarkGreen" :foreground "white" :bold t :box (:line-width 1 :style released-button))))))

(provide 'mine-org)
