;;; whitespace-setup.el ---

;; Copyright 2014
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: whitespace-setup.el,v 0.0 2014/08/27 08:32:14 szj0306 Exp $
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
;;   (require 'whitespace-setup)

;;; Code:

;; show white space
(require 'whitespace)

;; 去除多余的空格,默认开启删除多余空格模式
;; 存盘前删除行末多余的空格/空行
(add-hook 'before-save-hook (lambda () (whitespace-cleanup)))

(autoload 'global-whitespace-mode "whitespace" "Toggle global whitespace visualization." t)
(autoload 'global-whitespace-toggle-options "whitespace" "Toggle global `global-whitespace-mode' options." t)
;; make whitespace-mode use just basic coloring
(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-display-mappings
	  ;; all numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it
      '(
	(space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
	(newline-mark 10 [182 10]) ; 10 LINE FEED
	(tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
	))
(global-set-key "\C-c_w" 'whitespace-mode)
(global-set-key "\C-c_t" 'whitespace-toggle-options)
(global-set-key "\C-c=w" 'global-whitespace-mode)
(global-set-key "\C-c=t" 'global-whitespace-toggle-options)

(provide 'whitespace-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; whitespace-setup.el ends here
