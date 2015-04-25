(setq inhibit-startup-message t)

(defun make-initial-hello-message ()
  (format "\
;; Welcome to %s version %s.
;; If you used my previous config, it is tagged 1.0.0.
;; Any questions? Email me at %s. -- %s

;; Here are some other emacs configs you might like more:
;; %s
;; %s
;; %s

;; Warning: This config is a buyer beware product.

" jw-config-github-url jw-config-version jw-config-author-email jw-config-author-name adamdecaf-config-github-url knuckolls-config-github-url rubbish-config-github-url))

(defun set-initial-scratch-message ()
  (setq initial-scratch-message (make-initial-hello-message)))

(set-initial-scratch-message)
