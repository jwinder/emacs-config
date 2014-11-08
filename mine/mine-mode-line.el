(setq display-time-format "\s(%I:%M%p %a %m/%d/%y)\s")
(setq display-time-mail-file -1)
(setq display-time-default-load-average nil)

;; (setq battery-mode-line-format "(%p %B)\s")
;; (setq battery-echo-area-format "Battery: %p%% %B")
;; (setq battery-update-interval 10)

;; (display-time)
;; (display-battery-mode) ;; is it updating correctly?
;; (column-number-mode)

(custom-set-faces
 '(mode-line ((t (:family "Monaco" :background nil :foreground "#ff7a58" :box nil))))
 '(mode-line-inactive ((t (:family "Monaco" :background nil :foreground "gray" :box nil))))
 '(mode-line-buffer-id ((t :family "Monaco" :background nil :foreground "#7db5d6"))))

(setq mine-mode-line-format '(" \u222E " mode-line-buffer-identification " dr\u20D7"))

(defun mode-line-on ()
  "Turn on mode line in all buffers."
  (interactive)
  (setq-default mode-line-format mine-mode-line-format))

(defun mode-line-off ()
  "Turn off mode line in all buffers."
  (interactive)
  (setq-default mode-line-format nil))

(defun mode-line-toggle ()
  "Toggles mode line on/off."
  (interactive)
  (if mode-line-format
      (mode-line-off)
    (mode-line-on)))

(defalias 'buffer-name-off 'mode-line-off)
(defalias 'buffer-name-on 'mode-line-on)

(mode-line-on)

(provide 'mine-mode-line)
