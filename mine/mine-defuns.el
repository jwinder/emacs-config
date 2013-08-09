(defun beginning-of-line-or-back-to-indention ()
  (interactive)
  "This goes to back to indention or if already there beginning of line"
  (let ((previous-point (point)))
    (back-to-indentation)
    (if (equal previous-point (point))
	(beginning-of-line))))

(defun kill-to-end-or-join ()
  (interactive)
  "This will either kill to the end of the line or if already there join it with the next line"
  (if (equal (point) (point-at-eol))
      (save-excursion
	(next-line)
	(delete-indentation)
	)
    (kill-line)))

(defun kill-to-end-of-line-yank-newline ()
  (interactive)
  (let ((beg (line-beginning-position)) (end (line-end-position)) (name (buffer-name)) (col (current-column)))
    (end-of-line)
    (newline)
    (beginning-of-line)
    (insert-buffer-substring name beg end)
    (move-to-column col t)
    (unless (eolp) (kill-sexp))))

(defun open-line-and-indent ()
  (interactive)
  "Opens a line and and indents"
  (newline-and-indent)
  (previous-line)
  (indent-for-tab-command))

(defun newline-and-indent-open-line-and-indent ()
  (interactive)
  "Newlines, indents, then opens a line and indents"
  (newline-and-indent)
  (open-line-and-indent))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun clear-unit-test-from-mode-line ()
  (interactive)
  (mapcar (lambda (buffer)
            (with-current-buffer buffer
              (show-test-none)))
          (remove-if 'minibufferp (buffer-list))))

(defun move-to-pending ()
  "Moves marked files in dired buffer to pending and creates pending links for them in the inbox.org file"
  (interactive)
  (dolist (file-to-move (mapcar (function car) (dired-map-over-marks
                                                (cons (dired-get-filename) (point)) nil)))
    (let ((file-name (file-name-nondirectory file-to-move))
          (org-capture-link-is-already-stored t))
      (message "Moving file %s to pending" file-name)
      (org-store-link-props :annotation (org-make-link-string (concat "pending:" file-name) file-name))
      (org-capture nil "l")
      (rename-file file-to-move (concat "~/Desktop/Pending/" file-name) t)))
  (revert-buffer))

(defun move-marked-dired-files (destination-dir)
  (dolist (file-to-move (mapcar (function car) (dired-map-over-marks
                                                (cons (dired-get-filename) (point)) nil)))
    (let ((file-name (file-name-nondirectory file-to-move)))
      (message "Moving file %s to %s" file-name destination-dir)
      (rename-file file-to-move (concat destination-dir file-name) t)))
  (revert-buffer))

(defun move-to-documents ()
  (interactive)
  (move-marked-dired-files "~/Documents/"))

(defun move-to-private ()
  (interactive)
  (move-marked-dired-files "~/Private/"))

(defun dired-reveal (file)
  "Reveals the file inside of a dired buffer"
  (let* ((full-file (expand-file-name file))
         (dir (file-name-directory full-file)))
    (dired dir)
    (dired-goto-file full-file)))

(defun dired-mac-open ()
  "Invoke xdg-open on the file at point"
  (interactive)
  (call-process "open" nil 0 nil (expand-file-name (dired-file-name-at-point))))

(defun dired-xdg-open ()
  "Invoke xdg-open on the file at point"
  (interactive)
  (call-process "xdg-open" nil 0 nil (expand-file-name (dired-file-name-at-point))))

(defun dired-external-open ()
  "Opens the file at point in an external viewer"
  (interactive)
  (case system-type
    ('darwin (dired-mac-open))
    ('gnu/linux (dired-xdg-open))))

(defun switch-to-other-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

(defun kill-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
	  (buffer-list))
  (delete-other-windows))

(defun swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((/= (count-windows) 2)
         (message "You need exactly 2 windows to do this."))
        (t
         (let* ((w1 (first (window-list)))
                (w2 (second (window-list)))
                (b1 (window-buffer w1))
                (b2 (window-buffer w2))
                (s1 (window-start w1))
                (s2 (window-start w2)))
           (set-window-buffer w1 b2)
           (set-window-buffer w2 b1)
           (set-window-start w1 s2)
           (set-window-start w2 s1))))
  (other-window 1))

(defun toggle-window-split ()
  "Vertical split shows more of each line, horizontal split shows
more lines. This code toggles between them. It only works for
frames with exactly two windows."
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

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer-safe (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (let ((new-filename (concat (file-name-directory filename) new-name)))
        (progn
          (rename-file filename new-filename 1)
          (rename-buffer new-name 'unique)
          (set-visited-file-name new-filename)
          (set-buffer-modified-p nil))))))

(defun mine-sql (product sql-user sql-password sql-server sql-database root-sql-script-dir)
  (let* ((sql-text-buffer (find-file (concat root-sql-script-dir sql-database "_" sql-server ".sql")))
         (new-name (concat sql-user "@" sql-database "." sql-server))
         (sqli-buffer (if sql-buffer (progn (split-window) sql-buffer) (sql-product-interactive product new-name))))
    (switch-to-buffer sql-text-buffer nil t)
    (set (make-local-variable 'sql-buffer) sqli-buffer)
    (switch-to-buffer sqli-buffer nil t)))

(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defun get-eshell-create (shell-name &optional initial-command)
  (if (eq nil (get-buffer shell-name))
      (progn
        (mine-eshell-create)
        (rename-buffer shell-name)
        (if initial-command
            (progn
              (insert initial-command)
              (eshell-send-input))))
    (switch-to-buffer shell-name))
  (end-of-buffer))

;; (require 'comint)
;; (defcustom ssh-executable "ssh" "Where is ssh?")
;; (defun hbase-shell-ssh-tunnel (host &optional ssh-username)
;;   (let* ((buffer-name (format "*hbase shell %s*" host))
;;          (buffer (get-buffer-create buffer-name))
;;          (ssh-login (if ssh-username (format "%s@%s" ssh-username host) (host)))
;;          (args (list "-t" ssh-login "/usr/bin/hbase shell")))
;;     (apply 'make-comint-in-buffer buffer-name buffer ssh-executable nil args)
;;     (switch-to-buffer buffer)))

;; todo; change this to use comint-mode, not eshell

(defun hbase-shell-ssh-tunnel (host &optional ssh-username)
  (get-eshell-create
   (format "*hbase shell %s*" host)
   (format "ssh -t %s \"/usr/bin/hbase shell\"" (if ssh-username
                                                    (format "%s@%s" ssh-username host)
                                                  host))))

(defun ido-recentf-open ()
  "Use `ido-completing-read` to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(defun comint-clear-buffer-or-region ()
  (interactive)
  (delete-region (point-min) (point-max))
  (comint-send-input))

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(defun clear-buffer ()
  (interactive)
  (delete-region (point-min) (point-max)))

(defun pingg ()
  (interactive)
  (ping "google.com"))

(defun sudo ()
  (interactive)
  (find-file "/sudo:root@localhost:/"))

(require 'url)
(defun http-do (method url headers entity raw)
  (let* ((url-request-method method)
         (url-request-extra-headers headers)
         (url-request-data entity))
    (url-retrieve url 'http-handle-response)))

(defun http-handle-response (status)
  ;;(switch-to-buffer (current-buffer))
  ;;(message status)
  (message "Captured successfully.")
  )

;; using tramp to find/open a file as sudo
(defvar find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `find-file-root'.")
(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")
(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")
(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."
  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
	 ;; use a separate history list for "root" files.
	 (file-name-history find-file-root-history)
	 (name (or buffer-file-name default-directory))
	 (tramp (and (tramp-tramp-file-p name)
		     (tramp-dissect-file-name name)))
	 path dir file)
    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-localname tramp)
	    dir (file-name-directory path)))
    (when (setq file (read-file-name "Find file (sudo): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))

;; Function to compile current buffer (if it's a LESS file) to CSS, requires 'ruby-gem less'
(defun less-compile-css ()
  "Compile LESS to CSS"
  (interactive)
  (if (string-match "\.less$" (buffer-file-name))
      (async-shell-command (concat "lessc " (buffer-file-name) " > "
                                   (file-name-directory (directory-file-name (file-name-directory buffer-file-name)))
                                   "css/" (file-name-sans-extension (file-name-nondirectory buffer-file-name)) ".css") nil nil))
  (delete-other-windows))

(defun scratch-text ()
  "Get or create a text-mode scratch buffer."
  (interactive)
  (let ((scratch-buffer (get-buffer-create "*scratch*")))
    (switch-to-buffer scratch-buffer)
    (text-mode)))

(defun mine-rcirc-bury-buffers ()
  "Bury all rcirc-mode buffers."
  (interactive)
  (save-excursion)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (if (eq major-mode 'rcirc-mode)
          (bury-buffer buffer)))))

(defun mine-rcirc-next-active-buffer-bury-rcirc-buffers (arg)
  "Switch to the next rcirc buffer with activity, burying all rcirc buffers after returning to a non-rcirc buffer.
With prefix ARG, go to the next low priority buffer with activity."
  (interactive "P")
  (rcirc-next-active-buffer arg)
  (unless (eq major-mode 'rcirc-mode)
    (mine-rcirc-bury-buffers)))

(defun mine-rcirc-shut-up ()
  (interactive)
  (rcirc-track-minor-mode -1)
  (remq 'rcirc-activity-string global-mode-string))

;; (defun bundle-cmd-shell (cmd)
;;   (interactive "sbundle ")
;;   (let* ((directory (locate-dominating-file default-directory "Gemfile")))
;;     (if directory
;;         (progn
;;           (cd directory)
;;           (get-eshell-create (format "*bundle <%s>*" directory))
;;           (insert "bundle " cmd)
;;           (eshell-send-input))
;;       (message "Cannot find project root containing Gemfile."))))

(defun bundle (cmd)
  (interactive "sbundle ")
  (require 'comint)
  (let* ((directory (locate-dominating-file default-directory "Gemfile"))
         (name (format "bundle <%s>" directory))
         (buffer-name (format "*%s*" name))
         (buffer (get-buffer-create buffer-name)))
    (if directory
        (progn
          (cd directory)
          (apply 'make-comint-in-buffer name buffer "bundle" nil (split-string cmd))
          (switch-to-buffer buffer)
          )
      (message "Cannot find project root containing Gemfile."))
    ))

;; todo; use kitchen list to be able to interactively choose which vm to start with a converge

(defun kitchen-list ()
  (interactive)
  (bundle "exec kitchen list"))

(defun kitchen-converge ()
  (interactive)
  (bundle "exec kitchen converge"))

(defun kitchen-destroy ()
  (interactive)
  (bundle "exec kitchen destroy"))

(defun bundle-install ()
  (interactive)
  (bundle "install"))

(defun bundle-install-pick-gemfile (gemfile)
  (interactive "FGemfile: ")
  (bundle (concat "install --gemfile=" (car (last (split-string gemfile "/"))))))

(defun bundle-rspec ()
  (interactive)
  (bundle "exec rspec"))

(defun bundle-guard ()
  (interactive)
  (bundle "exec guard"))

(defun google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                         (read-string "Google: "))))))

(defun rubbish-emacs-setup ()
  (interactive)
  (browse-url "https://github.com/rubbish/rubbish-emacs-setup"))

;; todo; change http-do to handle GET responses & use that for these, not curl
(defun ifconfig.me ()
  "Curls ifconfig.me for external IP"
  (interactive)
  ;;(http-do "GET" "http://ifconfig.me/ip" nil "" "not needed")
  ;;(kill-new (shell-command-to-string "curl ifconfig.me/ip"))
  (shell-command "curl ifconfig.me")
  )

(defun ifconfig.me/all ()
  (interactive)
  (shell-command "curl ifconfig.me/all"))

(defun ssh-copy-id (username host)
  (interactive "sUsername: \nsHost: ")
  (shell-command (format "ssh-copy-id %s@%s" username host)))

(defun trim-string (string)
  (interactive "sString: ")
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun uuid ()
  "Generates a new uuid."
  (interactive)
  (let* ((uuid (trim-string (shell-command-to-string "uuidgen"))))
    (message "New uuid appened to kill ring: %s" uuid)
    (kill-new uuid)
    ))

(defun uuid-insert ()
  "Generates and inserts a new uuid."
  (interactive)
  (insert (trim-string (shell-command-to-string "uuidgen"))))

(defun mine-increment-decimal (&optional arg)
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

(defun mine-decrement-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))

(provide 'mine-defuns)
