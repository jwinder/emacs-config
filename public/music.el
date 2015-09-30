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
(global-set-key (kbd "C-x m m") 'spotify-pause)
(global-set-key (kbd "C-x m SPC") 'spotify-pause)
(global-set-key (kbd "C-x m p") 'spotify-previous)
(global-set-key (kbd "C-x m n") 'spotify-next)

(defun sonic-pi-run ()
  (interactive)
  (let ((ruby (if (region-active-p)
                  (buffer-substring-no-properties (point) (mark))
                (buffer-substring-no-properties (point-min) (point-max)))))
    (shell-command (format "echo '%s' | sonic_pi" ruby))))

(defun sonic-pi-stop ()
  (interactive)
  (shell-command "sonic_pi stop"))

(global-set-key (kbd "C-x m r") 'sonic-pi-run)
(global-set-key (kbd "C-x m s") 'sonic-pi-stop)
