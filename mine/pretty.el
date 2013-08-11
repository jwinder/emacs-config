(require 'ansi-color)
(ansi-color-for-comint-mode-on)

(show-paren-mode t)
(transient-mark-mode t)
(blink-cursor-mode t)

;; Remove noise
;; (global-hl-line-mode t)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(defvar mine-small-font "Monaco 11" "*The small font")
(defvar mine-normal-font "Monaco 13" "*The main font")
(defvar mine-big-font "Monaco 20" "*The big font")

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

(display-time)
(display-battery-mode)
(column-number-mode)
(mine-use-transparency) ;; needed for separate emacs clients starting up transparent