;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; emacs.el - My emacs-configuration
;;
;; -------------------------------------------------------------------

;; elisp base-path
(defvar ast-elisp-dir "~/github/elisp/")

;; Datei laden, wenn vorhanden, sonst Warnung
(defun ast-load-part (part)
  (let ((fullname (concat ast-elisp-dir part)))
    (if (file-exists-p fullname)
	(load fullname)
      (message (format "Error loading %s" fullname)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Internals, Benutzereinstellungen, ...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ast-load-part "emacs-intern.el") ; Interna

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pakete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ast-load-part "emacs-notmuch.el") ; Notmuch

