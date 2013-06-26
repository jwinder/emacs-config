(global-set-key [f8] 'pomodoro-start-or-void)

(add-hook 'pomodoro-start-hook 'mine-rcirc-shut-up)
(add-hook 'pomodoro-void-hook 'rcirc-track-minor-mode)
(add-hook 'pomodoro-finished-hook 'rcirc-track-minor-mode)

;; for changing rcirc nick in pomodoro mode

;; (add-hook 'pomodoro-start-hook '(lambda () (mine-rcirc-switch-nick-activity "pomodoro")))
;; (add-hook 'pomodoro-void-hook '(lambda () (mine-rcirc-switch-nick-activity nil)))
;; (add-hook 'pomodoro-finished-hook '(lambda () (mine-rcirc-switch-nick-activity nil)))

;; (defun mine-rcirc-switch-nick-activity (activity)
;;   (interactive "sActivity: ")
;;   (let ((rcirc-buffer (get-buffer "*irc.banno.com*")))
;;     (if rcirc-buffer
;;         (if (or (not activity) (string-equal activity ""))
;;             (rcirc-cmd-nick "rubbish" (get-buffer-process rcirc-buffer))
;;           (rcirc-cmd-nick (concat "rubbish|" activity) (get-buffer-process rcirc-buffer))))))
