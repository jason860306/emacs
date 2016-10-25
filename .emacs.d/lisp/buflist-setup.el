;;; buflist-setup.el --- 

;; Copyright 2014 szj0306
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: buflist-setup.el,v 0.0 2014/10/31 03:20:49 szj0306 Exp $
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
;;   (require 'buflist-setup)

;;; Code:

(defun Buffer-menu-rename-buffer (newname)
  "Rename buffer at line in window."
  (interactive
   (list (read-buffer "Rename buffer (to new name): "
					  (buffer-name (Buffer-menu-buffer t)))))
  (with-current-buffer (Buffer-menu-buffer t)
	(rename-buffer newname))
  (revert-buffer))

(define-key Buffer-menu-mode-map "R" 'Buffer-menu-rename-buffer)

;; list the buffers in the current window.
(global-set-key (kbd "C-x C-b") 'buffer-menu)

(provide 'buflist-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; buflist-setup.el ends here
