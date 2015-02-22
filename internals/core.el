(ansi-color-for-comint-mode-on)

(fset 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil
      version-control nil
      create-lockfiles nil)

(setq indent-tabs-mode nil
      default-tab-width 2)

(delete-selection-mode t)

;; todo -- delete trailing whitespace

(winner-mode t)

(setq default-major-mode 'text-mode)

(put 'dired-find-alternate-file 'disabled nil)

;; uniquify?

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(server-start)
