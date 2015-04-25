(defvar twitter-buffer-name "*twitter*")
(defvar twitter-cmd-line-client "rainbowstream")

(defun twitter ()
  "This starts a buffer with the `rainbowstream' process. I really like `rainbowstream', so I use that instead of `twittering-mode'."
  (interactive)
  (jw--quick-run-cmd-line-process twitter-cmd-line-client twitter-buffer-name t))

(global-set-key (kbd "C-c t") 'twitter)
