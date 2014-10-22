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
