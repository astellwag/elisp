;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; emacs.el - My emacs-configuration
;;
;; -------------------------------------------------------------------

;; elisp base-path
(defvar ast-elisp-dir "~/elisp/")

;; path to local packages
(add-to-list 'load-path (expand-file-name (concat ast-elisp-dir "packages")))
