;;; ecb-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: ecb-setup.el,v 0.0 2014/08/25 10:28:30 szj0306 Exp $
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
;;   (require 'ecb-setup)

;;; Code:

(add-to-list 'load-path "~/.emacs.d/lisp/ecb-2.40")
(require 'ecb)
;; 自动启动ecb
(setq ecb-auto-activate nil ecb-tip-of-the-day nil)
;; (ecb-hide-ecb-windows)
;; ;;一键开关
;; (defun my-ecb-active-or-deactive ()
;;   (interactive)
;;   (if ecb-minor-mode
;; 	  (ecb-deactivate)
;; 	(ecb-activate)))
;; (global-set-key (kbd "<C-f1>") 'my-ecb-active-or-deactive)

;;;; 隐藏和显示ecb窗口
(define-key global-map [(shift f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(shift f2)] 'ecb-show-ecb-windows)

;;;; 各窗口间切换
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

(setq stack-trace-on-error t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("bfecb" (0.15)))))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("/opt/Documents/p2p_server/branches/matrix/server/vod/"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'ecb-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

;;; ecb-setup.el ends here
