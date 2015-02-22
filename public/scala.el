(defun sbt-current-test-in-buffer ()
  (save-excursion
    (goto-char (point-min))
    (let* ((pkg-name (progn
                       (re-search-forward "package ")
                       (filter-buffer-substring (point) (point-at-eol))))
           (test-name (progn
                        (re-search-forward "\\(object\\|class\\) ")
                        (filter-buffer-substring
                         (point)
                         (progn
                           (re-search-forward " ")
                           (forward-char -1)
                           (point))))))
      (concat pkg-name "." test-name))))

(defun sbt-test-only-current-test ()
  "Run test-only for the test in the current buffer"
  (interactive)
  (sbt-command (concat "test-only " (sbt-current-test-in-buffer))))

(setq scala-indent:align-forms t
			scala-indent:align-parameters t)

(add-hook 'scala-mode-hook
					'(lambda ()
						 (local-set-key (kbd "C-c s s") 'sbt-start)
						 (local-set-key (kbd "C-c s o") 'sbt-test-only-current-test)))

(add-hook 'sbt-mode-hook
					'(lambda ()
						 (setq compilation-skip-threshold 1)))
