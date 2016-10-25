;;; sourcepair-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: sourcepair-setup.el,v 0.0 2014/08/28 06:56:00 szj0306 Exp $
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
;;   (require 'sourcepair-setup)

;;; Code:

;; There's a builtin function called ff-get-other-file
;; which will get the "other file" based on file extension.
;; I have this bound to C-o in c-mode ((local-set-key "\C-o" 'ff-get-other-file)).
;; While "other file" is per-mode defined,
;; in c-like languages it means jumping between the header and the source file.
;; So I switch back and forth between the header and the source with C-o.
;; If we had separate include/ and src/ directories, this would be a pain to setup,
;; but this might just work out of the box for you.
;; See the documentation for the variable cc-other-file-alist for more information.
;; sourcepair, find the c++ header or source file corresponding to current file.
;; (add-to-list 'load-path "~/.emacs.d/lisp")
(require 'sourcepair)
(define-key c-mode-map   [f12] 'sourcepair-load)
(define-key c++-mode-map [f12] 'sourcepair-load)
(define-key c-mode-map   [f12] 'sourcepair-jump-to-headerfile)
(define-key c++-mode-map [f12] 'sourcepair-jump-to-headerfile)

(require 'source-path)
(setq sourcepair-source-path
	  (append
	   sys-source-file-dir
	   user-source-file-dir
	   user-proj-file-dir
	  ))
(setq sourcepair-header-path
	  (append
	   sys-head-file-dir
	   user-head-file-dir
	   user-proj-file-dir
	   ))
(setq sourcepair-recurse-ignore '("CVS" "bin" "lib" "Obj" "Debug" "Release" ".svn" ".git"))

(provide 'sourcepair-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; sourcepair-setup.el ends here
