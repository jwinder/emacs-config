(eval-when-compile (require 'cl))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2)))))

(setq echo-area-silenced-patterns
      '("Auto saving"
        "No changes need to be saved"
        "You can run the command"
        "Shell command succeeded with no output"))

(defadvice message (before ignorable-message activate compile)
  "Do not echo any messages matching a pattern in `echo-area-silenced-patterns'. This only works for elisp `message' and not the C primitive."
  (when format-string
    (let ((current-echo (current-message))
          (incoming-echo (apply 'format (cons format-string args))))
      (when (member-if '(lambda (pattern) (search pattern incoming-echo)) echo-area-silenced-patterns)
        (ad-set-arg 0 current-echo)))))
