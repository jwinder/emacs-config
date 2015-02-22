(require 'jw-lib)

(defalias 'qrr 'query-replace-regexp)
(defalias 'filter-lines 'keep-lines)
(defalias 'filter-out-lines 'flush-lines)
(defalias 'elisp-shell 'ielm)

(defalias 'count-lines-region 'count-words-region)
(defalias 'count-lines 'count-words)

(defun reload-emacs-config ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

(defun date ()
  (interactive)
  (message (current-time-string)))

(defalias 'time 'date)

(defun ping-google ()
  (interactive)
  (ping "google.com"))

(defun uuid ()
  (interactive)
  (insert (jw--make-uuid)))

(defun json-prettify ()
  (interactive)
  (if (region-active-p)
      (json-pretty-print (region-beginning) (region-end))
    (json-pretty-print-buffer)))

(defun hub-browse ()
  (interactive)
  (shell-command "hub browse"))

(defun increment-number (&optional arg)
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(defun decrement-number (&optional arg)
  (interactive "p*")
  (mine-increment-decimal (if arg (- arg) -1)))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
