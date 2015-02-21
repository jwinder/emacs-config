(defun jw-config-insert-author ()
  (interactive)
  (insert jw-config-author-name))

(defun jw-config-goto-homepage ()
  (interactive)
  (browse-url jw-config-author-url))

(defun jw-config-goto-github ()
  (interactive)
  (browse-url jw-config-github-url))
