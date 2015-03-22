(require 'comint)

(defun jw--font-name (&optional size)
  (if size
      (concat "Monaco " size)
    "Monaco"))

(defun jw--trim-string (string)
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun jw--read-file-lines-to-string (file)
  (with-temp-buffer
    (insert-file-contents file)
    (split-string (buffer-string) "\n" t)))

(defun jw--make-uuid ()
  (downcase (shell-command-to-string "uuidgen | tr -d '\n'")))

(defun jw--rubbish--make-sql-process (product sql-user sql-password sql-server sql-database root-sql-script-dir)
  (let* ((sql-text-buffer (find-file (concat root-sql-script-dir sql-database "_" sql-server ".sql")))
         (new-name (concat sql-user "@" sql-database "." sql-server))
         (sqli-buffer (if sql-buffer (progn (split-window) sql-buffer) (sql-product-interactive product new-name))))
    (switch-to-buffer sql-text-buffer nil t)
    (set (make-local-variable 'sql-buffer) sqli-buffer)
    (switch-to-buffer sqli-buffer nil t)
    (sql-send-string "\\x")))

(defun jw--rubbish--command-line-tool (command &optional initial-args history history-symbol in-named-directory)
  (let* ((rest-of-command (read-from-minibuffer (concat command " ") (or initial-args (car history)) nil nil history-symbol))
         (command-with-args (append (split-string command) (split-string rest-of-command)))
         (args (cdr command-with-args))
         (command (car command-with-args))
         (name (mapconcat 'identity command-with-args " "))
         (buffer-name (concat "*" name (if in-named-directory (concat " <" in-named-directory ">")) "*"))
         (buffer (get-buffer-create buffer-name)))
    (switch-to-buffer buffer)
    (apply 'make-comint-in-buffer name buffer command nil args)))

(provide 'jw-lib)
