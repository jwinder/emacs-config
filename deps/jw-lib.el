(require 'comint)

(defun jw--trim-string (string)
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun jw--read-file-lines-to-string (file)
  (with-temp-buffer
    (insert-file-contents file)
    (split-string (buffer-string) "\n" t)))

(defun jw--make-uuid ()
  (downcase (shell-command-to-string "uuidgen | tr -d '\n'")))

(defun jw--make-sql-process (product sql-user sql-password sql-server sql-database root-sql-script-dir)
  (let* ((sql-text-buffer (find-file (concat root-sql-script-dir sql-database "_" sql-server ".sql")))
         (new-name (concat sql-user "@" sql-database "." sql-server))
         (sqli-buffer (if sql-buffer (progn (split-window) sql-buffer) (sql-product-interactive product new-name))))
    (switch-to-buffer sql-text-buffer nil t)
    (set (make-local-variable 'sql-buffer) sqli-buffer)
    (switch-to-buffer sqli-buffer nil t)
    (sql-send-string "\\x")))

(defun jw--make-ssh-tunnel-process (host command &optional ssh-username)
  (let* ((process-name (format "%s <%s>" command host))
         (buffer-name (format "*%s*" process-name))
         (buffer (get-buffer-create buffer-name))
         (login (if ssh-username
                    (concat ssh-username "@" host)
                  host))
         (tunnel-args (list "-t" login command)))
    (apply 'make-comint-in-buffer process-name buffer "ssh" nil tunnel-args)
    (switch-to-buffer buffer)))

(provide 'jw-lib)
