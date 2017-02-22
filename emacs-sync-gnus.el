;; -*- emacs-lisp -*-
;; -------------------------------------------------------------------
;;
;; emacs-sync-gnus.el - sync gnus states w/ aragorn
;;
;; see: https://www.emacswiki.org/emacs/GnusSync
;;
;; -------------------------------------------------------------------

;; if you want to set variables like gnus-home-directory
;; or message-directory, do it here! For example:
;; (setq gnus-home-directory "~/")
;; (setq message-directory "~/Mail/")

;; DNS name of the remote computer where second Gnus installation resides
(setq my-gnussync-remote "aragorn")
;; Login name
(setq my-gnussync-remote-login "alex")
;; Name of rsync binary
(setq my-gnussync-rsync-binary "/usr/bin/rsync")
;; rsync options
(setq my-gnussync-rsync-options "-auRvzp --delete")
;; Additional files you want to sync, e.g. .bbdb,.gnus,.diary, whatever...  
;; Note that each file should start explicitly with "~/" 
;; For example: 
;; (setq my-gnussync-extra-files '("~/.bbdb" "~/.gnus" "~/subdir/otherfile"))
(setq my-gnussync-extra-files '("~/.bbdb"))

(defun my-gnussync-sync (arg)
  (interactive)
  (let ((filelist 
	 (append  
	  (list
	   gnus-startup-file
	   (format "%s.eld" gnus-startup-file)
	   (directory-file-name gnus-directory)
	   (directory-file-name message-directory))
	  my-gnussync-extra-files))
	(bufname (get-buffer-create "*GNUS SYNC*")))
    (cond 
     ((and (eq arg 'to-remote)
	  (y-or-n-p (format "Sync Gnus files to %s? " my-gnussync-remote)))
      (switch-to-buffer bufname)
      (insert "\n\n === LOCAL  -->  REMOTE ===\n")
      (apply 'call-process 
	     my-gnussync-rsync-binary 
	     (append 
	      (list nil bufname t)
	      (split-string my-gnussync-rsync-options)
	      (mapcar (lambda (file)
		    (if (string-match "^~" file)
		      (replace-match (format "%s/." (getenv "HOME")) t t file)
		      file))
		      filelist)
	      (list (format "%s@%s:" my-gnussync-remote-login my-gnussync-remote)))))
     ((and (eq arg 'from-remote)
	   (y-or-n-p (format "Sync Gnus files from %s? " my-gnussync-remote)))
      (switch-to-buffer bufname)
      (insert "\n\n === REMOTE  -->  LOCAL ===\n")
      (apply 'call-process 
	     my-gnussync-rsync-binary 
	     (append
	      (list nil bufname t)
	      (split-string my-gnussync-rsync-options " ")
	      (list (format "%s@%s:%s" my-gnussync-remote-login my-gnussync-remote 
			    (mapconcat 
			     (lambda (file)
			       (if (string-match "^~/" file)
				   (replace-match "" t t file)
				 file))
			     filelist " "))
		    (expand-file-name "~"))))))))


;; sync, even when emacs is killed

(defun gnus-grace-exit-before-kill-emacs ()
      (if (and (fboundp 'gnus-alive-p)
               (gnus-alive-p))
          (let ((noninteractive t))
            (gnus-group-exit))))
    
;; now install the hooks when not @work
(if (not (string-match "aragorn" system-name))
  (progn
    (add-hook 'gnus-before-startup-hook (lambda () (my-gnussync-sync 'from-remote)))
    (add-hook 'gnus-after-exiting-gnus-hook (lambda () (my-gnussync-sync 'to-remote)))
    (add-hook 'kill-emacs-hook 'gnus-grace-exit-before-kill-emacs)))
