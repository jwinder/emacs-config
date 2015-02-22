(require 'jw-lib)

(setenv "EDITOR" "emacsclient")

;; opininated way of setting system properties
;; (you can have your shell rc file parse the same two files)

;; e.g., keep something like this in your private dir:

;; (require 'eshell)
;; (defun jw-env-set ()
;;   (interactive)
;;   (jw--env-set-vars "/path/to/vars-file)
;;   (jw--env-set-path "/path/to/path-file))
;; (jw-env-set)
;; (add-to-list 'eshell-mode-hook 'jw-env-set)

;; where vars-file looks like:

;; DROPBOX_HOME=$HOME/Dropbox
;; DRIVE_HOME=$HOME/GoogleDrive

;; and path-file looks like (will become PATH=$HOME/bin:/usr/local/bin:/usr/bin):

;; $HOME/bin
;; /usr/local/bin
;; /usr/bin

(defun jw--env-set-vars (vars-file)
  (dolist (line (jw--read-file-lines-to-string vars-file))
    (unless (= 0 (length line))
      (let* ((tokens (split-string line "="))
             (name (car tokens))
             (value-string (mapconcat 'identity (cdr tokens) "="))
             (value-env-vars-parsed (substitute-env-vars value-string)) ;; parse lines containing env vars

             (value (shell-command-to-string (format "echo %s" value-env-vars-parsed)))) ;; parse shell commands in lines
        (setenv name (jw--trim-string value))))))

(defun jw--env-set-path (path-file)
  (interactive)
  (let* ((path-list (mapcar 'substitute-env-vars (jw--read-file-lines-to-string path-file)))
         (path-str (mapconcat 'identity path-list ":")))
    (setq exec-path path-list)
    (setenv "PATH" path-str)
    (setq eshell-path-env path-str)))
