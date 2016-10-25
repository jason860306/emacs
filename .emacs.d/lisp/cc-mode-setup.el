;;; cc-mode-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: cc-mode-setup.el,v 0.0 2014/08/25 10:33:10 szj0306 Exp $
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
;;   (require 'cc-mode-setup)

;;; Code:

;;;; CC-mode配置  http://cc-mode.sourceforge.net/
;; emacs的缩进包括CC Mode的设置
(require 'cc-mode)
;; (setq indent-tabs-mode nil)
(setq indent-tabs-mode t)
(setq c-basic-offset 4)
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list ())
(loop for x downfrom 40 to 1 do
      (setq tab-stop-list (cons (* x 4) tab-stop-list)))
(setq c-default-style '((java-mode . "java")
						(awk-mode . "awk")
						(other . "linux")))
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

(defun my-c-mode-hook()
  "happy hacking."
  (interactive)
  (setq tab-width 4 ;; TAB键的宽度设置为4
		c-basic-offset 4
		indent-tabs-mode t ;; 使用TAB缩进
		c-tab-alway-indent nil) ;; 也使用TAB的原有功能
  (c-toggle-auto-hungry-state 1)  ;; hungry-delete and auto-newline
  (setq c-cleanup-list (append c-cleanup-list (list 'brace-else-brace)))
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'arglist-cont-nonempty 4)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'case-label 0)
  (c-set-offset 'statement-cont 4)
  (c-toggle-auto-state -1) ;; 不用自动换行 1 - 表示自动换行
  (c-toggle-hungry-state) ;; 此模式下，当按Backspace时会删除最多的空格
  (define-key c-mode-map [return] 'newline-and-indent) ;; 将回车代替c-j的功能，换行的同时对齐
  (define-key c-mode-map "\C-ce" 'c-comment-edit) ;; 写注释
  ;;按键定义
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(f7)] 'compile)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
  ;;  (define-key c-mode-base-map [(tab)] 'hippie-expand)
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  ;;预处理设置
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
)
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'cc-mode-hook 'my-c-mode-hook)

;;输入左边的括号，就会自动补全右边的部分.包括(), "", [] , {} , 等等。
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist '(
                              (?\` > _ "`")
                              (?\' > _ "'")
                              (?\" > _ "\"")
                              (?\( > _ ")")
                              (?\[ > _ "]")
                              (?\< > _ ">")
                              (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "'") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "<") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))

(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair)

(provide 'cc-mode-setup)
(eval-when-compile
  (require 'cl))


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

;;; cc-mode-setup.el ends here
