(defun jw--load (dir)
  (let ((path (concat user-emacs-directory dir)))
    (when (file-exists-p path)
      (add-to-list 'load-path path)
      (mapcar 'load-file (sort (directory-files path t "\.el$") 'jw--load-files-lessp)))))

;; predicate which gives init.el files precedence
(defun jw--load-files-lessp (filename1 filename2)
  (if (string-match "init\.el$" filename1) t
    (string-lessp filename1 filename2)))

(defun jw--pre-configure ())

(defun jw--configure ()
  (jw--load "deps")
  (jw--load "internals")
  (jw--load "public")
  (jw--load "private"))

(defun jw--post-configure ()
  (cd (getenv "HOME"))
  (toggle-fullscreen)
  (server-start))

(jw--pre-configure)
(jw--configure)
(jw--post-configure)
