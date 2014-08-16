(defcustom json-validate-display-buffer-name "*json*"
  "Name of json response buffer.")

(defun json-validate ()
  "Validates the region or buffer of json."
  (interactive)
  (if (use-region-p)
      (json-validate-region)
    (json-validate-buffer)))

(defun json-validate-buffer ()
  "Validates the buffer of json."
  (interactive)
  (json-validate-for-errors (buffer-substring (point-min) (point-max))))

(defun json-validate-region ()
  "Validates a region of json."
  (interactive)
  (json-validate-for-errors (buffer-substring (mark) (point))))

(defun json-validate-string (json)
  "Validates a provided string of json."
  (interactive "sJson to validate: ")
  (json-validate-for-errors json))

(defun json-format ()
  "Formats the region or buffer of json."
  (interactive)
  (if (use-region-p)
      (json-format-region)
    (json-format-buffer)))

(defun json-format-buffer ()
  "Formats a buffer of json, printing syntax errors if found."
  (interactive)
  (let ((response (json-reformat (buffer-substring (point-min) (point-max)))))
    (if (json-good-response response)
        (json-insert-in-current-buffer response (point-min) (point-max))
      (message response))))

(defun json-format-region ()
  "Formats a region of json, printing syntax errors if found."
  (interactive)
  (let ((response (json-reformat (buffer-substring (mark) (point)))))
    (if (json-good-response response)
        (json-insert-in-current-buffer response (mark) (point))
      (message response))))

(defun json-format-string (json)
  "Formats and displays a json string, printing syntax errors if found."
  (interactive "sJson to display (formatted): ")
  (let ((response (json-reformat json)))
    (if (json-good-response response)
        (json-insert-in-json-buffer response)
      (message response))))

(defun json-validate-for-errors (json)
  (let ((response (shell-command-to-string (format "echo '%s' | python -mjson.tool" json))))
    (if (json-good-response response)
        (message "No errors found.")
      (message response))))

(defun json-reformat (json)
  (shell-command-to-string (format "echo '%s' | python -mjson.tool" json)))

(defun json-good-response (response)
  (string-equal (substring response 0 1) "{"))

(defun json-insert-in-current-buffer (json start end)
  (delete-region start end)
  (insert json))

(defun json-insert-in-json-buffer (json)
  (json-get-new-json-buffer)
  (insert json))

(defun json-get-new-json-buffer ()
  (if (get-buffer json-validate-display-buffer-name)
      (kill-buffer json-validate-display-buffer-name))
  (set-buffer (get-buffer-create json-validate-display-buffer-name))
  (setq-default major-mode 'js-mode)
  (set-buffer-major-mode (current-buffer))
  (switch-to-buffer-other-window (current-buffer)))

(provide 'mine-json)
