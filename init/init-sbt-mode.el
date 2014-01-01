(setq sbt:buffer-name-base "*sbt* ")

(global-set-key (kbd "C-c s s") 'sbt-start)
(global-set-key (kbd "C-c s f") 'sbt-find-definitions)
(global-set-key (kbd "C-c s p") 'sbt-run-previous-command)
(global-set-key (kbd "C-c s g") 'sbt-grep)

(require 'sbt-mode)
(defun sbt-compile () (interactive) (sbt-command "compile"))
(defun sbt-test () (interactive) (sbt-command "test"))
(defun sbt-test-quick () (interactive) (sbt-command "test-quick"))
(defun sbt-run () (interactive) (sbt-command "run"))
(defun sbt-console () (interactive) (sbt-command "console"))
(defun sbt-console-quick () (interactive) (sbt-command "console-quick"))

(global-set-key (kbd "C-c s c") 'sbt-compile)
(global-set-key (kbd "C-c s t") 'sbt-test)
(global-set-key (kbd "C-c s r") 'sbt-run)
(global-set-key (kbd "C-c s q") 'sbt-test-quick)
