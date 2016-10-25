;;; color-theme-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: color-theme-setup.el,v 0.0 2014/08/27 08:31:26 szj0306 Exp $
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
;;   (require 'color-theme-setup)

;;; Code:

;; emacs 配色方案

(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-6.6.0/")
(add-to-list 'load-path "~/.emacs.d/lisp/color")
(require 'color-theme)
;; (require 'color-theme-ahei)

(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ;; (my-color-theme)
	 ;; (sweyla840358)
     ;; (szj0306-emacs-theme)
     ;; (color-theme-hober)
	 ;; (color-theme-high-contrast)
	 ;; (color-theme-pok-wog)
	 ;; (color-theme-matrix)
	 ;; (color-theme-vim-colors)
     ;; (color-theme-scintilla)
     ;; (color-theme-simple-1)
     ))

(provide 'color-theme-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; color-theme-setup.el ends here
