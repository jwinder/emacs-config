(require 'comint)
(eval-when-compile (require 'em-hist))  ;; for eshell-history-file-name

(defun jw--font-name (&optional size)
  (if size (concat "Monaco " size) "Monaco"))

(defun jw--trim-string (string)
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun jw--read-file-lines-to-string (file)
  (with-temp-buffer
    (insert-file-contents file)
    (split-string (buffer-string) "\n" t)))

(defun jw--make-uuid ()
  (downcase (shell-command-to-string "uuidgen | tr -d '\n'")))

(defun jw--pwd ()
  default-directory)

(defun jw--make-sql-process (product sql-user sql-password sql-server sql-database root-sql-script-dir)
  "Inspired by rubbish's `sql' function."
  (let* ((sql-text-buffer (find-file (concat root-sql-script-dir sql-database "_" sql-server ".sql")))
         (new-name (concat sql-user "@" sql-database "." sql-server))
         (sqli-buffer (if sql-buffer (progn (split-window) sql-buffer) (sql-product-interactive product new-name))))
    (switch-to-buffer sql-text-buffer nil t)
    (set (make-local-variable 'sql-buffer) sqli-buffer)
    (switch-to-buffer sqli-buffer nil t)
    (sql-send-string "\\x")))

(defun jw--make-cmd-line-process (&optional command args)
  "Inspired by rubbish's `command-line-tool' function but uses eshell's history file and completing-read which helm enriches."
  (let* ((history (reverse (jw--read-file-lines-to-string eshell-history-file-name)))
         (full-command (completing-read "Command: " history nil nil (if command (concat command " " (or args "")) "")))
         (full-command-tokens (split-string full-command))
         (command-name (car full-command-tokens))
         (command-args (cdr full-command-tokens))
         (buffer-name (concat "*" full-command "*"))
         (buffer (get-buffer-create buffer-name)))
    (if command-name
        (progn (write-region (concat full-command "\n") nil eshell-history-file-name 'append 1)
               (switch-to-buffer buffer)
               (apply 'make-comint-in-buffer full-command buffer command-name nil command-args))
      (message "Empty command name. Did nothing."))))

(provide 'jw-lib)
