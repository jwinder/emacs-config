(setq mine-dir "~/.emacs.d/mine/")
(if (file-exists-p mine-dir)
 (let ((custom-files (directory-files mine-dir t "\.el$")))
  (mapcar 'load-file custom-files)))

(setq mine-custom-dir "~/.emacs.d/custom/")
(if (file-exists-p mine-custom-dir)
 (let ((custom-files (directory-files mine-custom-dir t "\.el$")))
  (mapcar 'load-file custom-files)))

(setq custom-file (expand-file-name "~/.emacs.d/customizations.el"))
(load custom-file)

(cd (getenv "HOME"))
(mine-normal-display)

(server-start)
(put 'dired-find-alternate-file 'disabled nil)

(put 'ido-exit-minibuffer 'disabled nil)
