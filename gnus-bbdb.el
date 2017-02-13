;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; gnus-bbdb.el - Setup and use the insidious big brother database
;;
;; -------------------------------------------------------------------

(require 'bbdb)

;; initialization
(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'gnus 'message)

;; size of the bbdb popup
(setq bbdb-pop-up-window-size 0.15
      bbdb-mua-pop-up-window-size 0.15

      ;; What do we do when invoking bbdb interactively
      bbdb-mua-update-interactive-p '(query . create)

      ;; Make sure we look at every address in a message and not only the
      ;; first one
      bbdb-message-all-addresses t

      ;; prevent BBDB buffer ´from being shown in simple buffer list
      bbdb-after-read-db-hook '(lambda () (rename-buffer " bbdb"))

      ;; auto-save the bbdb
      bbdb-offer-save 1)



