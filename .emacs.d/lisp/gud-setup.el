;;; gud-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: gud-setup.el,v 0.0 2014/08/25 10:34:13 szj0306 Exp $
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
;;   (require 'gud-setup)

;;; Code:

(require 'devcomm)
(require 'gdb-mi)
;; (setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gdb-non-stop-setting nil)
(setq gdb-gud-control-all-threads t)
(setq gdb-switch-when-another-stopped nil)

;; (defun my-gdb-stopped-hook (record)
;;   (with-current-buffer (get-buffer-create "*debug-stop-log*")
;; 					   (insert
;; 						 (format "%s stopped in %s (%s)\n"
;; 								 (gdb-get-field record 'thread-id)
;; 								 (gdb-get-field record 'frame 'func)
;; 								 (gdb-get-field record 'reason)))))
;; (add-to-list 'gdb-stopped-hooks #'my-gdb-stopped-hook)

;; ;; Force gdb-mi to not dedicate any windows
;; (defadvice gdb-display-buffer (after undedicate-gdb-display-buffer)
;; 		     (set-window-dedicated-p ad-return-value nil))
;; (ad-activate 'gdb-display-buffer)

;; (defadvice gdb-set-window-buffer (after undedicate-gdb-set-window-buffer (name &optional ignore-dedi window))
;; 		     (set-window-dedicated-p window nil))
;; (ad-activate 'gdb-set-window-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; debug
;;调试定制
(defun zch-gdb-get-file ()
  "获得正在调试的可执行文件名"
  (setq file (buffer-name gud-comint-buffer))
  (setq len (length file))
  (setq file (substring file 5 (- len  1))))

(defun zch-gdb-onekey-debug (command)
  "一键调试"
  (let ((old-buffer)(window))
    (interactive)
    (setq old-buffer (window-buffer))
    (setq window (selected-window))
;;    (gdb (concat "gdb -i=mi --annotate=3 -windows" command))
	(gdb (concat "gdb -i=mi" command))
    (set-window-buffer (selected-window) old-buffer)
    (other-window 1)
    (set-window-buffer (selected-window) gud-comint-buffer)
    (select-window window)))

(defun zch-gdb-ptype()
  "打印光标所在处的标识符的类型"
  (interactive)
  (setq symbol (sbw-get-symbol-at-cursor))
  (if symbol
      (gud-call (concat "ptype " symbol))))

(defun zch-gdb-ptype-dcptr()
  "打印光标所在处的标识符的类型"
  (interactive)
  (setq symbol (sbw-get-symbol-at-cursor))
  (if symbol
      (gud-call (concat "ptype " symbol ".m_p"))))


(defun zch-gdb-print-dcptr()
  "打印光标所在处的智能指针的对象"
  (interactive)
  (setq symbol (sbw-get-symbol-at-cursor))
  (if symbol
      (gud-call (concat "print " symbol ".m_p"))))

(defun zch-gdb-pstar-dcptr()
  "打印光标所在处的智能指针的对象"
  (interactive)
  (setq symbol (sbw-get-symbol-at-cursor))
  (if symbol
      (gud-call (concat "print *" symbol ".m_p"))))

(setq zch-gdb-source-window nil)

(defun zch-gdb-switch-window()
  "在源代码窗口和调试窗口之间进行切换"
  (interactive)
  (if (eq (window-buffer) gud-comint-buffer)
      (select-window zch-gdb-source-window)
    (progn 
      (setq zch-gdb-source-window (selected-window))
      (setq gdb-window (get-buffer-window gud-comint-buffer))
      (if gdb-window
          (select-window gdb-window)
        (progn
          (other-window 1)
          (set-window-buffer (selected-window) gud-comint-buffer))))))

(defun zch-gdb-frame-buffer(name)
  "打开指定调试frame窗口,name 可以是任何gdb-buffer-rules-assoc变量列出的名字"
  (setq window (selected-window))
  (other-window 1)
  (if (eq (window-buffer) gud-comint-buffer) 
      (other-window 1))
  (if (eq (gdb-get-buffer name) nil)
      (set-window-buffer (selected-window) (gdb-get-buffer-create name)))
  (if (eq (get-buffer-window (gdb-get-buffer name)) nil)
      (set-window-buffer (selected-window) (gdb-get-buffer name)))
  (select-window window))

(defun zch-gdb-assembler-buffer()
  "在另外一个窗口打开assembler frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-assembler-buffer))
(defun zch-gdb-locals-buffer()
  "在另外一个窗口打开locals frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-locals-buffer))
(defun zch-gdb-memory-buffer()
  "在另外一个窗口打开memory frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-memory-buffer))
(defun zch-gdb-registers-buffer()
  "在另外一个窗口打开registers frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-registers-buffer))
(defun zch-gdb-threads-buffer()
  "在另外一个窗口打开threads frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-threads-buffer))
(defun zch-gdb-stack-buffer()
  "在另外一个窗口打开stack frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-stack-buffer))
(defun zch-gdb-breakpoints-buffer()
  "在另外一个窗口打开breakpoints frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-breakpoints-buffer))
(defun zch-gdb-inferior-io()
  "在另外一个窗口打开inferior frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-inferior-io))
(defun zch-gdb-partial-output-buffer()
  "在另外一个窗口打开partial output frame"
  (interactive)
  (zch-gdb-frame-buffer 'gdb-partial-output-buffer))

(defun zch-gdb-print-object()
  "打开打印对象状态，打开后能通过C++的虚拟机制打印一个对象的最终类的信息"
  (interactive)
  (gud-call "set print object on"))

;;gdb正在调试的文件
(setq zch-gdb-file "")

(defun zch-gdb-test-debug-or-go ()
  "调试测试文件。这个函数的行为是这样的:
   *. 如果当前buffer是一个.ct或者.ce文件，并且gdb没有启动，那么启动一个gdb，并且装载当前的测试文件
   *. 如果当前buffer不是一个.ct或者.ce文件，并且gdb没有启动，那么启动一个gdb，并且装载当前的测试文件
   *. 如果gdb已经启动，那么继续进测试或者开始运行测试
   *. 如果当前buffer是一个.ct或者.ce文件，那么这个函数会把zch-compile-test-file变量改成当前buffer里的测试名称"
  (interactive)
  
  (if (string= (zch-file-extension buffer-file-name) "ct")
      (setq zch-compile-test-file buffer-file-name))
  (if (string= zch-compile-test-file "")
      (setq command "")
    (setq command (zch-compile-run-command)))

  ;;判断是否有gdb在运行
  (setq has-gdb nil)
  (if (and gud-comint-buffer
           (buffer-name gud-comint-buffer)
           (get-buffer-process gud-comint-buffer)
           (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba)))
      (setq has-gdb "true"))

  (if has-gdb
      (progn 
        (if (eq (get-buffer-window gud-comint-buffer) nil)
            (progn
              (other-window 1)
              (set-window-buffer (selected-window) gud-comint-buffer)))
        (setq window (selected-window))
        (gud-call (if gdb-active-process "continue" "run") "")
        (select-window window))
    (progn 
      (setq zch-gdb-source-window (selected-window))
      (zch-gdb-onekey-debug command)
      (setq zch-gdb-file command))))

(defun zch-gdb-debug-or-go ()
  "If gdb isn't running; run gdb, else call gud-go."
  (interactive)
  (if (and gud-comint-buffer
           (buffer-name gud-comint-buffer)
           (get-buffer-process gud-comint-buffer)
           (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba)))
      (progn
        (setq window (selected-window))
        (gud-call (if gdb-active-process "continue" "run") "")
        (select-window window))
    (zch-gdb-onekey-debug "")))

(defun zch-gdb-break-remove ()
  "Set/clear breakpoin."
  (interactive)
  (save-excursion
    (if (eq (car (fringe-bitmaps-at-pos (point))) 'breakpoint)
        (gud-remove nil)
      (gud-break nil))))

(defun zch-gdb-break-watch()
  "对光标当前的变量设置内存断点"
  (interactive)
  (setq symbol (sbw-get-symbol-at-cursor))
  (if symbol
      (gud-call (concat "watch " symbol))))

(defun zch-gdb-break-rwatch()
  "对光标当前的变量设置内存断点"
  (interactive)
  (setq symbol (sbw-get-symbol-at-cursor))
  (if symbol
      (gud-call (concat "rwatch " symbol))))

(defun zch-gdb-break-awatch()
  "对光标当前的变量设置内存断点"
  (interactive)
  (setq symbol (sbw-get-symbol-at-cursor))
  (if symbol
      (gud-call (concat "awatch " symbol))))

(defun zch-gdb-kill ()
  "Kill gdb process."
  (interactive)
  (with-current-buffer gud-comint-buffer (comint-skip-input))
  (kill-process (get-buffer-process gud-comint-buffer)))

;;调试快捷键
(global-set-key [f5]                            'zch-gdb-test-debug-or-go)
(global-set-key [S-f5]                          'zch-gdb-kill)
(global-set-key [f8]                            'gud-next)
(global-set-key [C-f8]                          'gud-until)
(global-set-key [S-f8]                          'gud-finish)
(global-set-key [S-f7]                          'gud-jump)
(global-set-key [f7]                            'gud-step)
(global-set-key [f9]                            'zch-gdb-break-remove)
(global-set-key "\C-cmw"                        'zch-gdb-break-watch)
(global-set-key "\C-cmr"                        'zch-gdb-break-rwatch)
(global-set-key "\C-cma"                        'zch-gdb-break-awatch)

(global-set-key [(control =)]                   'gud-print)
(global-set-key [(control +)]                   'gud-pstar)
(global-set-key [(meta =)]                      'zch-gdb-print-dcptr)
(global-set-key [(meta +)]                      'zch-gdb-pstar-dcptr)
(global-set-key [(control meta +)]              'zch-gdb-ptype)

(global-set-key [(meta \,)]                     'zch-gdb-switch-window)

(global-set-key "\C-xga"                        'zch-gdb-assembler-buffer)
(global-set-key "\C-xgl"                        'zch-gdb-locals-buffer)
(global-set-key "\C-xgm"                        'zch-gdb-memory-buffer)
(global-set-key "\C-xgr"                        'zch-gdb-registers-buffer)
(global-set-key "\C-xgt"                        'zch-gdb-threads-buffer)
(global-set-key "\C-xgs"                        'zch-gdb-stack-buffer)
(global-set-key "\C-xgb"                        'zch-gdb-breakpoints-buffer)
(global-set-key "\C-xgi"                        'zch-gdb-inferior-io)
(global-set-key "\C-xgp"                        'zch-gdb-partial-output-buffer)
(global-set-key "\C-xgo"                        'zch-gdb-print-object)
(global-set-key "\C-xgy"                        'zch-gdb-ptype)

(global-set-key [(control meta shift mouse-1)]  'zch-gdb-ptype)
(global-set-key "\C-xgk"                        'zch-gdb-ptype-dcptr)
(global-set-key [(meta shift mouse-3)]          'zch-gdb-ptype-dcptr)
(global-set-key "\C-xgw"                        'gud-print)
(global-set-key [(control shift mouse-1)]       'gud-print)
(global-set-key "\C-xge"                        'gud-pstar)
(global-set-key [(control shift mouse-3)]       'gud-pstar)
(global-set-key "\C-xgd"                        'zch-gdb-print-dcptr)
(global-set-key [(control meta mouse-1)]        'zch-gdb-print-dcptr)
(global-set-key "\C-xgh"                        'zch-gdb-pstar-dcptr)
(global-set-key [(control meta mouse-3)]        'zch-gdb-pstar-dcptr)

;; ;; (load-library "multi-gdb-ui.el")
;; (defun gdb-or-gud-go ()
;;   "If gdb isn't running; run gdb, else call gud-go."
;;   (interactive)
;;   (if (and gud-comint-buffer
;; 		   (buffer-name gud-comint-buffer)
;; 		   (get-buffer-process gud-comint-buffer)
;; 		   (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba)))
;; 	  (gud-call (if gdb-active-process "continue" "run") "")
;; 	(gdb (gud-query-cmdline 'gdb))))
;; (defun gud-break-remove ()
;;   "Set/clear breakpoin."
;;   (interactive)
;;   (save-excursion
;; 	(if (eq (car (fringe-bitmaps-at-pos (point))) 'breakpoint)
;; 		(gud-remove nil)
;; 	  (gud-break nil))))
;; (defun gud-kill ()
;;   "Kill gdb process."
;;   (interactive)
;;   (with-current-buffer gud-comint-buffer (comint-skip-input))
;;   (kill-process (get-buffer-process gud-comint-buffer)))
;; (global-set-key [f5] 'gdb-or-gud-go)
;; ;; (global-set-key [S-f5] '(lambda () (interactive) (gud-call "quit" nil)))
;; (global-set-key [S-f5] 'gud-kill)
;; (global-set-key [f7] '(lambda () (interactive) (compile compile-command)))
;; (global-set-key [f8] 'gud-print)
;; (global-set-key [C-f8] 'gud-pstar)
;; (global-set-key [f9] 'gud-break-remove)
;; (global-set-key [f9] 'gud-break)
;; (global-set-key [C-f9] 'gud-remove)
;; (global-set-key [f10] 'gud-next)
;; (global-set-key [C-f10] 'gud-until)
;; (global-set-key [S-f10] 'gud-jump)
;; (global-set-key [f11] 'gud-step)
;; (global-set-key [C-f11] 'gud-finish)

(provide 'gud-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

;;; gud-setup.el ends here
