(ansi-color-for-comint-mode-on)

(fset 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil
      version-control nil
      create-lockfiles nil)

(global-auto-revert-mode 1)

(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

(setq-default indent-tabs-mode nil)

(setq default-tab-width 2)

(setq js-indent-level 2)

(delete-selection-mode t)

(winner-mode t)

(global-subword-mode t)

(setq default-major-mode 'text-mode)

(put 'dired-find-alternate-file 'disabled nil)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'next-error-hook 'delete-other-windows)

(setq uniquify-buffer-name-style 'forward)

(setq ring-bell-function 'ignore)

(setq enable-recursive-minibuffers t)

(setq tramp-default-method "scp")

(setq eshell-buffer-shorthand t)

(add-to-list 'auto-mode-alist '("\\.proto$" . c-mode))

(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(setq git-commit-summary-max-length 150)

(put 'temporary-file-directory 'standard-value '((file-name-as-directory "/tmp")))
