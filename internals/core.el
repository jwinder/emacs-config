(ansi-color-for-comint-mode-on)

(fset 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil
      version-control nil
      create-lockfiles nil)

(setq-default indent-tabs-mode nil)
(setq default-tab-width 2)

(setq js-indent-level 2)

(delete-selection-mode t)

(winner-mode t)

(setq default-major-mode 'text-mode)

(setq gist-view-gist t)

(put 'dired-find-alternate-file 'disabled nil)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq uniquify-buffer-name-style 'forward)

(setq ring-bell-function 'ignore)

(setq enable-recursive-minibuffers t)

(setq tramp-default-method "ssh")

(setq eshell-buffer-shorthand t)

(add-to-list 'auto-mode-alist '("\\.proto$" . c-mode))

(server-start)
