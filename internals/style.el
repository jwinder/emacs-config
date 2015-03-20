(require 'jw-lib)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(set-face-attribute 'default nil :font (jw--font-name "14"))

(custom-set-faces `(mode-line ((t (:family ,(jw--font-name) :background nil :foreground "#66ff33" :box nil))))
                  `(mode-line-inactive ((t (:family ,(jw--font-name) :background nil :foreground "gray" :box nil))))
                  `(mode-line-buffer-id ((t (:family ,(jw--font-name) :background nil :foreground "#7db5d6")))))

(setq-default mode-line-format '(" ✔ " mode-line-buffer-identification))
