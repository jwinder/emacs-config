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
;;(let ((custom-files (directory-files "~/.emacs.d/custom/" t "\.el$")))
;;  (mapcar 'load-file custom-files))

;;(setq custom-file (expand-file-name "~/.emacs.d/customizations.el"))
;;(load custom-file)

(cd (getenv "HOME"))
(mine-normal-display)
(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-safe-themes (quote ("5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
