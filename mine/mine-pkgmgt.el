(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch el-get-install-skip-emacswiki-recipes)
      (goto-char (point-max)) (eval-print-last-sexp))))

(setq el-get-user-package-directory "~/.emacs.d/init")

(setq el-get-sources '((:name wgrep
                              :description "Writable grep buffer and apply the changes to files"
                              :website "https://github.com/mhayashi1120/Emacs-wgrep"
                              :type github
                              :pkgname "mhayashi1120/Emacs-wgrep")
                       (:name enclose
                              :description "Enclose cursor within punctuation pairs"
                              :type elpa
                              :autoloads nil
                              :prepare (progn
                                         (autoload 'enclose-global-mode "enclose" nil t)
                                         (autoload 'enclose-mode "enclose" nil t)))
                       (:name logito
                              :website "https://github.com/sigma/logito"
                              :description "tiny logging framework for Emacs"
                              :type github
                              :pkgname "sigma/logito")
                       (:name pcache
                              :website "https://github.com/sigma/pcache"
                              :description "persistent caching for Emacs"
                              :type github
                              :pkgname "sigma/pcache")
                       (:name github
                              :website "https://github.com/sigma/gh.el"
                              :description "GitHub API library for Emacs"
                              :type github
                              :depends (pcache logito)
                              :pkgname "sigma/gh.el")
                       (:name gist
                              :website "http://github.com/defunkt/gist.el"
                              :description "Emacs integration for gist.github.com"
                              :type github
                              :pkgname "defunkt/gist.el"
                              :depends github
                              :features gist)

                       (:name zen-and-art-theme
                              :description "A port of the zen-and-art color theme using the new deftheme format."
                              :type elpa
                              :repo ("melpa" . "http://melpa.milkbox.net/packages/")
                              :post-init (progn
                                           (add-to-list 'custom-theme-load-path default-directory)))
                       (:name midnight-theme
                              :website "https://github.com/jwinder/midnight-theme.el"
                              :description "A port of the midnight color theme using the new deftheme format."
                              :type github
                              :pkgname "jwinder/midnight-theme.el"
                              :post-init (progn
                                           (add-to-list 'custom-theme-load-path default-directory)))
                       (:name restclient
                              :website "https://github.com/pashky/restclient.el"
                              :description "HTTP REST client tool for emacs"
                              :type github
                              :pkgname "pashky/restclient.el"
                              :prepare (progn
                                         (autoload 'restclient-mode "restclient" nil t)
                                         (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))))
                       (:name sbt
                              :website "https://github.com/rubbish/sbt.el"
                              :description "support for running sbt in inferior mode."
                              :type github
                              :pkgname "rubbish/sbt.el"
                              :prepare (add-hook 'scala-mode-hook 'turn-on-sbt-mode))
                       (:name scala-mode2
                              :website "https://github.com/hvesalai/scala-mode2"
                              :type github
                              :pkgname "hvesalai/scala-mode2")
                       (:name json-validate
                              :website "https://github.com/jwinder/json-validate.el"
                              :description "Few useful commands for validating a buffer of json for correctness."
                              :type github
                              :pkgname "jwinder/json-validate.el"
                              :features json-validate)
                       (:name sudo-file
                              :website "https://github.com/jwinder/sudo-file.el"
                              :description "Few useful commands for opening/saving protected files on a linux operating system."
                              :type github
                              :pkgname "jwinder/sudo-file.el"
                              :features sudo-file)
                       (:name powerline
                              :website "https://github.com/milkypostman/powerline"
                              :description "emacs powerline"
                              :type github
                              :pkgname "milkypostman/powerline"
                              :features powerline)
                       (:name jade-mode
                              :website "https://github.com/brianc/jade-mode"
                              :description "jade template mode"
                              :type github
                              :pkgname "brianc/jade-mode"
                              :features jade-mode
                              :prepare (add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode)))))

(setq mine-pkgs-to-install
      (append
       '(;; lisp
         highlight-parentheses
         paredit

         ;; scala
         ;; scala-mode
         ;; ensime

         ;; ruby
         rinari

         ;; markdown
         markdown-mode

         ;; misc
         smex
         full-ack
         undo-tree
         wrap-region
         expand-region
         switch-window
         scratch
         magit
         yasnippet
         mark-multiple)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync mine-pkgs-to-install)

(provide 'mine-pkgmgt)
