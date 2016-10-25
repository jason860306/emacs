;;; shell-setup.el --- 

;; Copyright 2016 
;;
;; Author: Ö¾½Ü@SZJ0306-PC
;; Version: $Id: shell-setup.el,v 0.0 2016/06/08 10:49:37 Ö¾½Ü Exp $
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
;;   (require 'shell-setup)

;;; Code:

;; Set Windows-specific preferences if running in a Windows environment.
(defun udf-windows-setup () (interactive)
  ;; The variable `git-shell-path' contains the path to the `Git\bin'
  ;; file on my system. I install this in
  ;; `%USERPROFILE%\LocalAppInfo\apps\Git\bin'.
  (setq git-shell-path
        (concat (getenv "USERPROFILE") "\\LocalAppInfo\\apps\\Git\\bin"))
  (setq git-shell-executable
        (concat git-shell-path "\\bash.exe"))
  (add-to-list 'exec-path git-shell-path)
  (setenv "PATH"
          (concat git-shell-path ";"
                  (getenv "PATH")))
  (message "Windows preferences set."))

(if (eq system-type 'windows-nt)
    ;; (udf-windows-setup))
	(progn
	  ;; (setq explicit-shell-file-name "e:/os/gow/bin/bash.exe")
	  (setq explicit-shell-file-name "C:/Program Files (x86)/Git/bin/sh.exe")
	  (setq shell-file-name "bash")
	  (setq explicit-sh.exe-args '("--login" "-i"))
	  (setenv "SHELL" shell-file-name)
	  (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))

(provide 'shell-setup)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; shell-setup.el ends here
