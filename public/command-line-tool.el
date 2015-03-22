(defvar jw--rubbish--command-line-tool:cmd-history nil)

(defun cmd (name)
  (interactive "sCommand: ")
  (jw--rubbish--command-line-tool name nil jw--rubbish--command-line-tool:cmd-history 'jw--rubbish--command-line-tool:cmd-history))

(defvar jw--rubbish--command-line-tool:ssh-history nil)

(defun ssh (&optional args)
  (interactive)
  (jw--rubbish--command-line-tool "ssh" args jw--rubbish--command-line-tool:ssh-history 'jw--rubbish--command-line-tool:ssh-history))

(defvar jw--rubbish--command-line-tool:brew-history nil)

(defun brew ()
  (interactive)
  (jw--rubbish--command-line-tool "brew" nil jw--rubbish--command-line-tool:brew-history 'jw--rubbish--command-line-tool:brew-history))

(defvar jw--rubbish--command-line-tool:docker-history nil)

(defun docker ()
  (interactive)
  (jw--rubbish--command-line-tool "docker" nil jw--rubbish--command-line-tool:docker-history 'jw--rubbish--command-line-tool:docker-history))
