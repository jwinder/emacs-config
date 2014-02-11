(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(require 'diminish)
(add-hook 'org-mode-hook '(lambda () (text-scale-set 2) (diminish 'text-scale-mode)))

;; bindings references: http://orgmode.org/orgcard.txt

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

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a a") 'org-agenda)

;; remove priority of item on a done state
(setq org-after-todo-state-change-hook
      '(lambda () (when (or (string= org-state "done") (string= org-state "cancelled") (string= org-state "abandoned")) (org-priority '?\s))))

;; (setq org-clock-persist 'history)
;; (org-clock-persistence-insinuate)

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

(require 'org-install)
(org-babel-do-load-languages 'org-babel-load-languages '((sh . t) (ruby . t)))

(custom-set-faces
 '(outline-1 ((t (:foreground "#cdb5cd" :bold nil))))
 '(outline-2 ((t (:foreground "#00cdcd" :bold nil))))
 '(outline-3 ((t (:foreground "#7a67ee" :bold nil))))
 '(outline-4 ((t (:foreground "#36648b" :bold nil))))
 '(outline-5 ((t (:foreground "#cc5555" :bold nil))))
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
 '(org-column-title ((t (:background "DarkGreen" :foreground "white" :bold t :box (:line-width 1 :style released-button)))))
 '(org-mode-line-clock ((t (:inheret region :foreground unspecified :background unspecified))))
 '(org-mode-line-clock-overrun ((t (:inheret region :foreground unspecified :background unspecified)))))

(defun org-dblock-write:rangereport (params)
  "Display day-by-day time reports."
  (let* ((ts (plist-get params :tstart))
         (te (plist-get params :tend))
         (start (time-to-seconds
                 (apply 'encode-time (org-parse-time-string ts))))
         (end (time-to-seconds
               (apply 'encode-time (org-parse-time-string te))))
         day-numbers)
    (setq params (plist-put params :tstart nil))
    (setq params (plist-put params :end nil))
    (while (<= start end)
      (save-excursion
        (insert "\n\n"
                (format-time-string (car org-time-stamp-formats)
                                    (seconds-to-time start))
                "----------------\n")
        (org-dblock-write:clocktable
         (plist-put
          (plist-put
           params
           :tstart
           (format-time-string (car org-time-stamp-formats)
                               (seconds-to-time start)))
          :tend
          (format-time-string (car org-time-stamp-formats)
                              (seconds-to-time end))))
        (setq start (+ 86400 start))))))

(provide 'mine-org)
