(require 'rcirc)

;; you should consider a custom nickname in your private dir!
;; e.g.
;; (setq rcirc-default-nick "your nick"
;;       rcirc-default-user-name "your username"
;;       rcirc-default-full-name "your full name")

(setq rcirc-notify-message "%s: %s"
      rcirc-buffer-maximum-lines 2000)

(add-to-list 'rcirc-omit-responses "MODE")

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

(add-hook 'rcirc-mode-hook
          '(lambda ()
             (turn-on-flyspell)
             (rcirc-track-minor-mode t)
             (rcirc-omit-mode)))

(add-hook 'window-configuration-change-hook
          '(lambda () (setq rcirc-fill-column (- (window-width) 2))))
