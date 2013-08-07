;; ido-mode
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-default-file-method 'selected-window
      ido-default-buffer-method 'selected-window)

;; ido setup
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10
      ido-show-dot-for-dired nil)

;; inf-ruby-key renamed, this should not be needed
(defun inf-ruby-setup-keybindings ()
  (interactive)
  (require 'inf-ruby)
  (inf-ruby-keys))

;; using cookies in w3m
(setq w3m-use-cookies t)

;; use uniquify
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; tramp remote sudo
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

(require 'recentf)
(recentf-mode t)
(setq recentf-max-saved-items 50)

(winner-mode t)

;; Setup Environmental Variables
(setq default-major-mode 'text-mode)
(setq inhibit-startup-message t)

;; Auto revert files
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode t)

;; Buffer selection setup
(setq bs-configurations
      '(("all" nil nil nil nil nil)
        ("files" nil nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)
        ("rcirc" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (eq major-mode 'rcirc-mode)))) nil)
        ("dired" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (eq major-mode 'dired-mode)))) nil)
        ("eshell" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (eq major-mode 'eshell-mode)))) nil)
        ("magit" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (eq major-mode 'magit-mode)))) nil)
        ("sbt" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (string-prefix-p "*sbt:" (buffer-name buf))))) nil)
        ("sql" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (and
              (not (eq major-mode 'sql-mode))
              (not (eq major-mode 'sql-interactive-mode))))) nil)))

(setq bs-mode-font-lock-keywords
  (list
   ; Headers
   (list "^[ ]+\\([-M].*\\)$" 1 font-lock-keyword-face)
   ; Boring buffers
   (list "^\\(.*\\*.*\\*.*\\)$" 1 font-lock-comment-face)
   ; Dired buffers
   '("^[ .*%]+\\(Dired.*\\)$" 1 font-lock-type-face)
   ; Modified buffers
   '("^[ .]+\\(\\*\\)" 1 font-lock-warning-face)
   ; Read-only buffers
   '("^[ .*]+\\(\\%\\)" 1 font-lock-variable-name-face)))

;; Always use subwords to to move around
(if (fboundp 'subword-mode)
    (subword-mode t)
  (c-subword-mode t))

(require 'dired-x)
(add-hook 'dired-load-hook
          (lambda ()
            (define-key dired-mode-map (kbd "M-RET") 'dired-external-open)))

(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Create non-existent directories containing a new file before saving
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

;; Use soft tabs
(setq-default indent-tabs-mode nil)

;; Don't make backups
(setq make-backup-files nil)
(setq version-control nil)

;; Allow to be able to select text and start typing or delete
(delete-selection-mode t)

;; delete trailing whitespace on save
(setq mine-delete-trailing-whitespace t)
(defun mine-leave-whitespace-in-buffer ()
  (interactive)
  (make-variable-buffer-local 'mine-leave-whitespace)
  (setq mine-delete-trailing-whitespace nil))
(add-hook 'before-save-hook '(lambda () (if mine-delete-trailing-whitespace (delete-trailing-whitespace))))

;; auto indentation of yanked/pasted text
(setq major-modes-to-auto-indent-yanked-text '(emacs-lisp-mode
                                               clojure-mode
                                               c-mode
                                               c++-mode
                                               objc-mode
                                               scala-code
                                               ruby-mode))

(defun yank-and-indent ()
  (interactive)
  (yank)
  (call-interactively 'indent-region))

;; Misc Aliases
(defalias 'qrr 'query-replace-regexp)
(defalias 'scala 'scala-run-scala)
(defalias 'elisp-shell 'ielm)
(defalias 'colors 'list-colors-display)
(defalias 'buffers 'bs-show)
(defalias 'git 'magit-status)
(defalias 'web 'w3m)
(defalias 'ps 'proced)

;; dired things
(add-hook 'dired-mode-hook '(lambda ()
                              (local-set-key (kbd "C-x R") 'wdired-change-to-wdired-mode)))
(defalias 'wdired 'wdired-change-to-wdired-mode)

;; Midnight mode to clean up old buffers
(require 'midnight)

(add-hook 'emacs-lisp-mode-hook '(lambda () (eldoc-mode t)))

;; Miscallaneous Things
(if (fboundp 'mouse-wheel-mode) (mouse-wheel-mode t))
(setq visible-bell t)

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; Backups
(setq version-control nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

;; Protobuf files are like c
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.proto\\'" . c-mode))

;; auto revert logs by tail
;; (add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))

;; custom battery info
(setq display-time-format "(%I:%M%p %A %B %d %Y) ")
(setq display-time-mail-file -1)
(setq display-time-default-load-average nil)

(setq battery-mode-line-format "(%p %B) ")
(setq battery-echo-area-format "Battery: %p%% %B")
(setq battery-update-interval 10)

(add-hook 'window-configuration-change-hook
          '(lambda ()
             (setq rcirc-fill-column (- (window-width) 2))))

;; viewing gists in browse-url after gisting
(setq gist-view-gist t)

;; pop-to-buffer to split horizontally rather than vertically
(setq split-width-threshold nil)

;; rcirc things

;; (defun mine-rcirc-message (message)
;;   (interactive "i")
;;   (rcirc-cmd-msg message))

;; (defun-rcirc-command msg (message)
;;   "Send private MESSAGE to TARGET."
;;   (interactive "i")
;;   (if (null message)
;;       (progn
;;         (setq target (completing-read "Message nick: "
;;                                       (with-rcirc-server-buffer
;; 					rcirc-nick-table)))
;;         (when (> (length target) 0)
;;           (setq message (read-string (format "Message %s: " target)))
;;           (when (> (length message) 0)
;;             (rcirc-send-message process target message))))
;;     (if (not (string-match "\\([^ ]+\\) \\(.+\\)" message))
;;         (message "Not enough args, or something.")
;;       (setq target (match-string 1 message)
;;             message (match-string 2 message))
;;       (rcirc-send-message process target message))))

(custom-set-faces
 '(rcirc-my-nick ((t (:foreground "#00ffff"))))
 '(rcirc-other-nick ((t (:foreground "#90ee90"))))
 '(rcirc-server ((t (:foreground "#a2b5cd"))))
 '(rcirc-server-prefix ((t (:foreground "#00bfff"))))
 '(rcirc-timestamp ((t (:foreground "#7d7d7d"))))
 '(rcirc-nick-in-message ((t (:foreground "#00ffff"))))
 '(rcirc-prompt ((t (:foreground "#00bfff")))))

(add-hook 'rcirc-mode-hook 'turn-on-flyspell)
(add-hook 'rcirc-mode-hook (lambda () (rcirc-track-minor-mode t)))

(setq rcirc-notify-message "%s: %s"
      rcirc-buffer-maximum-lines 2000)

(toggle-case-fold-search)

(provide 'mine-builtin)
