(defun spotify-pause ()
  (interactive)
  (spotify-cmd "playpause"))

(defun spotify-previous ()
  (interactive)
  (spotify-cmd "previous track"))

(defun spotify-next ()
  (interactive)
  (spotify-cmd "next track"))

(defun spotify-cmd (cmd)
  (interactive "sCommand: ")
  (ns-do-applescript (format "tell application \"Spotify\" to %s" cmd)))

(global-unset-key (kbd "C-x m"))
(global-set-key (kbd "C-x m p") 'spotify-pause)
(global-set-key (kbd "C-x m r") 'spotify-previous)
(global-set-key (kbd "C-x m n") 'spotify-next)
