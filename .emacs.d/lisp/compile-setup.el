;;; compile-setup.el --- 

;; Copyright 2014 szj0306
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: compile-setup.el,v 0.0 2014/10/31 04:04:38 szj0306 Exp $
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
;;   (require 'compile-setup)

;;; Code:
(require 'devcomm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; compile
;; 编译定制
(setq compile-command "make -j 3 cd=true d=true")

(defun zch-file-name (name)
  "获得文件名，返回结果不包括路径和扩展名"
  (setq fields (split-string name "/"))
  (setq name (elt fields (- (length fields) 1)))
  (setq len (length name))
  (setq i len)
  (setq ch "")
  (while (and (> i 0) (not (string= ch ".")))
    (progn
      (setq ch (substring name (- i 1) i))
      (setq i (- i 1))))
  (setq name (substring name 0 i)))

(defun zch-onekey-compile ()
  "先保存所有文件，然后编译程序，不包括测试程序"
  (interactive)
  (save-some-buffers t)
  (compile compile-command))

(defun zch-onekey-compile-test()
  "先保存所有文件，然后编译程序，包括当前的测试程序"
  (interactive)
  (save-some-buffers t)
  (setq temp compile-command)
  (setq command compile-command)
  (setq extension (zch-file-extension buffer-file-name))
  (setq test-name nil)
  (setq type nil)

  (if (or (string= extension "ct") (string= extension "ce"))
      (setq zch-compile-test-file buffer-file-name))
  (if (not (string= zch-compile-test-file ""))
      (setq extension (file-name-extension zch-compile-test-file)))

  ;;如果是.ct或者.ce文件，修改测试名字
  (cond
   ((string= extension "ct")   (setq type " t="))
   ((string= extension "ce")   (setq type " e=")))

  (if (string= zch-compile-test-file "")
      (setq command compile-command)
    (progn
      (setq test-name (zch-file-name zch-compile-test-file))
      (setq command (concat compile-command type test-name))))
  
  (compile command)
  (setq compile-command temp))

(defun zch-compile-clean ()
  "在编译命令之后加上clean,清除完了再恢复原来的编译命令"
  (interactive)
  (save-some-buffers t)
  (setq temp compile-command)
  (compile (concat compile-command " clean"))
  (setq compile-command temp))

(defun zch-compile-get-param(name)
  "获得编译命令里的参数值"
  (let ((fields)(ret))
    (setq fields (split-string compile-command " "))
    (while fields
      (setq param (car fields))
      (setq pair (split-string param "="))
      (setq key (car pair))

      (if (and (eq (length pair) 2) (string= key name))
          (progn
            (setq val (cdr pair))
            (setq ret (car val))
            (setq fields nil))
        (setq fields (cdr fields)))
      )
    (if (and (string= window-system "w32") (string= name "p"))
        (setq ret "msw")
      (setq ret ret))))

(defun zch-compile-test-prefix()
  "获得工程的测试目录，这个目录根据编译参数产生"
  (let ((p)(ret))
    (setq p (zch-compile-get-param "p"))
    (if (not p)
        (setq p "linux"))
    (setq d (zch-compile-get-param "d"))
    (if (and d (string= d "true"))
        (setq ret (concat (dnc-project-name) "-d." p))
      (setq ret (concat  (dnc-project-name) "." p)))
    ))

(defun zch-compile-run-command()
  "获得测试程序的路径和名称，使用这个名称可以直接运行"
  (let ((p)(ret)(dir-spliter))
    (setq p (zch-compile-get-param "p"))
    (if (string= window-system "w32")
        (setq dir-spliter "\\")
      (setq dir-spliter "/"))
    
    (if (string= "ct" (file-name-extension zch-compile-test-file))
        (setq ret (concat ".."dir-spliter"test"dir-spliter (zch-compile-test-prefix) "."
                          (zch-file-name zch-compile-test-file) ".ct"))
      (setq ret (concat ".."dir-spliter"bin"dir-spliter (zch-file-name zch-compile-test-file))))
    
    (if (string= "msw" p)
        (setq ret (concat ret ".exe")))
    
    (setq ret ret)
    ))

(defun zch-compile-run ()
  "编译并运行编译好的程序"
  (interactive)
  (save-some-buffers t)
  (setq temp compile-command)
  (setq extension (zch-file-extension buffer-file-name))
  (setq test-name nil)
  (setq type nil)

  (if (or (string= extension "ct") (string= extension "ce"))
      (setq zch-compile-test-file buffer-file-name))
  (if (not (string= zch-compile-test-file ""))
      (setq extension (file-name-extension zch-compile-test-file)))
  
  ;;如果是.ct或者.ce文件，修改测试名字
  (cond
   ((string= extension "ct") (setq type " t="))
   ((string= extension "ce") (setq type " e=")))
  
  (if (string= zch-compile-test-file "")
      (setq command compile-command)
    (progn
      (setq test-name (zch-file-name zch-compile-test-file))
      (setq command (concat compile-command type test-name))
      (setq command (concat command " && " (zch-compile-run-command)))
      (setq command (concat command " " zch-compile-test-args))))
  (compile command)
  (setq compile-command temp))

(setq zch-compile-run-any-command "gcc")
(defun zch-compile-run-any ()
  "编译任意的单个文件并运行编译好的程序"
  (interactive)
  (save-some-buffers t)
  (setq temp compile-command)
  (setq test-name nil)
  (setq type nil)
  (setq extension (file-name-extension buffer-file-name))
  (setq run-name (zch-file-name buffer-file-name))
  (setq run-file (concat run-name "." extension))
  
  (setq command (concat zch-compile-run-any-command " -o " run-name " " run-file))
  (setq command (concat command " && ./" run-name))
  (setq command (concat command " " zch-compile-test-args))
  
  (compile command)
  (setq compile-command temp))

(defun zch-compile-gccsense ()
  "使用gccsense编译所有文件，然后使得成员提示会起作用"
  (interactive)
  (save-some-buffers t)
  (setq temp compile-command)
  (compile "make gccsense")
  (setq compile-command temp))

(defun zch-modify-compile-run-any-command(command)
  "修改zch-compile-run-any命令所使用的编译命令"
  (interactive
   (list (read-from-minibuffer "Modify compile run any command: "
                               (eval zch-compile-run-any-command) nil nil))
   (list (eval zch-compile-run-any-command)))
  (setq zch-compile-run-any-command command))

(defun zch-compile-test-all()
  "编译所有测试程序并且运行它们"
  (interactive)
  (save-some-buffers t)
  (setq temp compile-command)
  (compile (concat compile-command " args=\"" zch-compile-test-args "\" test"))
  (setq compile-command temp))

(defun zch-compile-exe-all()
  "编译所有可执行程序"
  (interactive)
  (save-some-buffers t)
  (setq temp compile-command)
  (compile (concat compile-command " exe"))
  (setq compile-command temp))


(defun zch-compile-modify-test-args(args)
  "修改测试程序的参数"
  (interactive
   (list (read-from-minibuffer "Modify test arguments: "
                               (eval zch-compile-test-args) nil nil))
   (list (eval zch-compile-test-args)))
  (setq zch-compile-test-args args))


(defun zch-modify-compile-command(command)
  "修改编译命令compile-command，并且执行编译"
  (interactive
   (list (read-from-minibuffer "Modify compile command: "
                               (eval compile-command) nil nil
                               '(compile-history . 1)))
   (list (eval compile-command)))
  (save-some-buffers t)
  (compile command))

(defun zch-compile-modify-test (command)
  "修改测试单元zch-compile-test-file，并且执行编译和程序"
  (interactive
   (list (read-from-minibuffer "Modify test unit: "
                               (eval zch-compile-test-file) nil nil))
   (list (eval zch-compile-test-file)))
  (setq zch-compile-test-file command)
  (zch-compile-run))

(global-set-key "\C-xct" 'zch-onekey-compile-test)
(global-set-key "\C-xco" 'zch-compile-run)
(global-set-key "\C-xcu" 'zch-compile-run-any)
(global-set-key "\C-xcc" 'zch-onekey-compile)
(global-set-key "\C-xca" 'zch-compile-test-all)
(global-set-key "\C-xcl" 'zch-compile-clean)
(global-set-key "\C-xcm" 'zch-modify-compile-command)
(global-set-key "\C-xcw" 'zch-modify-compile-run-any-command)
(global-set-key "\C-xcj" 'sC-czch-compile-modify-test)
(global-set-key "\C-xci" 'zch-compile-modify-test-args)
(global-set-key "\C-xce" 'zch-compile-exe-all)
(global-set-key "\C-xcg" 'zch-compile-gccsense)

(provide 'compile-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; compile-setup.el ends here
