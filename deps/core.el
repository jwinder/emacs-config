(use-package afternoon-theme
  :ensure t
  :config (progn (load-theme 'afternoon t)
		 (set-cursor-color "dark grey")
		 (set-background-color "black")
		 (set-face-background 'fringe nil)))

(use-package helm :ensure t)
(use-package gist :ensure t)
(use-package undo-tree :ensure t)

(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status)))
