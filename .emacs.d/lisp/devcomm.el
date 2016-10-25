;;; devcomm.el --- 

;; Copyright 2014 szj0306
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: devcomm.el,v 0.0 2014/10/31 05:17:25 szj0306 Exp $
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
;;   (require 'devcomm)

;;; Code:
(setq zch-compile-test-file "")
(setq zch-compile-test-args "")

(defun zch-file-extension (name)
  "获取文件扩展名，如果文件没有扩展名返回空字符串"
  (setq len (length name))
  (setq i len)
  (setq ch "")
  (while (and (> i 0) (not (string= ch ".")))
    (progn
      (setq ch (substring name (- i 1) i))
      (setq i (- i 1))))
  (if (> i 0)
      (setq name (substring name (+ i 1)))
    (setq name "")))

(provide 'devcomm)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; devcomm.el ends here
