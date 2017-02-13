;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; gnus.el - My gnus-configuration
;;
;; -------------------------------------------------------------------

;; GPG - done through EasyPG
;; See: https://www.emacswiki.org/emacs/EasyPG
(require 'epg-config)
(setq mml2015-use 'epg

      mml2015-verbose t
      mml2015-encrypt-to-self t
      mml2015-always-trust nil
      mml2015-cache-passphrase t
      mml2015-passphrase-cache-expiry '36000
      mml2015-sign-with-sender t

      gnus-message-replyencrypt t
      gnus-message-replysign t
      gnus-message-replysignencrypted t
      gnus-treat-x-pgp-sig t

      mm-verify-option 'always
      mm-decrypt-option 'always

      gnus-buttonized-mime-types
      '("multipart/alternative"
	"multipart/encrypted"
	"multipart/signed")

      epg-debug t)
