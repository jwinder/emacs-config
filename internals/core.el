(ansi-color-for-comint-mode-on)

(fset 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil
      version-control nil
      create-lockfiles nil)

(delete-selection-mode t)

;; todo -- delete trailing whitespace

(winner-mode t)

(setq default-major-mode 'text-mode)

(put 'dired-find-alternate-file 'disabled nil)

;; uniquify?

(server-start)
