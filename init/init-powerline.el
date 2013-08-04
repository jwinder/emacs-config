(defun set-mode-bar-colors ()
  (interactive)
  (set-face-background 'mode-line "#483d8b")
  (set-face-foreground 'mode-line "#dcdcdc")
  (set-face-background 'powerline-active1 "#191970")
  (set-face-foreground 'powerline-active1 "#dcdcdc")
  (set-face-background 'powerline-active2 "#1a1a1a")
  (set-face-foreground 'powerline-active2 "#dcdcdc")

  (set-face-background 'mode-line-inactive "#1a1a1a")
  (set-face-foreground 'mode-line-inactive "#000000")
  (set-face-background 'powerline-inactive1 "#333333")
  (set-face-foreground 'powerline-inactive1 "#000000")
  (set-face-background 'powerline-inactive2 "#1a1a1a")
  (set-face-foreground 'powerline-inactive2 "#000000")
  )

(set-mode-bar-colors)

(setq-default mode-line-format
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
