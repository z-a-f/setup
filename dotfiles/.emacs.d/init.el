;; -*- mode: emacs-lisp -*-
;; Zafar Takhirov Configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
;; (add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/.elisp")
(add-to-list 'load-path "~/.emacs.d/.escript")
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)
(ido-mode t)
(menu-bar-mode -1)
(normal-erase-is-backspace-mode 1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
<<<<<<< HEAD
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 98 :width normal :family "DejaVu LGC Sans Mono" :foundry "unknown"))))
=======
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 113 :width normal :family "fixed" :foundry "misc"))))
>>>>>>> 89fcca3e85295477d6abe6cabc4d7e59c30654e2
 '(column-marker-1 ((t (:background "red"))) t)
 '(diff-added ((t (:foreground "cyan"))) t)
 '(flymake-errline ((((class color) (background light)) (:background "Red"))) t)
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))) t)
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:background "white" :foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light)) (:background "black"))))
 '(vertical-border ((t nil))))

;; ---------------
;; -- Functions --
;; ---------------
(defun toggle-comment-on-line()
  "Comment/Uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
  )

;; -------------
;; -- Globals --
;; -------------
(global-linum-mode 1)
(global-font-lock-mode 1)

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key (kbd "C-;") 'toggle-comment-on-line);; 'comment-or-uncomment-region)
;; (global-set-key "\C-c;" 'toggle-comment-on-line);; 'comment-or-uncomment-region)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key "\M-u" 'zap-to-char)
;; Menu:
(global-set-key (kbd "s-o") 'menu-bar-open)

;; ---------------------------
;; -- JS Mode configuration --
;; ---------------------------
(load "js-config.el")
(add-to-list 'load-path "~/.emacs.d/.elisp/jade-mode") ;; github.com/brianc/jade-mode
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; -----------------
;; -- MATLAB Mode --
;; -----------------
(add-to-list 'load-path "~/.emacs.d/.elisp/matlab-emacs/matlab-emacs")
(load-library "matlab-load")

;; ------------------
;; -- Verilog Mode --
;; ------------------
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t)
(add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))
(setq verilog-indent-level             2
      verilog-indent-level-module      2
      verilog-indent-level-declaration 2
      verilog-indent-level-behavioral  2
      ;; verilog-indent-level-directive   1
      ;; verilog-case-indent              2
      ;; verilog-auto-newline             t
      ;; verilog-auto-indent-on-newline   t
      ;; verilog-tab-always-indent        t
      verilog-auto-endcomments         nil
      ;; verilog-minimum-comment-distance 40
      ;; verilog-indent-begin-after-if    t
      verilog-auto-lineup              'all
      ;; verilog-highlight-p1800-keywords nil
      ;; verilog-linter                   "my_lint_shell_command"
      verilog-auto-delete-trailing-whitespace t
      )

;; ----------------
;; -- ADICE Mode --
;; ----------------
(autoload 'adice-mode "adice-mode" "ADICE mode" t)

;; ---------------------
;; -- File Extensions --
;; ---------------------
(setq auto-mode-alist (cons '("\\.h$". c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.hpp$". c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.c$". c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cpp$". c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pde$". c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.v$". verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.vams$". verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sv$". verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.vg$". verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.veo$". verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.use$". adice-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.setup$". makefile-mode) auto-mode-alist))


;; --------------------
;; -- Fixes and Bugs --
;; --------------------
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; --------------------------
;; -- Custom Set Variables --
;; --------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (deeper-blue)))
<<<<<<< HEAD
 '(font-use-system-font t)
=======
>>>>>>> 89fcca3e85295477d6abe6cabc4d7e59c30654e2
 '(menu-bar-mode nil))

