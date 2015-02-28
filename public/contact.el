(defun config-insert-author ()
  (interactive)
  (insert jw-config-author-name))

(defun config-goto-homepage ()
  (interactive)
  (browse-url jw-config-author-url))

(defun config-goto-github ()
  (interactive)
  (browse-url jw-config-github-url))

(defun adamdecaf-config-goto-github ()
  (interactive)
  (browse-url adamdecaf-config-github-url))

(defun knuckolls-config-goto-github ()
  (interactive)
  (browse-url knuckolls-config-github-url))

(defun rubbish-config-goto-github ()
  (interactive)
  (browse-url rubbish-config-github-url))
