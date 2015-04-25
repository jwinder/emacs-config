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

(defun jw--quick-run-cmd-line-process (full-command &optional buffer-name just-toggle-back-if-current-buffer-matches before-buffer-process-creation-hook)
  "Just a nice wrapper around `make-comint-in-buffer'. If `buffer-name' already exists, this will just switch to it. if `just-toggle-back-if-current-buffer-matches' is `non-nil' then we just switch back to `(other-buffer)'."
  (if (and just-toggle-back-if-current-buffer-matches buffer-name (string= (buffer-name) buffer-name))
      (switch-to-buffer (other-buffer))
    (if (and buffer-name (get-buffer buffer-name))
        (switch-to-buffer buffer-name)
      (let* ((full-command-tokens (split-string full-command))
             (command-name (car full-command-tokens))
             (command-args (cdr full-command-tokens))
             (name-for-buffer (or buffer-name (concat "*" (jw--trim-string full-command) "*")))
             (buffer (get-buffer-create name-for-buffer)))
        (if command-name
            (progn
              (when before-buffer-process-creation-hook (funcall before-buffer-process-creation-hook))
              (switch-to-buffer buffer)
              (apply 'make-comint-in-buffer full-command buffer command-name nil command-args))
          (message "Empty command name! Did nothing."))))))

(defun jw--make-cmd-line-process (&optional command args)
  "Inspired by rubbish's `command-line-tool' function but uses eshell's history file and completing-read which helm enriches."
  (let* ((history (reverse (jw--read-file-lines-to-string eshell-history-file-name)))
         (full-command (completing-read "Command: " history nil nil (if command (concat command " " (or args "")) "")))
         (add-command-to-eshell-history #'(lambda () (write-region (concat full-command "\n") nil eshell-history-file-name 'append 1))))
    (jw--quick-run-cmd-line-process full-command nil nil add-command-to-eshell-history)))

(provide 'jw-lib)
