(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist (cons 'font "Monaco 14"))

(custom-set-faces '(mode-line ((t (:family "Monaco" :background nil :foreground "#66ff33" :box nil))))
                  '(mode-line-inactive ((t (:family "Monaco" :background nil :foreground "gray" :box nil))))
                  '(mode-line-buffer-id ((t :family "Monaco" :background nil :foreground "#7db5d6"))))

(setq-default mode-line-format '(" ✔ " mode-line-buffer-identification))
