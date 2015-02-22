(use-package yaml-mode :ensure t)

(use-package dockerfile-mode :ensure t)

(use-package scala-mode2 :ensure t
	:mode (("\\.scala$" . scala-mode)
				 ("\\.sbt$" . scala-mode)))

(use-package sbt-mode :ensure t)

(use-package ruby-mode :ensure t
	:mode (("Gemfile$" . ruby-mode)
				 ("Rakefile$" . ruby-mode)
				 ("Vagrantfile$" . ruby-mode)
				 ("Berksfile$" . ruby-mode)))

(use-package coffee-mode :ensure t
	:config (setq coffee-tab-width 2))
