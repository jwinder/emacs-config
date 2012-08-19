(add-to-list 'load-path "~/.emacs.d/mine")

(require 'mine-env)
(require 'mine-builtin) ;; split up
(require 'mine-defuns)
(require 'mine-advice)
(require 'mine-bindings)
(require 'mine-desktop)
(require 'mine-pretty)
(require 'mine-pkgmgt)

;; load files under custom/*.el
(let ((custom-files (directory-files "~/.emacs.d/custom/" t "\.el$")))
 (mapcar 'load-file custom-files))

(setq custom-file (expand-file-name "~/.emacs.d/customizations.el"))
(load custom-file)

(cd (getenv "HOME"))
(mine-normal-display)

(display-time)
(display-battery-mode)
(column-number-mode)
(toggle-case-fold-search)
(mine-use-transparency) ;; needed for separate emacs clients starting up transparent

(server-start)
(put 'dired-find-alternate-file 'disabled nil)

;; (mine-irc-login)
