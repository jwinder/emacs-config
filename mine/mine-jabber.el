(require 'jabber)

(setq ssl-program-name "gnutls-cli"
      ssl-program-arguments '("--insecure" "-p" service host)
      ssl-certificate-verification-policy 1)

(add-hook 'jabber-chat-mode-hook 'goto-address)
(add-hook 'jabber-chat-mode-hook (lambda () (flyspell-mode t)))
(add-hook 'jabber-chat-mode-hook (lambda () (setq fill-column (- (window-width) 2))))

(setq jabber-groupchat-buffer-format "%n"
      jabber-chat-buffer-format "%n"
      jabber-history-enabled t
      jabber-use-global-history nil
      jabber-backlog-number 40
      jabber-backlog-days 30
      jabber-print-rare-time nil
      jabber-alert-message-hooks nil;;'(mine-jabber-mode-bar-alert)
      jabber-alert-presence-hooks nil
      jabber-alert-presense-message-function (lambda (who oldstatus newstatus statustext) nil))

(setq jabber-chat-prompt "[%t] %n >\s")
(setq jabber-muc-chat-prompt "[%t] %g/%n >\s")

(setq jabber-chat-foreign-prompt-format jabber-chat-prompt
      jabber-chat-local-prompt-format jabber-chat-prompt
      jabber-groupchat-prompt-format jabber-chat-prompt
      jabber-muc-private-foreign-prompt-format jabber-muc-chat-prompt)

(custom-set-faces
 '(jabber-activity-face ((t (:foreground "#4b89d0"))))
 '(jabber-activity-personal-face ((t :foreground "#4b89d0")))

 '(jabber-chat-prompt-local ((t (:foreground "#40e0d0"))))
 '(jabber-chat-prompt-foreign ((t (:foreground "#4b89d0"))))
 '(jabber-chat-prompt-system ((t (:foreground "#8b668b"))))
 '(jabber-chat-text-local ((t ())))
 '(jabber-chat-text-foreign ((t ())))
 '(jabber-chat-text-system ((t (:foreground "dark grey"))))
 '(jabber-chat-error ((t (:foreground "#cd3278"))))

 '(jabber-roster-user-online ((t (:foreground "#4b89d0"))))
 '(jabber-roster-user-away ((t (:foreground "#2e8b57" :slant italic))))
 '(jabber-roster-user-chatty ((t (:foreground "#ee2c2c"))))
 '(jabber-roster-user-error ((t (:foreground "#4b89d0"))))
 '(jabber-roster-user-offline ((t (:foreground "dark grey" :slant italic))))
 )

(defalias 'jabber-roster 'jabber-switch-to-roster-buffer)

(defun mine-jabber-groupchat-join (room nickname)
  (jabber-muc-join (jabber-read-account) room nickname t))

(defun mine-jabber-bury-buffers ()
  (interactive)
  (save-excursion)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (eq major-mode 'jabber-chat-mode)
        (bury-buffer buffer))))
  (when (eq major-mode 'jabber-chat-mode)
    (switch-to-buffer (other-buffer))))

(defun mine-jabber-return ()
  "Open address at point or send jabber input if appropriate."
  (interactive)
  (unless (mine-jabber-send-input)
    (mine-jabber-browse-url-at-point)))

(defun mine-jabber-browse-url-at-point ()
  "Opens url at point and returns true or nil."
  (require 'browse-url)
  (let ((url (browse-url-url-at-point)))
    (if url
        (progn (browse-url url) t)
      nil)))

(defun mine-jabber-send-input ()
  "Sends jabber input if on input line, returning t or nil"
  (interactive)
  (if (eq (count-lines (point-min) (point)) (count-lines (point-min) (point-max)))
      (progn (jabber-chat-buffer-send) t)
    nil))

(defun mine-jabber-next-active-buffer-bury-jabber-buffers (&optional jid-param)
  "Switch to next jabber buffer with activity, burying all jabber buffers after all are cycled."
  (interactive)
  (jabber-activity-switch-to jid-param)
  (unless (eq major-mode 'jabber-chat-mode)
    (mine-jabber-bury-buffers)))

(define-key jabber-chat-mode-map (kbd "RET") 'mine-jabber-return)
(define-key jabber-chat-mode-map [C-return] 'newline)
(define-key jabber-chat-mode-map (kbd "C-x C-j C-n") 'jabber-muc-names)

(global-set-key (kbd "C-x C-j C-SPC") 'mine-jabber-next-active-buffer-bury-jabber-buffers)
(global-set-key [remap jabber-activity-switch-to] 'mine-jabber-next-active-buffer-bury-jabber-buffers) ;; C-x C-j C-l

(provide 'mine-jabber)
