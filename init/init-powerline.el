(defun set-mode-line-colors ()
  (interactive)
  (custom-set-faces
   '(mode-line ((t (:foreground "#dcdcdc" :background "#483d8b"))))
   '(mode-line-buffer-id ((t (:weight bold :inheret region :foreground unspecified :background unspecified))))
   '(powerline-active1 ((t (:foreground "#dcdcdc" :background "#191970"))))
   '(powerline-active2 ((t (:foreground "#dcdcdc" :background "#1a1a1a"))))
   '(mode-line-inactive ((t (:foreground "#000000" :background "#1a1a1a"))))
   '(powerline-inactive1 ((t (:foreground "#000000" :background "#333333"))))
   '(powerline-inactive2 ((t (:foreground "#000000" :background "#1a1a1a"))))))

(setq mine-mode-line-format
      '("%e"
        (:eval
         (let* ((active (powerline-selected-window-active))
                (face1 (if active 'powerline-active1
                         'powerline-inactive1))
                (face2 (if active 'powerline-active2
                         'powerline-inactive2))
                (lhs (list
                      (powerline-raw "%*" nil 'l)
                      (powerline-buffer-size nil 'l)
                      (powerline-buffer-id nil 'l)

                      (powerline-raw " ")
                      (powerline-arrow-right nil face1)

                      (when (boundp 'erc-modified-channels-object)
                        (powerline-raw erc-modified-channels-object
                                       face1 'l))

                      (powerline-major-mode face1 'l)
                      (powerline-process face1)
                      (powerline-minor-modes face1 'l)
                      (powerline-narrow face1 'l)

                      (powerline-raw " " face1)
                      (powerline-arrow-right face1 face2)

                      (powerline-vc face2)))
                (rhs (list
                      (powerline-raw global-mode-string face2 'r)

                      (powerline-arrow-left face2 face1)

                      (powerline-raw "%4l" face1 'r)
                      (powerline-raw ":" face1)
                      (powerline-raw "%3c" face1 'r)

                      (powerline-arrow-left face1 nil)
                      (powerline-raw " ")

                      (powerline-raw "%6p" nil 'r)

                      (powerline-hud face2 face1))))
           (concat
            (powerline-render lhs)
            (powerline-fill face2 (powerline-width rhs))
            (powerline-render rhs))))))

(defun mode-line-on ()
  "Turn on mode line in all buffers."
  (interactive)
  (setq-default mode-line-format mine-mode-line-format))

(defun mode-line-off ()
  "Turn off mode line in all buffers."
  (interactive)
  (setq-default mode-line-format nil))

(defun mode-line-reset ()
  "Reset mode line colors and turn on mode line."
  (interactive)
  (set-mode-line-colors)
  (mode-line-on))

(mode-line-reset)
