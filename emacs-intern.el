;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; emacs-intern.el - emacs internals
;;
;; -------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; path to local files w/o package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name (concat ast-elisp-dir "misc")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Design
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auf der Console keine Menueleiste
(unless window-system
  (menu-bar-mode 0))
;; und unter X keinen Toolbar
(when window-system
  (tool-bar-mode -1))
