;;; yasnippet-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: yasnippet-setup.el,v 0.0 2014/08/28 04:29:31 szj0306 Exp $
;; Keywords: 
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; 

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'yasnippet-setup)

;;; Code:

;; yasnippet配置
(add-to-list 'load-path "~/.emacs.d/lisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/lisp/popup-el")

;; (setq yas-minor-mode-map ;This MUST before (require 'yasnippet)
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "M-i") 'yas-expand)
;;     (define-key map "\C-c&\C-n" 'yas-new-snippet)
;;     (define-key map "\C-c&\C-v" 'yas-visit-snippet-file)
;;     map)) 

(require 'yasnippet)
(require 'yasnippet-bundle)
(require 'auto-yasnippet)
(setq yas/prompt-functions 
   '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用
(setf yas/indent-line 'fixed)

(setq yas/root-directory "~/.emacs.d/lisp/snippets")
(yas/load-directory yas/root-directory)

(global-set-key (kbd "H-w") 'create-auto-yasnippet)
(global-set-key (kbd "H-y") 'expand-auto-yasnippet)

;; Remove Yasnippet's default tab key binding
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

;; ;;; use popup menu for yas-choose-value
;; (require 'popup)

;; ;; add some shotcuts in popup menu mode
;; (define-key popup-menu-keymap (kbd "M-n") 'popup-next)
;; (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
;; (define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

;; (defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
;;   (when (featurep 'popup)
;;     (popup-menu*
;;      (mapcar
;;       (lambda (choice)
;;         (popup-make-item
;;          (or (and display-fn (funcall display-fn choice))
;;              choice)
;;          :value choice))
;;       choices)
;;      :prompt prompt
;;      ;; start isearch mode immediately
;;      :isearch t
;;      )))

;; (setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))

(defun shk-yas/helm-prompt (prompt choices &optional display-fn)
  "Use helm to select a snippet. Put this into `yas/prompt-functions.'"
  (interactive)
  (setq display-fn (or display-fn 'identity))
  (if (require 'helm-config)
	  (let (tmpsource cands result rmap)
		(setq cands (mapcar (lambda (x) (funcall display-fn x)) choices))
		(setq rmap (mapcar (lambda (x) (cons (funcall display-fn x) x)) choices))
		(setq tmpsource
			  (list
			   (cons 'name prompt)
			   (cons 'candidates cands)
			   '(action . (("Expand" . (lambda (selection) selection))))
			   ))
		(setq result (helm-other-buffer '(tmpsource) "*helm-select-yasnippet"))
		(if (null result)
			(signal 'quit "user quit!")
		  (cdr (assoc result rmap))))
	nil))

;; Completing point by some yasnippet key
(defun yas-ido-expand ()
  "Lets you select (and expand) a yasnippet key"
  (interactive)
    (let ((original-point (point)))
      (while (and
              (not (= (point) (point-min) ))
              (not
               (string-match "[[:space:]\n]" (char-to-string (char-before)))))
        (backward-word 1))
    (let* ((init-word (point))
           (word (buffer-substring init-word original-point))
           (list (yas-active-keys)))
      (goto-char original-point)
      (let ((key (remove-if-not
                  (lambda (s) (string-match (concat "^" word) s)) list)))
        (if (= (length key) 1)
            (setq key (pop key))
          (setq key (ido-completing-read "key: " list nil nil word)))
        (delete-char (- init-word original-point))
        (insert key)
        (yas-expand)))))
(define-key yas-minor-mode-map (kbd "<S-tab>") 'yas-ido-expand)

(provide 'yasnippet-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; yasnippet-setup.el ends here
