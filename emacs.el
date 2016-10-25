

;; 修正windos emacs find-grep 输出NULL
;; Prevent issues with the Windows null device (NUL)
;; when using cygwin find with rgrep.
(if (equal system-type 'windows-nt)
    (progn
      (defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
        "Use cygwin's /dev/null as the null-device."
        (let ((null-device "/dev/null"))
          ad-do-it))
      (ad-activate 'grep-compute-defaults)))

;; 中英文字体配置

;; monaco-11,YaHei-18 org-mode 表格不会乱,2个英文字宽 = 1个中文字宽
(if (equal system-type 'windows-nt)
    (progn
      (set-frame-font "Monaco-11")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family "Microsoft Yahei" :size 18)))
  ))
(if (equal system-type 'gnu/linux)
    (progn
      (set-frame-font "Monaco-10")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family "Microsoft Yahei" :size 16)))
      ))


; 在emacs中执行make,gdb调试找不到交叉编译程序

;; add cross compile paht to emacs exec path
;; 添加交叉编译环境变量
(setenv "PATH" (concat "/usr/local/CodeSourcery/Sourcery_G++_Lite/bin/:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/CodeSourcery/Sourcery_G++_Lite/bin/" exec-path))

 

;; 禁止emacs23.2内部自带的cedet
(setq load-path (remove "/usr/share/emacs/cedet" load-path))
(setq load-path (remove "/usr/share/emacs/23.2/lisp/cedet" load-path));;C-h v load-path 检查是否去掉emacs内置cedet
(require 'cedet)
;; (load-file "~/.emacs.d/plugins/cedet-1.0/common/cedet.el")
(require 'ecb)
(require 'semantic-ia)
;; 最基本功能
;; semantic-idle-scheduler-mode,enable这个mode让cedet在emacs空闲的时候自动分析buffer内容
;; semantic-minor-mode,semanticdb是semantic用来保存分析后的内容的，所以也是应该enable的
;; semanticdb-load-ebrowse-caches,Load all semanticdb controlled EBROWSE caches.
;; (semantic-load-enable-minimum-features)

;; imenu,imenu显示semantic分析出的类，函数等tags
;; semantic-idle-summary-mode,光标停留在一个类/函数等tag上时，会在minibuffer显示出这个函数原型
;; senator-minor-mode,在emacs上增加一个senator的菜单
;; semantic-mru-bookmark-mode 支持跳转
;; (semantic-load-enable-code-helpers)
;; (semantic-load-enable-code-helpers)

;; semantic-stickyfunc-mode
;; 这个mode会根据光标位置把当前函数名显示在buffer顶上
;; semantic-decoration-mode
;; 打开这个mode后，semantic会在类/函数等tag上方加一条蓝色的线，
;; 源文件很大的时候用它可以提示出哪些是类和函数的头。
;; semantic-idle-completions-mode
;; 这个mode打开后，光标在某处停留一段时间后，semantic会自动提示此处可以补全的内容。
;; (semantic-load-enable-guady-code-helpers)
(semantic-load-enable-guady-code-helpers)
(global-semantic-highlight-func-mode 1)
;; (global-semantic-idle-local-symbol-highlight-mode 1)
(global-semantic-show-parser-state-mode 1)
(global-semantic-idle-summary-mode 0)

;; semantic-highlight-func-mode
;; 打开这个mode的话，semantic会用灰的底色把光标所在函数名高亮显示，
;;global-semantic-idle-local-symbol-highlight-mode
;; 用过XCode或eclipse的人应该会喜欢高亮光标处变量的功能：就是在函数内部，光标停留在一个变量上，整个函数内部用这个变量的地方都高亮了。在 emacs里只要打开semantic-idle-tag-highlight-mode，光标在变量处停留一会，就会把相同的变量全都高亮
;; semantic-decoration-on-*-members
;; 把private和protected的函数用颜色标识出来
;; which-func-mode
;; 这个其实就是emacs自带的which-function-mode，把光标当前所在的函数名显示在mode-line上
;; (semantic-load-enable-excessive-code-helpers)

;; semantic-highlight-edits-mode
;; 打开这个mode后，emacs会把最近修改过的内容高亮出来
;; semantic-show-unmatched-syntax-mode
;; 这个mode会把semantic解析不了的内容用红色下划线标识出来
;; semantic-show-parser-state-mode
;; 打开这个mode，semantic会在modeline上显示出当前解析状态
;; 未解析时显示为”!”，正在解析时显示”@”，解析完后显示”-”，如果buffer修改后未重新解析显示为”^”
;; semantic会在空闲时自动解析，另外可以打开senator-minor-mode，按[C-c , ,]或者在senator菜单中选[Force Tag Refresh]强制它马上解析。
;; (semantic-load-enable-semantic-debugging-helpers)

;; (global-srecode-minor-mode 1)
(global-semantic-mru-bookmark-mode 1)
(require 'semantic-decorate-include)

;;semanticdb 设置
;; 优化tags功能有几个方法
;; 1.声明ede项目来限制semantic的搜索
;; 2.显式的声明所有项目根文件夹
;; 3.使用semanticdb-create-ebrowse or semantic-create-cscope-database
;; 创建databases为常用的文件夹(/usr/include,/usr/local/include,etc)
;; 4.自定义semanticdb-find-default-throttle变量为某个xx-mode
;; 例如c-mode时，不使用系统include file
;; (setq-mode-local c-mode semanticdb-find-default-throttle
;;                             '(project unloaded system recursive))

(require 'semanticdb)
(setq semanticdb-default-save-directory
       (expand-file-name "~/.emacs.d/.semanticdb"))

;;设置 throttle，semantic按照指定的顺序查找头文件
(setq-mode-local c-mode
            semanticdb-find-default-throttle
            '(file local project unloaded system recursive))
;; 避免semantic占用CPU过多,单位second
(setq-default semantic-idle-scheduler-idle-time 600)
;; (setq semanticdb-search-system-databases t)
;; ;; 设置semanticdb的默认路径
;; (setq semanticdb-default-system-save-directory "~/.semanticdb")

;; project root path,检索/usr/include
;; (setq semanticdb-project-roots
;;           (list
;;         (expand-file-name "/")))

;; (semantic-load-enable-all-exuberent-ctags-support)
;; (semanticdb-enable-exuberent-ctags 'c-mode)
;; (semanticdb-enable-exuberent-ctags 'c++-mode)

;; if you want to enable support for gnu global
(require 'semanticdb-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)

;;;;C/C++语言启动时自动加载semantic对/usr/include的索引数据库,
;; (setq semanticdb-search-system-databases t)
;;    (add-hook 'c-mode-common-hook                         
;;            (lambda ()                                    
;;              (setq semanticdb-project-system-databases   
;;                    (list (semanticdb-create-database     
;;                             semanticdb-new-database-class
;;                             "/usr/include")))))          

;; Include settings, cedet能找系统头文件到并跳转到头文件
;; M-x semantic-c-describe-environment 查看当前系统c头文件路径
(require 'semantic-gcc)
(setq semanticdb-project-roots (list (expand-file-name "/")))
;; 很多工程中都会把头文件和实现文件分开放置，比如头文件放在include(或者inc,public,common等)目录中，
;; 实现文件放在src目录中，这些目录semantic是不能自己找的,解决方法
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "." "./include"
        "../.." "../../include" "../../inc" "../../common" "../../public"))

;; C-h v semantic-dependency-system-include-path : defines the system include path
;; C-h v semantic-c-dependency-system-include-path:system include path used by the C language.
(defconst cedet-sys-include-dirs
  (list        "/usr/include/c++/4.4"
               "/usr/include/c++/4.4/i486-linux-gnu"
               "/usr/include/c++/4.4/backward"
               "/usr/local/include"
               "/usr/lib/gcc/i486-linux-gnu/4.4.5/include"
               "/usr/lib/gcc/i486-linux-gnu/4.4.5/include-fixed"
               "/usr/include"))
;; semantic-add-system-include 根据mode把路径加入到semantic-dependency-system-include-path里
(let ((include-dirs cedet-user-include-dirs))
  (when (eq system-type 'gnu/linux)
    (setq include-dirs (append include-dirs cedet-sys-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(setq semantic-c-dependency-system-include-path
      (list
               "/usr/include/c++/4.4"
               "/usr/include/c++/4.4/i486-linux-gnu"
               "/usr/include/c++/4.4/backward"
               "/usr/local/include"
               "/usr/lib/gcc/i486-linux-gnu/4.4.5/include"
               "/usr/lib/gcc/i486-linux-gnu/4.4.5/include-fixed"
               "/usr/include"))

(setq cedet-sys-include-dirs (list
                              "/usr/include/c++/4.4"
                              "/usr/include/c++/4.4/i486-linux-gnu"
                              "/usr/include/c++/4.4/backward"
                              "/usr/local/include"
                              "/usr/lib/gcc/i486-linux-gnu/4.4.5/include"
                              "/usr/lib/gcc/i486-linux-gnu/4.4.5/include-fixed"
                              "/usr/include"
                              "/usr/include/bits"
                              "/usr/include/glib-2.0"
                              "/usr/include/gnu"
                              "/usr/include/gtk-2.0"
                              "/usr/include/gtk-2.0/gdk-pixbuf"
                              "/usr/include/gtk-2.0/gtk"
                              "/usr/local/include"
                              "/usr/local/include"))

;; 如果semantic不能正确解析系统头文件，可尝试下面两种方法
;; 1.(add-to-list 'semantic-lex-c-preprocessor-symbol-file "/home/foo/project/a.h")，semantic正确解析某些特殊的宏
;; 2.(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("SOMESYMBOL" . "")),semantic忽略掉某些特殊的宏
;; M-x semantic-analyze-current-context 检查semantic解析是否正确
;; semantic把解析的内容分为variable，function， include
;; 定义的宏和变量被归为varialble，函数归为fucntion， include归为include
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("__wur" . ""))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file  "/usr/lib/gcc/i486-linux-gnu/4.4.5/include")
(add-to-list 'semantic-lex-c-preprocessor-symbol-file  "/usr/include/sys/cdefs.h")

(defconst cedet-win32-include-dirs
  (list "D:/TDMMinGW/include"
        "D:/TDMMinGW/lib/gcc/mingw32/4.3.3/include/c++/backward"
        "D:/TDMMinGW/lib/gcc/mingw32/4.3.3/include/c++/mingw32"
        "D:/TDMMinGW/lib/gcc/mingw32/4.3.3/include/c++"
        "D:/TDMMinGW/lib/gcc/mingw32/4.3.3/include"
        "D:/TDMMinGW/lib/gcc/mingw32/4.3.3"

;;        "C:/Program Files/Microsoft Visual Studio/VC98/MFC/Include"
        ))
(require 'semantic-c nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (when (eq system-type 'windows-nt)
    (setq include-dirs (append include-dirs cedet-win32-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(setq ecb-tip-of-the-day nil)
(add-hook 'texinfo-mode-hook (lambda () (require 'sb-texinfo)))
;; Integration with imenu with a list of functions, variables, and other tags.

;; (autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
;; (autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
;; (define-key-after (lookup-key global-map [menu-bar tools])
;;   [speedbar]
;;   '("Speedbar" .
;;     speedbar-frame-mode)
;;   [calendar])

(setq ecb-auto-activate nil
      ecb-tip-of-the-day nil
      ecb-tree-indent 4
      ecb-windows-height 0.5
      ecb-windows-width 0.13)
(if (eq system-type 'windows-nt)
    (progn
    '(ecb-gzip-setup (quote ("d:\\cygwin\\bin\\gzip.exe" . windows)))
    '(ecb-wget-setup (quote ("d:\\cygwin\\bin\\wget.exe" . windows)))
    '(ecb-tar-setup (quote ("d:\\cygwin\\bin\\tar.exe" . windows)))))

;; solve problem "Variable binding depth exceeds max-specpdl-size",
;; default value is 1080
(setq max-specpdl-size 34000)
(setq max-lisp-eval-depth 20000)

;; semantic auto complete
(semantic-load-enable-code-helpers)
(autoload 'senator-try-expand-semantic "senator")
;; (global-set-key (kbd "M-/") 'semantic-ia-complete-symbol-menu)
(global-set-key (kbd "M-/") 'semantic-ia-complete-symbol)
(eval-after-load "semantic-complete"
  '(setq semantic-complete-inline-analyzer-displayor-class
         semantic-displayor-ghost))
; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (setq semantic-ectag-program "~/bin/ctags.exe")
(semantic-load-enable-primary-exuberent-ctags-support)
;;
(defun cedet-hook ()
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cr" 'semantic-symref-symbol))

(add-hook 'c-mode-common-hook 'cedet-hook)
(add-hook 'lisp-mode-hook 'cedet-hook)
;; (add-hook 'scheme-mode-hook 'cedet-hook)
;; (add-hook 'emacs-lisp-mode-hook 'cedet-hook)
(add-hook 'python-mode-hook 'cedet-hook)

(global-set-key (kbd "C-.") 'semantic-ia-fast-jump)
(global-set-key (kbd "C-,") 'semantic-mrub-switch-tags)
;; (defun my-c-mode-cedet-hook ()
;;  (local-set-key "." 'semantic-complete-self-insert)
;;  (local-set-key ">" 'semantic-complete-self-insert))
;; (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(global-set-key (kbd "") 'ecb-activate)
(global-set-key (kbd "ESC ") 'ecb-deactivate)

;; (custom-set-variables
;;   ;;设置系统包含路径
;;  '(semantic-c-dependency-system-include-path (quote ("/usr/include" "/usr/include/gtk-2.0" "/usr/include/glib-2.0"))))

;; (setq qt4-base-dir "/usr/include/qt4")                                                             ;;
;; (semantic-add-system-include qt4-base-dir 'c++-mode)                                                 ;;
;; (add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))                                         ;;
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))         ;;
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-dist.h")) ;;
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h"))         ;;

;; ede customization
(require 'semantic-lex-spp)
(global-ede-mode 1)
(setq ede-locate-setup-options
      '(ede-locate-global
        ede-locate-base))
;;2. 全局关闭cedet #if #else 智能分析
(setq semantic-c-obey-conditional-section-parsing-flag nil)

;; (setq test-project
;;       (ede-cpp-root-project "test"
;;                             :file "~/test/Makefile"
;;                             :system-include-path '("/test/include"
;;                                                    "/usr/include/boost-1.42")))
;; ede-cpp-root-project指定了这个项目的其他信息：                                    
;; :file 指向项目主目录下任一一个存在的文件                                        
;; :include-path 指定头文件的所在目录                                                 ;; :spp-table 给出了预处理时的使用的宏，通常是在Makefile里使用-DXXX定义的宏，例如这里的__XEN__。 ;;

;; 代码折叠用
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)

