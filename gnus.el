;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; me, myself and I
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-mail-address (concat "alex@" 	;; dont spam me
	"stellwag.net")
      user-full-name "Alex Stellwag"
      gnus-ignored-from-addresses "\\(alex\\(ander\\)?\\|openstack\\)\\(\\+.*\\)?@stellwag\\.net")

      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; where to find email
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'nnir)
(setq gnus-select-method
      '(nnimap ""
	       (nnimap-address "imap.mailbox.org")
	       (nnimap-server-port 143)
	       (nnimap-stream starttls)
	       (nnir-search-engine imap))
      gnus-use-agent nil
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.mailbox.org"
      smtpmail-smtp-service 587)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GPG - done through EasyPG
;; See: https://www.emacswiki.org/emacs/EasyPG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'epg-config)
(setq mml2015-use 'epg

      mml2015-verbose t
;      epg-user-id gpgpgpkeyID
      mml2015-encrypt-to-self t
      mml2015-always-trust nil
      mml2015-cache-passphrase t
      mml2015-passphrase-cache-expiry '36000
      mml2015-sign-with-sender t

      gnus-message-replyencrypt t
      gnus-message-replysign t
      gnus-message-replysignencrypted t
      gnus-treat-x-pgp-sig t

      ;;       mm-sign-option 'guided
      ;;       mm-encrypt-option 'guided
      mm-verify-option 'always
      mm-decrypt-option 'always

      gnus-buttonized-mime-types
      '("multipart/alternative"
	"multipart/encrypted"
	"multipart/signed")

      epg-debug t)
;(add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)

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
;; BBDB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'bbdb-autoloads)
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
