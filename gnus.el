;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; gnus.el - My gnus-configuration
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
;; identities and messages sources
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ast-load-part "gnus-personal.el")  ; Identities and personal settings
(ast-load-part "gnus-mail.el")      ; message sources

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pakete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ast-load-part "gnus-bbdb.el")    ; The Insidious Big Brother Database


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; boxquotes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'boxquote)
(define-key message-mode-map "\C-cqy" 'boxquote-yank)
(define-key message-mode-map "\C-cqr" 'boxquote-region)
(define-key message-mode-map "\C-cqu" 'boxquote-unbox-region)
(define-key message-mode-map "\C-cqt" 'boxquote-title)
(define-key message-mode-map "\C-cqi" 'boxquote-insert-file)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auswahl bei MIME-Alternativen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; bei vorhandenen Alternativen vermeiden
(setq mm-discouraged-alternatives
      '("text/html" "text/richtext" "multipart/related"))

;; Katsumi Yamaoka in <yosusn7ohc5l.fsf@jpl.org>
;; Washing auch auf gerenderte HTML-Mails anwenden
(eval-after-load "gnus-art"
  '(setq gnus-article-treat-types
	 (cons "text/html" gnus-article-treat-types)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Aufruf externer Programme (ab Gnus 5.10)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; emacs-w3m nutzen
(setq mm-text-html-renderer 'w3m)

;; keine w3m-Tastenbelegungen
(setq mm-inline-text-html-with-w3m-keymap nil)

;; keine Bilder
(setq mm-inline-text-html-with-images nil)

;; emacs-w3m auch beim Washing `W H' von falsch deklarierten
;; HTML-Mails verwenden
(setq gnus-article-wash-function 'gnus-article-wash-html-with-w3m)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; group buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; make (some) groups permanently visible 
(setq gnus-permanently-visible-groups "^\\(INBOX\\|Friends\\|Wichtig\\\|Family\\)")

;; summary line
(setq gnus-summary-line-format "%O%U%R%z%d %(%[%4L: %-28,28f%]%) %B %s\n"
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Topics                          (Info-goto-node "(Gnus)Group Topics")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Topics anzeigen
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; aber keine leeren Topics
;(setq gnus-topic-display-empty-topics nil)

;; Anzeige mit Anzahl der ungelesenen Artikel
;(setq gnus-topic-line-format "%i[ %(%{%n%}%) -- %A ]%v\n")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; group parameters and posting styles
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq gnus-gcc-mark-as-read t)
(setq gnus-parameters
      '(
	;;;;;;;;;;;;;; Defaults für alle Gruppen
	(".*"
	 (gcc-self "Sent" t))
	;; INBOX Mails nur in "Sent" ablegen
	("INBOX"
	 (gcc-self . "Sent"))))

(setq gnus-posting-styles
      '((".*"
	 (address "alex@stellwag.net"))
	("^openstack"
	 (address "openstack@stellwag.net"))
	("^dovecotbuch"
	 (address "lists+dovecotbuch@stellwag.net"))
	("^postfixbuch"
	 (address "lists+postfixbuch@stellwag.net"))))
