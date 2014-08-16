(setq ns-command-modifier 'meta)
(setq interprogram-paste-function 'x-selection-value)
(setq browse-url-browser-function 'browse-url-default-macosx-browser)
(setq ack-executable "ack")

(defun ns-raise-emacs ()
  (interactive)
  (ns-do-applescript "tell application \"Emacs\" to activate"))

(add-to-list 'after-make-frame-functions
             '(lambda (f)
                (if (display-graphic-p f) ;; is a graphical frame
                    (ns-raise-emacs))))

(defun ns-raise-chrome ()
  (interactive)
  (ns-do-applescript "tell application \"Google Chrome\" to activate"))

(provide 'mine-osx)
