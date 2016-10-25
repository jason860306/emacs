;;-*-coding:utf-8-*-
;;----------------------------------------------------------
;; module: mylib
;; library file..

(provide 'mylib)

;;----------------------------------------------------------
;; setup variables
(setq my-path (expand-file-name 
	       (if (eq system-type 'windows-nt)
		 "c:/My Dropbox/sync/bin/emacs/"
		 "~/Dropbox/sync/emacs/"
		 )))

(setq my-data-path (concat my-path "data/"))

(defun my-save (file) 
  "return `my-data-path' "
  (concat my-data-path file))

