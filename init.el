;; add packge-lists
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ggtags agtags dap-mode company counsel-gtags which-key helm-xref helm-mode-manager lsp-mode sr-speedbar go-autocomplete go-complete go-mode auto-complete)))
 '(speedbar-show-unknown-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; display line num
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;;---start code for go dev---

;; Init the auto complete modules
(ac-config-default)
(global-auto-complete-mode t)
(require 'go-autocomplete)

;; Enable auto-complete
(auto-complete-mode 1)

;; Define keymaps
(define-key ac-mode-map (kbd "M-n") 'auto-complete)
(global-set-key (kbd"C-c C-c") 'godef-jump)

;; Set some quick config vals
(setq ac-auto-start 1)
(setq ac-auto-show-menu 0.8)

;; Just to make sure go tools are enabled
(add-to-list 'exec-path "_/go/bin")

;; Automatically format code on save
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'auto-complete-for-go)

;;---end code for go dev---

;;Customize sr-speedbar

(setq sr-speedbar-width 30)

;; disable menu-tool-bar
(menu-bar-mode -1)

;; ---setting c/c++ programming enviroment---
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(setenv "PATH" (concat "/usr/bin;" (getenv "PATH")))
(setenv "GTAGSLIBPATH" (concat "/usr/include"
                               ":"
                               "/usr/include/X11"
                               ":"
                               (file-truename "~/code_demo/dwm")))
(setenv "MAKEOBJDIRPREFIX" (file-truename "~/obj/"))
(setq company-backends '((company-dabbrev-code helm-gtags)))
