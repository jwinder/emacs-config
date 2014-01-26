(custom-set-faces
 '(rcirc-my-nick ((t (:foreground "#00ffff"))))
 '(rcirc-other-nick ((t (:foreground "#90ee90"))))
 '(rcirc-server ((t (:foreground "#a2b5cd"))))
 '(rcirc-server-prefix ((t (:foreground "#00bfff"))))
 '(rcirc-timestamp ((t (:foreground "#7d7d7d"))))
 '(rcirc-nick-in-message ((t (:foreground "#00ffff"))))
 '(rcirc-prompt ((t (:foreground "#00bfff"))))
 '(rcirc-keyword ((t :foreground "#00ffff")))
 '(rcirc-nick-in-message-full-line ((t ())))
 '(rcirc-track-nick ((t (:foreground "#00ffff"))))
 '(rcirc-track-keyword ((t (:foreground "#00ffff")))))

(add-hook 'rcirc-mode-hook 'turn-on-flyspell)
(add-hook 'rcirc-mode-hook '(lambda () (rcirc-track-minor-mode t)))
(add-hook 'window-configuration-change-hook '(lambda () (setq rcirc-fill-column (- (window-width) 2))))

(setq rcirc-notify-message "%s: %s"
      rcirc-buffer-maximum-lines 2000)

(defun mine-rcirc-bury-buffers ()
  "Bury all rcirc-mode buffers."
  (interactive)
  (save-excursion
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (if (eq major-mode 'rcirc-mode)
            (bury-buffer buffer))))))

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

(global-set-key [remap rcirc-next-active-buffer] 'mine-rcirc-next-active-buffer-bury-rcirc-buffers)

;;;###autoload
(define-minor-mode hipchat-mode "Hipchat minor mode"
  :group 'hipchat
  :lighter "hipchat")

(defun turn-on-hipchat-mode ()
  (interactive)
  (hipchat-mode t))

(defun turn-off-hipchat-mode ()
  (interactive)
  (hipchat-mode -1))

(add-hook 'rcirc-mode-hook '(lambda () (when (search "_hipchat@localhost" (buffer-name)) (turn-on-hipchat-mode))))
(add-hook 'hipchat-mode-hook '(lambda () (setq-local rcirc-nick-completion-format "@%s "))) ;; hipchat uses @name, not name:

(provide 'mine-irc)
