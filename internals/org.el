(defvar jw-org-todo-file "/path/to/my/org/todo.org") ;; override this in the private dir

(setq org-current-org-buffer-narrowed-to-subtree nil)
(defun org-narrow-or-widen ()
  (interactive)
  (if org-current-org-buffer-narrowed-to-subtree
      (progn (setq-local org-current-org-buffer-narrowed-to-subtree nil)
             (widen))
    (progn (setq-local org-current-org-buffer-narrowed-to-subtree t)
           (org-narrow-to-subtree))))

(defun todo ()
  (interactive)
  (find-file jw-org-todo-file)
  (cd (getenv "HOME")))

(defun toggle-todo ()
  (interactive)
  (if (string= (buffer-name) "todo.org")
      (switch-to-buffer (other-buffer))
    (todo)))

(global-set-key (kbd "C-c o") 'toggle-todo)
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

;; try to guess which states various (some possibly shared) org files might use and add them to org-todo-keyword-faces
(setq org--possible-todo-todo-states '("todo" "incoming")
      org--possible-blocked-todo-states '("blocked" "halted" "stalled")
      org--possible-doing-todo-states '("doing" "going")
      org--possible-delegated-todo-states '("delegated" "assigned")
      org--possible-done-todo-states '("done" "cancelled" "canceled" "finished" "boom"))

(defun org--make-single-todo-face-entry (state color)
  `(,state :background ,color :foreground white :box (:style released-button)))

(defun org--make-todo-face-entries (state color)
  `(,(org--make-single-todo-face-entry state color)
    ,(org--make-single-todo-face-entry (upcase state) color)
    ,(org--make-single-todo-face-entry (capitalize state) color)))

(defun org--make-red-face-entries (state) (org--make-todo-face-entries state "DarkRed"))
(defun org--make-blue-face-entries (state) (org--make-todo-face-entries state "DeepSkyBlue4"))
(defun org--make-green-face-entries (state) (org--make-todo-face-entries state "DarkGreen"))

(setq org-todo-keyword-faces
      (apply #'append (append (mapcar 'org--make-red-face-entries org--possible-todo-todo-states)
                              (mapcar 'org--make-red-face-entries org--possible-blocked-todo-states)
                              (mapcar 'org--make-blue-face-entries org--possible-doing-todo-states)
                              (mapcar 'org--make-blue-face-entries org--possible-delegated-todo-states)
                              (mapcar 'org--make-green-face-entries org--possible-done-todo-states))))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook '(lambda ()
                            (text-scale-set 2)
                            (save-window-excursion (calendar)) ;; start calendar silently for org-date-from-calendar
                            (define-key org-mode-map (kbd "C-c n") 'org-narrow-or-widen)))
