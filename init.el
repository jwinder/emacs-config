(add-to-list 'load-path "~/.emacs.d/mine")

(require 'mine-env)
(require 'mine-builtin)
(require 'mine-defuns)
(require 'mine-advice)
(require 'mine-bindings)
(require 'mine-desktop)
(require 'mine-pretty)
(require 'mine-pkgmgt)
(require 'mine-eshell)
(require 'mine-org)
(require 'mine-irc)
(require 'mine-jabber)

(setq mine-custom-dir "~/.emacs.d/custom/")
(if (file-exists-p mine-custom-dir)
 (let ((custom-files (directory-files mine-custom-dir t "\.el$")))
  (mapcar 'load-file custom-files)))

(setq custom-file (expand-file-name "~/.emacs.d/customizations.el")) ;; todo put inside of custom
(load custom-file)

(cd (getenv "HOME"))
;; (mine-toggle-fullscreen)
(server-start)

(put 'dired-find-alternate-file 'disabled nil)
(put 'ido-exit-minibuffer 'disabled nil)
(put 'upcase-region 'disabled nil)
