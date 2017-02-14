;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; gnus-summary.el - The summary buffer
;;
;; -------------------------------------------------------------------

;; summary line
(setq gnus-summary-line-format "%O%U%R%z%d %(%[%4L: %-28,28f%ub%]%) %B %s\n"
      gnus-summary-mode-line-format "Gnus: %p [%A / Sc:%4z] %Z")

;; summary mode visual appearance
(setq gnus-summary-same-subject "")
(setq gnus-sum-thread-tree-root "")
(setq gnus-sum-thread-tree-single-indent "")
(setq gnus-sum-thread-tree-leaf-with-other "+-> ")
(setq gnus-sum-thread-tree-vertical "|")
(setq gnus-sum-thread-tree-single-leaf "`-> ")

;; I wanna be able to access my previous post
(setq gnus-fetch-old-headers t)
