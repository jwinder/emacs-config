(require 'json-reformat)

(setq js-indent-level 2)

(defun json-prettify ()
  (interactive)
  (if (region-active-p)
      (json-reformat-region (region-beginning) (region-end))
    (json-reformat-region (point-min) (point-max))))

(defalias 'json-format 'json-prettify)

(provide 'mine-json)
