(add-hook 'scala-mode-hook '(lambda ()
                             (c-subword-mode t)
                             (local-set-key (kbd "<backtab>") 'scala-indent:indent-with-reluctant-strategy)))

(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . scala-mode))
(setq scala-indent:align-parameters t)
(setq scala-indent:align-forms t)
