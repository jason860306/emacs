;;; linum-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: linum-setup.el,v 0.0 2014/08/28 04:31:36 szj0306 Exp $
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
;;   (require 'linum-setup)

;;; Code:

;; 设置自动启用行号模式
(require 'linum)
(eval-after-load 'linum
 '(progn
    (defface linum-leading-zero
      `((t :inherit 'linum
           :foreground ,(face-attribute 'linum :background nil t)))
      "Face for displaying leading zeroes for line numbers in display margin."
      :group 'linum)

    (defun linum-format-func (line)
      (let ((w (length
                (number-to-string (count-lines (point-min) (point-max))))))
        (concat
         (propertize (make-string (- w (length (number-to-string line))) ?0)
                     'face 'linum-leading-zero)
         (propertize (number-to-string line) 'face 'linum))))

    (setq linum-format 'linum-format-func)))
(global-linum-mode t)

(provide 'linum-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; linum-setup.el ends here
