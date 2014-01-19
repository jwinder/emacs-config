
;; rcirc things

;; (defun mine-rcirc-message (message)
;;   (interactive "i")
;;   (rcirc-cmd-msg message))

;; (defun-rcirc-command msg (message)
;;   "Send private MESSAGE to TARGET."
;;   (interactive "i")
;;   (if (null message)
;;       (progn
;;         (setq target (completing-read "Message nick: "
;;                                       (with-rcirc-server-buffer
;; 					rcirc-nick-table)))
;;         (when (> (length target) 0)
;;           (setq message (read-string (format "Message %s: " target)))
;;           (when (> (length message) 0)
;;             (rcirc-send-message process target message))))
;;     (if (not (string-match "\\([^ ]+\\) \\(.+\\)" message))
;;         (message "Not enough args, or something.")
;;       (setq target (match-string 1 message)
;;             message (match-string 2 message))
;;       (rcirc-send-message process target message))))

(custom-set-faces
 '(rcirc-my-nick ((t (:foreground "#00ffff"))))
 '(rcirc-other-nick ((t (:foreground "#90ee90"))))
 '(rcirc-server ((t (:foreground "#a2b5cd"))))
 '(rcirc-server-prefix ((t (:foreground "#00bfff"))))
 '(rcirc-timestamp ((t (:foreground "#7d7d7d"))))
 '(rcirc-nick-in-message ((t (:foreground "#00ffff"))))
 '(rcirc-prompt ((t (:foreground "#00bfff")))))

(add-hook 'rcirc-mode-hook 'turn-on-flyspell)
(add-hook 'rcirc-mode-hook (lambda () (rcirc-track-minor-mode t)))

(setq rcirc-notify-message "%s: %s"
      rcirc-buffer-maximum-lines 2000)

(defun mine-rcirc-bury-buffers ()
  "Bury all rcirc-mode buffers."
  (interactive)
  (save-excursion)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (if (eq major-mode 'rcirc-mode)
          (bury-buffer buffer)))))

(defun mine-rcirc-next-active-buffer-bury-rcirc-buffers (arg)
  "Switch to the next rcirc buffer with activity, burying all rcirc buffers after returning to a non-rcirc buffer.
With prefix ARG, go to the next low priority buffer with activity."
  (interactive "P")
  (rcirc-next-active-buffer arg)
  (unless (eq major-mode 'rcirc-mode)
    (mine-rcirc-bury-buffers)))

(defun mine-rcirc-shut-up ()
  (interactive)
  (rcirc-track-minor-mode -1)
  (remq 'rcirc-activity-string global-mode-string))

(add-hook 'window-configuration-change-hook
          '(lambda ()
             (setq rcirc-fill-column (- (window-width) 2))))

(global-set-key [remap rcirc-next-active-buffer] 'mine-rcirc-next-active-buffer-bury-rcirc-buffers)

(provide 'mine-irc)
