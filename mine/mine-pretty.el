(require 'ansi-color)
(ansi-color-for-comint-mode-on)

(show-paren-mode t)
(transient-mark-mode t)
(blink-cursor-mode t)

;; Remove noise
;; (global-hl-line-mode t)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(defun mine-font (&optional size) (if size (concat "Monaco " size) "Monaco"))
(defvar mine-small-font (mine-font "11") "*The small font")
(defvar mine-normal-font (mine-font "14") "*The main font")
(defvar mine-big-font (mine-font "20") "*The big font")

;; mode line settings

(setq display-time-format "\s(%I:%M%p %a %m/%d/%y)\s")
(setq display-time-mail-file -1)
(setq display-time-default-load-average nil)

;; (setq battery-mode-line-format "(%p %B)\s")
;; (setq battery-echo-area-format "Battery: %p%% %B")
;; (setq battery-update-interval 10)

;; (display-time)
;; (display-battery-mode) ;; is it updating correctly?
;; (column-number-mode)

;; todo -- couldn't get this to eval (mine-font) correctly inline
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

;; display settings

(defun mine-use-small-font ()
  (interactive)
  (set-frame-parameter (selected-frame) 'font mine-small-font)
  (add-to-list 'default-frame-alist (cons 'font mine-small-font)))

(defun mine-use-normal-font ()
  (interactive)
  (set-frame-parameter (selected-frame) 'font mine-normal-font)
  (add-to-list 'default-frame-alist (cons 'font mine-normal-font)))

(defun mine-use-big-font ()
  (interactive)
  (set-frame-parameter (selected-frame) 'font mine-big-font)
  (add-to-list 'default-frame-alist (cons 'font mine-big-font)))

(defun mine-set-font-size (size)
  (interactive "sSize: ")
  (let ((font (concat "Monaco " size)))
    (set-frame-parameter (selected-frame) 'font font)
    (add-to-list 'default-frame-alist (cons 'font font))))

(defun mine-toggle-fullscreen ()
  (interactive)
  (if (frame-parameter (selected-frame) 'fullscreen)
      (set-frame-parameter (selected-frame) 'fullscreen nil)
      (set-frame-parameter (selected-frame) 'fullscreen 'fullboth)))

(defun mine-use-transparency ()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha '(80 60))
  (add-to-list 'default-frame-alist '(alpha 80 60)))

(defun mine-use-no-transparency ()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha '(100 100))
  (add-to-list 'default-frame-alist '(alpha 100 100)))

(defun mine-toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (find 'alpha (frame-parameters nil) :key #'car))
       100)
      (mine-use-transparency)
    (mine-use-no-transparency)))

(if (functionp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(defun mine-set-transparency (value)
  (interactive "nTransparency Value 0 (fully transparent) - 100 (no transparency): ")
  (set-frame-parameter (selected-frame) 'alpha value))

(defun mine-normal-display ()
  (interactive)
  (mine-use-normal-font)
  (mine-use-transparency))

(defun mine-pair-display ()
  (interactive)
  (mine-use-big-font)
  (mine-use-transparency))

(mine-normal-display)

(provide 'mine-pretty)
