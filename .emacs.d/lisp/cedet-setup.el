;;; cedet-setup.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: cedet-setup.el,v 0.0 2014/08/25 10:25:32 szj0306 Exp $
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
;;   (require 'cedet-setup)

;;; Code:

;; 禁止emacs内部自带的cedet
;; (setq load-path (remove "e:/devtool/emacs/share/emacs/24.5/lisp/cedet" load-path))

;;; 添加Emacs搜索路径
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/cogre")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/common")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/contrib")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/ede")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/eieio")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/semantic")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/speedbar")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet-1.1/srecode")

(require 'cedet)
(require 'eieio-opt)

;;; If you plan to use EDE projects, then you need to switch on corresponding
;;; mode — it's implemented by EDE package:
(global-ede-mode t)

(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-guady-code-helpers)
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

;;; To use additional features for names completion, and displaying of information
;;; for tags & classes, you also need to load the semantic-ia package. This could be
;;; done with following command:
(require 'semantic-ia)

;;; If you're using GCC for programming in C & C++, then Semantic can automatically
;;; find path, where system include files are stored. To do this, you need to load
;;; semantic-gcc package with following command:
(require 'semantic-gcc)

;;; To optimize work with tags, you can use several techniques:
;;; * limit search by using an EDE project, as described below;
;;; * explicitly specify a list of root directories for your projects,
;;; so Semantic will use limited number of databases with syntactic information;
;;; * explicitly generate tags databases for often used directories
;;; (/usr/include, /usr/local/include, etc.) using commands
;;; semanticdb-create-ebrowse-database or semanticdb-create-cscope-database;
;;; * limit search by customization of the semanticdb-find-default-throttle
;;; variable for concrete modes — for example, don't use information from
;;; system include files, by removing system symbol from list of objects to search for c-mode:
(setq-mode-local c-mode semanticdb-find-default-throttle
				 '(project unloaded system recursive))

;;; If you're using standard procedure for loading of CEDET, then Semanticdb will
;;; be loaded automatically. Otherwise, you can load and enable it with following commands:
(require 'semanticdb)
(global-semanticdb-minor-mode 1)

;;; This mode, when enabled, displays function interface in the minibuffer:
(global-semantic-idle-summary-mode 1)

;;; When enable, this mode shows the function point is currently in at the first line of the current buffer. This is useful when you have a very long function that spreads more than a screen, and you don't have to scroll up to read the function name and then scroll down to original position.
(global-semantic-stickyfunc-mode 1)

;;; Besides this, Semanticdb can use databases generated by external utilities — gtags from
;;; GNU Global, ctags, ebrowse & cscope. To activate this you can use following code
;;; (please, note that these commands will fail if you have no utilities installed,
;;; or have an incorrect versions of them — that's why they a wrapped into when):
;;; if you want to enable support for gnu global
(when (cedet-gnu-global-version-check t)
  (require 'semanticdb-global)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode))

(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "//>")
      (hippie-expand nil)
    (indent-for-tab-command)
    ))

;; +BEGIN_HTML
;; (defadvice push-mark (around semantic-mru-bookmark activate)
;;   "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
;; If `semantic-mru-bookmark-mode' is active, also push a tag onto
;; the mru bookmark stack."
;;   (semantic-mrub-push semantic-mru-bookmark-ring
;;                       (point)
;;                       'mark)
;;   ad-do-it)

;; (defun semantic-ia-fast-jump-back ()
;;   (interactive)
;;   (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
;;       (error "Semantic Bookmark ring is currently empty"))
;;   (let* ((ring (oref semantic-mru-bookmark-ring ring))
;;          (alist (semantic-mrub-ring-to-assoc-list ring))
;;          (first (cdr (car alist))))
;;     (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
;;         (setq first (cdr (car (cdr alist)))))
;;     (semantic-mrub-switch-tags first)))

;; (defun semantic-ia-fast-jump-or-back (&optional back)
;;   (interactive "P")
;;   (if back
;;       (semantic-ia-fast-jump-back)
;;     (semantic-ia-fast-jump (point))))
;; (define-key semantic-mode-map [f12] 'semantic-ia-fast-jump-or-back)
;; (define-key semantic-mode-map [C-f12] 'semantic-ia-fast-jump-or-back)
;; (define-key semantic-mode-map [S-f12] 'semantic-ia-fast-jump-back)

;; +END_HTML

;; Enable code helpers.
(global-semantic-mru-bookmark-mode 1)

(defvar mru-tag-stack '()
  "Tag stack, when jumping to new tag, current tag will be stored here,
and when jumping back, it will be removed.")

(defun yc/store-mru-tag (pt)
  "Store tag info into mru-tag-stack"
  (interactive "d")
  (let* ((tag (semantic-mrub-find-nearby-tag pt)))
    (if tag
        (let ((sbm (semantic-bookmark (semantic-tag-name tag)
                                      :tag tag)))
          (semantic-mrub-update sbm pt 'mark)
          (add-to-list 'mru-tag-stack sbm)
          )
      (error "No tag to go!")))
  )

(defun yc/goto-func (pt)
  "Store current postion and call (semantic-ia-fast-jump)"
  (interactive "d")
  (yc/store-mru-tag pt)
  (semantic-ia-fast-jump pt)
)

(defun yc/goto-func-any (pt)
  "Store current postion and call (semantic-ia-fast-jump)"
  (interactive "d")
  (yc/store-mru-tag pt)
  (semantic-complete-jump)
  )

(defun yc/symref (pt)
  (interactive "d")
  (yc/store-mru-tag pt)
  (semantic-symref))

(defun yc/symref-symbol (pt)
  (interactive "d")
  (yc/store-mru-tag pt)
  (semantic-symref-symbol))

(defun yc/return-func()
  "Return to previous tag."
  (interactive)
  (if (car mru-tag-stack)
      (semantic-mrub-switch-tags (pop mru-tag-stack))
    (error "TagStack is empty!")))

;; (defun setup-program-keybindings()
;;   ;;;; Common program-keybindings
;;   (interactive)
;;   (local-set-key "\C-cR" 'yc/symref)
;;   (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
;;   (local-set-key "\C-c\C-j" 'yc/goto-func-any)
;;   (local-set-key "\C-cj" 'yc/goto-func)
;;   (local-set-key [S-f12] 'yc/return-func)
;;   (local-set-key [M-S-f12] 'yc/return-func)
;;   (local-set-key (kbd "C-x SPC") 'yc/store-mru-tag)
;;   )

;; Many libraries store all macro definitions in one or more include files, so you can use
;; these definitions as-is. To do this you need to list these files in the
;; semantic-lex-c-preprocessor-symbol-file variable, and when CEDET will perform analysis,
;; then values from these files will be used. By default, this variable has only one
;; value — file with definitions for C++ standard library, but you can add more data there.
;; As example, I want to show CEDET's configuration for work with Qt4:
;;;; C-mode-hooks .
(defun yyc/c-mode-keys ()
  "Common program-keybindings"
  ;; Semantic functions.
  (semantic-default-c-setup)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-cb" 'yc/return-func) ; 'semantic-ia-fast-jump-back) ;semantic-mrub-switch-tags)
  (local-set-key "\C-cR" 'yc/symref) ; 'semantic-symref)
  ;; (local-set-key "\C-cr" 'yc/symref-symbol) ; 'semantic-symref-symbol)
  (local-set-key "\C-c\C-j" 'yc/goto-func-any) ; 'semantic-ia-complete-jump)
  (local-set-key "\C-cj" 'yc/goto-func) ; 'semantic-ia-fast-jump)
  (local-set-key "\C-cp" 'semantic-ia-show-summary)
  (local-set-key "\C-cl" 'semantic-ia-show-doc)
  (local-set-key "\C-c/" 'semantic-ia-complete-symbol)
;;  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key (kbd "C-x SPC") 'yc/store-mru-tag)
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert)
  ;; Indent or complete
  (local-set-key  [(tab)] 'indent-or-complete)
  )
(add-hook 'c-mode-common-hook 'yyc/c-mode-keys)
(add-hook 'c++-mode-common-hook 'yyc/c-mode-keys)

(define-key c-mode-base-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)

(global-set-key [C-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;;;; Semantic DataBase存储位置
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semanticdb"))
(put 'upcase-region 'disabled nil)

(require 'eassist nil 'noerror)
(define-key c-mode-base-map [M-f12] 'eassist-switch-h-cpp)
(defun my-c-mode-common-hook ()
   (define-key c-mode-base-map (kbd "M-m") 'eassist-list-methods))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(setq eassist-header-switches
      '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
        ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
        ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
        ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
        ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
        ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
        ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
        ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
        ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
        ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
        ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
        ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("c" . ("h"))
        ("m" . ("h"))
        ("mm" . ("h"))))

;; 可视化书签
;; emacs有自带的书签功能(c-x r m, c-x r b, c-x r l)
;; F2 在当前行设置或取消书签
;; C-F2 查找下一个书签
;; S-F2 查找上一个书签
;; C-S-F2 清空当前文件的所有书签
(enable-visual-studio-bookmarks)

;; 代码折叠
(when (and window-system (require 'semantic-tag-folding nil 'noerror))
  (global-semantic-tag-folding-mode 1)
  (global-set-key (kbd "C-?") 'global-semantic-tag-folding-mode)
  (define-key semantic-tag-folding-mode-map (kbd "C-c , -") 'semantic-tag-folding-fold-block)
  (define-key semantic-tag-folding-mode-map (kbd "C-c , +") 'semantic-tag-folding-show-block)
  (define-key semantic-tag-folding-mode-map (kbd "C-_") 'semantic-tag-folding-fold-all)
  (define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-all))

;; 用pulse实现Emacs的淡入淡出效果
(require 'pulse)

(defadvice exchange-point-and-mark-nomark (after pulse-advice activate)
  "Cause the line that is `goto'd to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p)
			      (> (abs (- (point) (mark))) 400))
    (pulse-momentary-highlight-one-line (point))))
 
(defadvice switch-to-buffer (after pulse-advice activate)
  "Cause the current line of new buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
 
(defadvice ido-switch-buffer (after pulse-advice activate)
  "Cause the current line of new buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
 
(defadvice switch-to-other-buffer (after pulse-advice activate)
  "Cause the current line of new buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
 
(defadvice visit-.emacs (after pulse-advice activate)
  "Cause the current line of .emacs buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
 
(defadvice beginning-of-buffer (after pulse-advice activate)
  "Cause the current line of buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
 
(pulse-toggle-integration-advice (if window-system 1 -1))

(require 'cedet-prj)

(provide 'cedet-setup)
(eval-when-compile
  (require 'cl))


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

;;; cedet-setup.el ends here
