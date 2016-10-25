;;; eim-setup.el --- 

;; Copyright 2016 
;;
;; Author: szj0306@ArchLinuxPC
;; Version: $Id: eim-setup.el,v 0.0 2016/08/17 11:23:00 szj0306 Exp $
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
;;   (require 'eim-setup)

;;; Code:

;; C-\ 开关输入法
;; C-x RET C-\ method RET 换一个输入法
;; M-x list-input-methods 显示所有支持的输入法列表
;; C-h C-\ RET 查看当前输入法的帮助

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/eim"))
(autoload 'eim-use-package "eim" "Another emacs input method")
;; Tooltip 暂时不好用
(setq eim-use-package nil)

;; 定制翻页快捷键
(defun my-eim-wb-activate-function ()
  (add-hook 'eim-active-hook
			(lambda ()
			  (let ((map (eim-mode-map)))
				(define-key map "," 'eim-previous-page)
				(define-key map "." 'eim-next-page)))))

(register-input-method
 "eim-wb" "euc-cn" 'eim-use-package
 "五笔" "汉字五笔输入法" "wb.txt"
 'my-eim-wb-activate-function)
(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "拼音" "汉字拼音输入法" "py.txt"
 'my-eim-wb-activate-function)

;; 用 ; 暂时输入英文
(require 'eim-extra)
(global-set-key ";" 'eim-insert-ascii)

(provide 'eim-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; eim-setup.el ends here
