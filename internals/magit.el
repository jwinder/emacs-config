(require 'magit)

(setq magit-revert-buffers t
      magit-push-always-verify nil
      magit-push-arguments '("--set-upstream"))

(defun magit-x-undo ()
  (interactive)
  (magit-run-git "undo"))

(defun magit-x-github-browse ()
  (interactive)
  (shell-command "hub browse"))

(defun magit-x-github-compare ()
  (interactive)
  (shell-command "hub compare"))

(magit-define-popup magit-git-extras-popup
  "Popup console for git-extras commands."
  'magit-commands
  :man-page "git-extras"
  :switches nil
  :actions '((?L "Blaming" magit-blame-popup)
             (?u "Undoing" magit-x-undo)
             (?b "Github Browsing" magit-x-github-browse)
             (?c "Github Comparing" magit-x-github-compare))
  :default-arguments nil)

(magit-define-popup-action 'magit-dispatch-popup ?g "Status" 'magit-status)
(magit-define-popup-action 'magit-dispatch-popup ?x "Extras" 'magit-git-extras-popup)

(global-set-key (kbd "M-g") 'magit-dispatch-popup)
