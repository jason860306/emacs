;;; cedet-prj.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: cedet-prj.el,v 0.0 2014/08/28 03:20:56 szj0306 Exp $
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
;;   (require 'cedet-prj)

;;; Code:

(require 'source-path)

;;; You can also explicitly specify additional paths for look up of include files
;;; (and these paths also could be different for specific modes). To add some path
;;; to list of system include paths, you can use the semantic-add-system-include
;;; command, that accepts two parameters — string with path to include files, and
;;; symbol, representing name of major mode, for which this path will used.
;;; For example, to add Boost header files for C++ mode, you need to add following code:
(setq cedet-user-include-dirs (append user-head-file-dir user-source-file-dir))
(setq cedet-sys-include-dirs (append sys-head-file-dir sys-source-file-dir))
(setq cedet-include-dirs (append cedet-user-include-dirs cedet-sys-include-dirs))
(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))
;; (setq semantic-c-dependency-system-include-path cedet-include-dirs)

;; 如果semantic不能正确解析系统头文件，可尝试下面两种方法
;; 1.(add-to-list 'semantic-lex-c-preprocessor-symbol-file "/home/foo/project/a.h")，semantic正确解析某些特殊的宏
;; 2.(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("SOMESYMBOL" . "")),semantic忽略掉某些特殊的宏
;; M-x semantic-analyze-current-context 检查semantic解析是否正确
;; semantic把解析的内容分为variable，function， include
;; 定义的宏和变量被归为varialble，函数归为fucntion， include归为include
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("__wur" . ""))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file cedet-include-dirs)

;; (ede-cpp-root-project "test_code"
;; 					  :file "/home/szj0306/Documents/mycode/test_code/t1.c"
;; 					  :include-path '("/common"
;; 									  "/fun_a")
;; 					  :system-include-path cedet-include-dirs)

(provide 'cedet-prj)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; cedet-prj.el ends here
