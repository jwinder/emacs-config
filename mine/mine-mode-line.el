(setq display-time-format "\s(%I:%M%p %a %m/%d/%y)\s")
(setq display-time-mail-file -1)
(setq display-time-default-load-average nil)

(setq battery-mode-line-format "(%p %B)\s")
(setq battery-echo-area-format "Battery: %p%% %B")
(setq battery-update-interval 10)

(display-time)
;; (display-battery-mode) ;; is it updating correctly?
(column-number-mode)

;; todo -- the mode line border and font is annoying
(setq mine-default-mode-line-format mode-line-format)

(defun mode-line-on ()
  "Turn on mode line in all buffers."
  (interactive)
  (setq-default mode-line-format mine-default-mode-line-format))

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

(mode-line-off)

(provide 'mine-mode-line)
