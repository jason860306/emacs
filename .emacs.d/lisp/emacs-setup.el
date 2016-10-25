;;; emacs-setup.el ---                                                                                                                                                            [10/13702]

;; Copyright 2016
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: emacs-setup.el,v 0.0 2016/05/26 09:17:32 szj0306 Exp $
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
;;   (require 'emacs-setup)

;;; Code:

;;; (add-to-list 'default-frame-alist '(font . "Consolas-9"))

(tool-bar-mode -1)

;; ;; 跳到指定行
;; ;; (global-set-key [?\C-\M-g] 'goto-line)
;; (define-key global-map "\C-c\C-g" 'goto-line)

;; emacs shell 乱码问题解决
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; 'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p) 

;; Default coding system (for new files)
;; 默认buffer编码是utf-8,(写文件)
(setq default-buffer-file-coding-system 'utf-8)

;; syntax highlighting
(global-font-lock-mode t)

;; 在行首 C-k 时，同时删除该行。
(setq-default kill-whole-line t)

;; (require 'google-c-style)
;; (add-hook 'c-mode-common-hook 'google-set-c-style)
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; 书签
;; C-x r m 添加书签
;; C-x r b 跳到某个书签
;; M-x list-bookmarks 显示所有书签，在里面d标记删除，u取消，r重命名，x执行操作
;; 要想保存书签，可以修改.emacs文件，在里面添加如下内容, 这会把书签保存到~/.emacs.bmk 
(setq bookmark-save-flag 1)

;; 改用Alt(Shift)+Space设置标记（set-mark)
;; (global-set-key [?\S- ] 'set-mark-command) 
;; (global-set-key [?\M- ] 'set-mark-command) 

;; 可以保存你上次光标所在的位置
(require 'saveplace)
(setq-default save-place t)

(require 'eim-setup)
(require 'shell-setup)
(require 'psvn)
(require 'buflist-setup)
(require 'line-scroll-setup)
(require 'linum-setup)
(require 'ido-setup)
(require 'whitespace-setup)
(require 'color-theme-setup)
(require 'template-setup)
(require 'etags-setup)
(require 'cc-mode-setup)
(require 'cscope-setup)
(require 'cedet-setup)
(require 'ecb-setup)
(require 'yasnippet-setup)
(require 'auto-complete-setup)
(require 'sourcepair-setup)
(require 'compile-setup)
(require 'gud-setup)

(provide 'emacs-setup)
(eval-when-compile
  (require 'cl))




;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; emacs-setup.el ends here
