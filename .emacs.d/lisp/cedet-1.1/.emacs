;; (defconst my-emacs-path           "E:/develop tools/emacser/emacs-24.2/" "我的emacs相关配置文件的路径")
;; (defconst my-emacs-my-lisps-path  (concat my-emacs-path "lisp/") "我自己写的emacs lisp包的路径")
;; (defconst my-emacs-lisps-path     (concat my-emacs-path "site-lisp/") "我下载的emacs lisp包的路径")

;; ;; 把`my-emacs-lisps-path'的所有子目录都加到`load-path'里面
;; (load (concat my-emacs-my-lisps-path "my-subdirs"))
;; (my-add-subdirs-to-load-path my-emacs-my-lisps-path)
;; (my-add-subdirs-to-load-path my-emacs-lisps-path)
;; (my-add-subdirs-to-load-path "~/.emacs.d")
;; (add-to-list 'load-path (concat my-emacs-my-lisps-path "cedet"))
;; 
;; (require 'cedet-settings)

(add-to-list 'load-path "/home/szj0306/Documents/emacser/cedet-1.1/")
(add-to-list 'load-path "/home/szj0306/Documents/emacser/cedet-1.1/common/")
(add-to-list 'load-path "/home/szj0306/Documents/emacser/cedet-1.1/semantic")
(add-to-list 'load-path "/home/szj0306/Documents/emacser/cedet-1.1/semantic/bovine")
(require 'cedet)

(global-ede-mode t)

;; ;;;;  Helper tools.
;; (custom-set-variables '(semantic-default-submodes
;; 			(quote (global-semantic-decoration-mode
;; 				global-semantic-idle-completions-mode
;; 				global-semantic-idle-scheduler-mode
;; 				global-semanticdb-minor-mode
;; 				global-semantic-idle-summary-mode
;; 				global-semantic-mru-bookmark-mode)))
;; 		      '(semantic-idle-scheduler-idle-time 3))
;; (semantic-mode)

;; smart complitions
(require 'semantic-ia)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

;;;; Include settings
(require 'semantic-gcc)
(require 'semantic-c)

(defconst cedet-user-include-dirs
  (list "/home/szj0306/Documents/projects/p2p_server/branches/taishan/server/srvframe/include"
		"/home/szj0306/Documents/boost_1_51_0"))

(setq cedet-sys-include-dirs (list
                              "/usr/include"
                              "/usr/include/bits"
							  "/usr/local/include"
							  "/usr/src"))

(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(setq semantic-c-dependency-system-include-path "/usr/include")

;;;; TAGS Menu
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))

(add-hook 'semantic-init-hooks 'my-semantic-hook)

;;;; Semantic DataBase存储位置
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semanticdb"))

;; 使用 gnu global 的TAGS。
(require 'semanticdb-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)

;;;;  缩进或者补齐
;;; hippie-try-expand settings
(setq hippie-expand-try-functions-list
      '(
        yas/hippie-try-expand
        semantic-ia-complete-symbol
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs))

(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "//>")
      (hippie-expand nil)
    (indent-for-tab-command)
    ))

(defun yyc/indent-key-setup ()
  "Set tab as key for indent-or-complete"
  (local-set-key  [(tab)] 'indent-or-complete)
  )

;; ;;;; C-mode-hooks .
;; (defun yyc/c-mode-keys ()
;;   "description"
;;   ;; Semantic functions.
;;   (semantic-default-c-setup)
;;   (local-set-key "/C-c?" 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "/C-cb" 'semantic-mrub-switch-tags)
;;   (local-set-key "/C-cR" 'semantic-symref)
;;   (local-set-key "/C-cj" 'semantic-ia-fast-jump)
;;   (local-set-key "/C-cp" 'semantic-ia-show-summary)
;;   (local-set-key "/C-cl" 'semantic-ia-show-doc)
;;   (local-set-key "/C-cr" 'semantic-symref-symbol)
;;   (local-set-key "/C-c/" 'semantic-ia-complete-symbol)
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;   (local-set-key "." 'semantic-complete-self-insert)
;;   (local-set-key ">" 'semantic-complete-self-insert)
;;   ;; Indent or complete
;;   (local-set-key  [(tab)] 'indent-or-complete)
;;   )
;; (add-hook 'c-mode-common-hook 'yyc/c-mode-keys)

(global-set-key [f12] 'semantic-ia-fast-jump)
;; (global-set-key [S-f12]
;;                 (lambda ()
;;                   (interactive)
;;                   (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
;;                       (error "Semantic Bookmark ring is currently empty"))
;;                   (let* ((ring (oref semantic-mru-bookmark-ring ring))
;;                          (alist (semantic-mrub-ring-to-assoc-list ring))
;;                          (first (cdr (car alist))))
;;                     (if (semantic-equivalent-tag-p (oref first tag)
;;                                                    (semantic-current-tag))
;;                         (setq first (cdr (car (cdr alist)))))
;;                     (semantic-mrub-switch-tags first))))

(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
(add-hook 'c-mode-common-hook 'my-cedet-hook)

;; (defadvice push-mark (around semantic-mru-bookmark activate)
;;   "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
;; If `semantic-mru-bookmark-mode' is active, also push a tag onto
;; the mru bookmark stack."
;;   (semantic-mrub-push semantic-mru-bookmark-ring
;;                       (point)
;;                       'mark)
;;   ad-do-it)
