;;; template-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: template-setup.el,v 0.0 2014/08/27 08:30:28 szj0306 Exp $
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
;;   (require 'template-setup)

;;; Code:

;; template.el配置
(add-to-list 'load-path "~/.emacs.d/lisp/template/")
(require 'mylib)
(require 'template)
;; 必须这么指定 搜索目录
(setq template-subdirectories '("~/.emacs.d/lisp/template/templates"))
(setq template-auto-insert t)
(template-initialize)
(add-to-list 'template-find-file-commands 'ido-exit-minibuffer)

(provide 'template-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; template-setup.el ends here
