;; Don't edit this file, edit /Users/ngrogan/.dotfiles/conf/emacs.d/emacs-init.org instead ...

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
;;(use-package benchmark-init
;;  :ensure t
;;  :config
;;  ;; To disable collection of benchmark data after init is done.
;;  (add-hook 'after-init-hook 'benchmark-init/deactivate))
(when (memq window-system '(mac ns))
  (setq ns-pop-up-frames nil
        x-select-enable-clIpboard t)
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config (exec-path-from-shell-initialize))
  (when (fboundp 'mac-auto-operator-composition-mode)
    (mac-auto-operator-composition-mode 1)))'
  (setq tls-checktrust t)
  (setq gnutls-verify-error t)
(mapc
 (lambda (package)
   (if (not (package-installed-p package))
       (progn
         (package-refresh-contents)
         (package-install package))))
 '(use-package diminish bind-key))
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
(setq use-package-always-ensure t)
(use-package solarized-theme :config (load-theme 'solarized-dark t))
  (defun edit-config-file ()
    (interactive)
    (find-file (concat config-load-path "emacs-init.org")))
;; store all autosave files in the tmp dir
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; backups in backup dir
(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.emacs.d/backup"))
      delete-old-versions t
      kept-new-versions 24
      kept-old-versions 12
      version-control t)

(setq create-lockfiles nil)
(use-package recentf
    :defer 1
    :config (recentf-mode 1)
(setq recentf-max-menu-items 300)
(setq recentf-max-saved-items 300)
(setq recentf-exclude
   '("/elpa/" ;; ignore all files in elpa directory
     "recentf" ;; remove the recentf load file
     ".*?autoloads.el$"
     "treemacs-persist"
     "company-statistics-cache.el" ;; ignore company cache file
     "/intero/" ;; ignore script files generated by intero
     "/journal/" ;; ignore daily journal files
     ".gitignore" ;; ignore `.gitignore' files in projects
     "/tmp/" ;; ignore temporary files
     "NEWS" ;; don't include the NEWS file for recentf
     "bookmarks"  "bmk-bmenu" ;; ignore bookmarks file in .emacs.d
     "loaddefs.el"
     "^/\\(?:ssh\\|su\\|sudo\\)?:" ;; ignore tramp/ssh files
     ))
(setq-default recent-save-file "~/.emacs.d/recentf"))
(tool-bar-mode -1)
;;(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(setq initial-major-mode 'emacs-lisp-mode)
(setq initial-scratch-message nil)
(use-package helm
  :ensure t
  :demand
  :diminish helm-mode
  :bind (("C-x C-r" . helm-recentf)
           ("M-x" . helm-M-x)
           ("C-x C-f" . helm-find-files)
           ("C-c h" . helm-command-prefix)
           ("<tab>" . helm-execute-persistent-action)
           ("C-i" . helm-execute-persistent-action)
           ("C-z" . helm-select-action))

    :config (setq projectile-project-search-path '("~/repos/" "~/.dotfiles/"))
            (setq helm-split-window-inside-p t
                  helm-M-x-fuzzy-match t
                  helm-buffers-fuzzy-matching t
                  helm-ff-file-name-history-use-recentf t
                  helm-recentf-fuzzy-match t
                  helm-move-to-line-cycle-in-source t
                  projectile-completion-system 'helm)

            (set-face-attribute 'helm-selection nil :background "cyan")
            (helm-mode 1)
            (helm-adaptive-mode 1))

(use-package helm-rg)
(use-package helm-system-packages)
(use-package evil
  :ensure t
  :config (evil-mode 1))
(use-package company
    :diminish company-mode
    :init
  (autoload 'helm-company "helm-company") ; Not necessary if using ELPA package
  (eval-after-load 'company
    '(progn
       (define-key company-mode-map (kbd "C-<tab>") 'helm-company)
       (define-key company-active-map (kbd "C-<tab>") 'helm-company)))
    :config
   (setq company-idle-delay 0
      company-echo-delay 0
      company-dabbrev-downcase nil
      company-minimum-prefix-length 2
      company-selection-wrap-around t
      company-transformers '(company-sort-by-occurrence
                             company-sort-by-backend-importance)))
(use-package helm-company
     :ensure t
     :init (autoload 'helm-company "helm-company"))
  (use-package company-jedi
    :config (add-to-list 'company-backends 'company-jedi))
(use-package magit
    :defer 5
    :ensure t
    :init (progn
           (bind-key "C-x g" 'magit-status)
           ))
(use-package git-gutter
    :ensure t
    :init
      (global-git-gutter-mode t)
    :diminish git-gutter-mode
    :config
    (dolist (p '((git-gutter:added    . "#0c0")
                (git-gutter:deleted  . "#c00")
                (git-gutter:modified . "#c0c")))
     (set-face-foreground (car p) (cdr p))
     (set-face-background (car p) (cdr p))))
(use-package htmlize)
(use-package org
    :ensure t
    :pin org)

(setq org-completion-use-ido nil)
;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/org")
(setq org-agenda-files '("~/Dropbox/org/inbox.org"
                      "~/Dropbox/org/gtd.org"
                      "~/Dropbox/org/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                            (file+headline "~/Dropbox/org/inbox.org" "Tasks")
                            "* TODO %i%?")
                          ("T" "Tickler" entry
                            (file+headline "~/Dropbox/org/tickler.org" "Tickler")
                            "* %i%? \n %U")))

(setq org-refile-targets '(("~/Dropbox/org/gtd.org" :maxlevel . 3)
                        ("~/Dropbox/org/someday.org" :level . 1)
                        ("~/Dropbox/org/tickler.org" :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-confirm-babel-evaluate nil)
(org-babel-do-load-languages
'org-babel-load-languages
'((emacs-lisp . t)
  (C . t)
  (css . t)
  (ditaa . t)
  (gnuplot . t)
  (ledger . t)
  (java . t)
  (python . t)
  (ruby . t)
  (shell . t)))
(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-edit-src-content-indentation 0)
(use-package org-bullets
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(setq org-startup-with-inline-images t)
(use-package prodigy
:ensure t
:config
(prodigy-define-service
  :name "blog@localhost"
  :command "python2"
  :args '("-m" "SimpleHTTPServer" "8000")
  :cwd "~/repos/org-blog"
  :tags '(file-server)
  :stop-signal 'sigkill
  :kill-process-buffer-on-stop t))
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind ("C-c p" . projectile-command-map)
  :config
  (projectile-mode))
(use-package helm-projectile
  :bind (("C-c v" . helm-projectile)
         ("C-c C-v" . helm-projectile-ag)
         ("C-c w" . helm-projectile-switch-project)))
(use-package which-key
  :diminish which-key-mode
  :config (which-key-mode 1))
  (use-package dockerfile-mode
    :mode "Dockerfile\\'")
(use-package editorconfig
    :diminish editorconfig-mode
    :config (editorconfig-mode 1))
(use-package eldoc
  :diminish eldoc-mode
  :config (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))
(use-package erlang
    :defer t
    :mode ("\\.[eh]rl\\'" . erlang-mode))

(use-package company-erlang
  :config
(add-hook 'erlang-mode-hook #'company-erlang-init))
(use-package markdown-mode
  :ensure t
  :commands markdown-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))
(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode t)
  (setq undo-tree-visualizer-diff t))
