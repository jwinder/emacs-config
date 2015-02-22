(defun jw--trim-string (string)
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun jw--read-file-lines-to-string (file)
  (with-temp-buffer
    (insert-file-contents file)
    (split-string (buffer-string) "\n" t)))

(defun jw--make-uuid ()
	(downcase (shell-command-to-string "uuidgen | tr -d '\n'")))

(provide 'jw-lib)
