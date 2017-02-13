;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; gnus.el - My gnus-configuration
;;
;; -------------------------------------------------------------------

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



