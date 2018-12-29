;;; bootstrap.el
;;
;; Author: Adrien Brochard
;; URL:    https://github.com/abrochard/emacs-config
;;
;; kickstart the config by pulling the latest
;; and tangle the org files into .el
;;
;; Heavily inspired by the great http://www.holgerschurig.de/en/emacs-efficiently-untangling-elisp/
;; Thanks a lot to him

(defvar config-no-auto-update nil)
(defvar config-load-path (file-name-directory (or load-file-name buffer-file-name)))
(defvar config-org-files '("emacs-init.org" "cheatsheet.org"))
(defvar config-use-fallback nil)

;; Startup metrics
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))


(defun tangle-config-org (orgfile elfile)
  "This function will write all source blocks from an org file into a el file that are
- not marked as :tangle no
- have a source-code of =emacs-lisp="
  (let* ((body-list ())
         (gc-cons-threshold most-positive-fixnum)
         (org-babel-src-block-regexp   (concat
                                        ;; (1) indentation                 (2) lang
                                        "^\\([ \t]*\\)#\\+begin_src[ \t]+\\([^ \f\t\n\r\v]+\\)[ \t]*"
                                        ;; (3) switches
                                        "\\([^\":\n]*\"[^\"\n*]*\"[^\":\n]*\\|[^\":\n]*\\)"
                                        ;; (4) header arguments
                                        "\\([^\n]*\\)\n"
                                        ;; (5) body
                                        "\\([^\000]*?\n\\)??[ \t]*#\\+end_src")))
    (with-temp-buffer
      (insert-file-contents orgfile)
      (goto-char (point-min))
      (while (re-search-forward org-babel-src-block-regexp nil t)
        (let ((lang (match-string 2))
              (args (match-string 4))
              (body (match-string 5)))
          (when (and (string= lang "emacs-lisp")
                     (not (string-match-p ":tangle\\s-+no" args)))
              (add-to-list 'body-list body)))))
    (with-temp-file elfile
      (insert (format ";; Don't edit this file, edit %s instead ...\n\n" orgfile))
      (apply 'insert (reverse body-list)))
    (message "Wrote %s ..." elfile)))

(defun bootstrap-config ()
  "Pull latest config and tangle if needed."
  (if (not config-no-auto-update)
      (shell-command (concat "cd " config-load-path " && git pull")))
  (dolist (file config-org-files)
    (let ((orgfile (concat config-load-path file))
          (elfile (concat config-load-path (replace-regexp-in-string ".org" ".el" file))))
      (when (or (not (file-exists-p elfile))
                (file-newer-than-file-p orgfile elfile))
        (tangle-config-org orgfile elfile))
      (load-file elfile))))

(defun bootstrap-config-fallback ()
  "Just in case."
  (if (not config-no-auto-update)
      (shell-command (concat "cd " config-load-path " && git pull")))
  (package-initialize)
  (require 'org)
  (dolist (file config-org-files)
    (org-babel-load-file (concat config-load-path file))))


(if (not config-use-fallback)
    (bootstrap-config)
  (bootstrap-config-fallback))

;; bootstrap.el ends here
