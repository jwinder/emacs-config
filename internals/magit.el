(require 'magit)

(setq magit-git-executable "hub"
      magit-revert-buffers t
      magit-push-always-verify nil
      magit-push-arguments '("--set-upstream"))

(defun magit-x-undo ()
  (interactive)
  (magit-run-git "undo"))

(defun github-browse ()
  (interactive)
  (shell-command "hub browse"))

(defun github-issues ()
  (interactive)
  (shell-command "hub browse -- issues"))

(defun github-pulls ()
  (interactive)
  (shell-command "hub browse -- pulls"))

(defun github-compare ()
  (interactive)
  (shell-command "hub browse -- compare"))

(defun github-pull-request ()
  (interactive)
  (async-shell-command "hub pull-request" "*hub pull-request*"))

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
  :actions '((?b "Browse" github-browse)
             (?i "Issues" github-issues)
             (?p "Pulls" github-pulls)
             (?c "Compare" github-compare)
             (?P "Pull Request" github-pull-request)))

(magit-define-popup-action 'magit-dispatch-popup ?g "Status" 'magit-status)
(magit-define-popup-action 'magit-dispatch-popup ?x "Extras" 'magit-git-extras-popup)

(global-set-key (kbd "M-g") 'magit-dispatch-popup)
