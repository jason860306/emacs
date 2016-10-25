;; color-theme for emacs24
;;
;; (deftheme szj0306-emacs-theme "szj0306 custom emacs-theme")
;; (custom-theme-set-faces
;;   'szj0306-emacs-theme
;;   '(default ((t (:foreground "#b0b0b0" :background "#000000"))))
;;   '(cursor ((t (:background "#f3f3f2"))))
;;   '(fringe ((t (:background "#2e3333"))))
;;   '(mode-line ((t (:foreground "#e6e641" :background "#363f3e"))))
;;   '(region ((t (:background "#19698f"))))
;;   '(font-lock-builtin-face ((t (:foreground "#aa231d"))))
;;   '(font-lock-comment-face ((t (:foreground "#0d5903"))))
;;   '(font-lock-function-name-face ((t (:foreground "#871217"))))
;;   '(font-lock-keyword-face ((t (:foreground "#1624e3"))))
;;   '(font-lock-string-face ((t (:foreground "#8d1c1e"))))
;;   '(font-lock-type-face ((t (:foreground"#2037df"))))
;;   '(font-lock-constant-face ((t (:foreground "#d41ded"))))
;;   '(font-lock-variable-name-face ((t (:foreground "#d0d0cd"))))
;;   '(minibuffer-prompt ((t (:foreground "#f2f2f3" :bold t))))
;;   '(font-lock-warning-face ((t (:foreground "red" :bold t))))
;;   )
;; (provide-theme 'szj0306-emacs-theme)

;; color-theme for emacs that version is smaller than 24
;;
(eval-when-compile    (require 'color-theme))
(defun szj0306-emacs-theme ()
  "Color theme by szj0306, created 2013-09-03."
  (interactive)
  (color-theme-install
   '(szj0306-emacs-theme
	 ((background-color . "#000000")
      (background-mode . light)
      (border-color . "#2e3333")
      (cursor-color . "#f3f3f2")
      (foreground-color . "#b0b0b0")
      (mouse-color . "black"))
     (fringe ((t (:background "#2e3333"))))
     (mode-line ((t (:foreground "#e6e641" :background "#363f3e"))))
     (region ((t (:background "#19698f"))))
     (font-lock-builtin-face ((t (:foreground "#aa231d"))))
     (font-lock-comment-face ((t (:foreground "#0d5903"))))
     (font-lock-function-name-face ((t (:foreground "#871217"))))
     (font-lock-keyword-face ((t (:foreground "#1624e3"))))
     (font-lock-string-face ((t (:foreground "#8d1c1e"))))
     (font-lock-type-face ((t (:foreground"#2037df"))))
     (font-lock-constant-face ((t (:foreground "#d41ded"))))
     (font-lock-variable-name-face ((t (:foreground "#d0d0cd"))))
     (minibuffer-prompt ((t (:foreground "#f2f2f3" :bold t))))
     (font-lock-warning-face ((t (:foreground "red" :bold t))))
     )))
(add-to-list 'color-themes '(szj0306-emacs-theme  "szj0306-emacs-theme" "szj0306"))
;; (provide 'szj0306-emacs-theme)