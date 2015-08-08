(require 'magit)

(setq magit-git-executable "hub"
      magit-revert-buffers t
      magit-push-always-verify nil
      magit-push-arguments '("--set-upstream"))

(defun magit-x-undo ()
  (interactive)
  (magit-run-git "undo"))

(defun magit-github-browse ()
  (interactive)
  (shell-command "hub browse"))

(defun magit-github-issues ()
  (interactive)
  (shell-command "hub browse -- issues"))

(defun magit-github-pulls ()
  (interactive)
  (shell-command "hub browse -- pulls"))

(defun magit-github-compare ()
  (interactive)
  (shell-command "hub browse -- compare"))

(defun magit-github-pull-request ()
  (interactive)
  (magit-run-git-with-editor "pull-request"))

(magit-define-popup magit-git-extras-popup
  "Popup console for git-extras commands."
  'magit-commands
  :man-page "git-extras"
  :actions '((?g "Github" magit-github-popup)
             (?b "Blaming" magit-blame-popup)
             (?u "Undo commit" magit-x-undo)))

(magit-define-popup magit-github-popup
  "Popup console for github hub commands."
  'magit-commands
  :man-page "hub"
  :actions '((?b "Browse" magit-github-browse)
             (?i "Issues" magit-github-issues)
             (?p "Pulls" magit-github-pulls)
             (?c "Compare" magit-github-compare)
             (?P "Pull Request" magit-github-pull-request)))

(magit-define-popup-action 'magit-dispatch-popup ?g "Status" 'magit-status)
(magit-define-popup-action 'magit-dispatch-popup ?x "Extras" 'magit-git-extras-popup)

(global-set-key (kbd "M-g") 'magit-dispatch-popup)
