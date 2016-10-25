;;; my-color-theme.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: my-color-theme.el,v 0.0 2014/09/01 06:47:34 szj0306 Exp $
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
;;   (require 'my-color-theme)

;;; Code:

(defun my-color-theme ()
  (interactive)
  (color-theme-install
   '(my-color-theme
      ((background-color . "#000000")
      (background-mode . light)
      (border-color . "#1a1a1a")
      (cursor-color . "#fce94f")
      (foreground-color . "#eeeeec")
      (mouse-color . "black"))
     (fringe ((t (:background "#1a1a1a"))))
     (mode-line ((t (:foreground "#eeeeec" :background "#555753"))))
     (region ((t (:background "#333333"))))
     (font-lock-builtin-face ((t (:foreground "#fdf521"))))
     (font-lock-comment-face ((t (:foreground "#235700"))))
     (font-lock-function-name-face ((t (:foreground "#9a091a"))))
     (font-lock-keyword-face ((t (:foreground "#4445fd"))))
     (font-lock-string-face ((t (:foreground "#8f0014"))))
     (font-lock-type-face ((t (:foreground"#4144ec"))))
     (font-lock-constant-face ((t (:foreground "#ba10f9"))))
     (font-lock-variable-name-face ((t (:foreground "#eeeeec"))))
     (minibuffer-prompt ((t (:foreground "#729fcf" :bold t))))
     (font-lock-warning-face ((t (:foreground "red" :bold t))))
     )))

(provide 'my-color-theme)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; my-color-theme.el ends here
