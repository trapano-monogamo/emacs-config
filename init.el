;;; author: Noemi

;; ..:: use-package ::..

(require 'package)

(defmacro append-to-list (target suffix)
  "Append SUFFIX to TARGET in place."
  `(setq ,target (append ,target ,suffix)))

(append-to-list package-archives
		'(("melpa" . "http://melpa.org/packages/")
		  ("melpa-stable" . "http://stable.melpa.org/packages/")
		  ("org-elpa" . "https://orgmode.org/elpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update nil)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" default))
 '(package-selected-packages
   '(ivy-posframe shell-pop vscode-dark-plus-theme rust-mode company-box ccls company lsp-ivy lsp-treemacs lsp-ui lsp-mode counsel ivy which-key evil-nerd-commenter evil evil-mode auto-package-update use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ..:: startup ::..

(setq comint-completion-addsuffix (quote ("\\" . " ")))
(setq inhibit-startup-message t)

;; ..:: evil-mode ::..

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (setq evil-want-keybinding nil)
  (evil-collection-init))

(use-package evil-nerd-commenter
  :ensure t
  :after evil
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; ..:: appearence ::..

;; themes
(use-package doom-themes
  :ensure t
  :init
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))

(use-package vscode-dark-plus-theme
  :ensure t)

(load-theme 'doom-one t)

;; font
(set-face-attribute 'default nil :font "Hack Bold" :height 110)

;; ui

(visual-line-mode)
(global-hl-line-mode)
(setq-default truncate-lines t)
(column-number-mode)
(global-display-line-numbers-mode t)
;; remove line numbers in specific modes
(dolist (mode '(org-mode-hook
           lsp-treemacs-mode-hook
                     term-mode-hook
                     ansi-term-mode-hook
                     eshell-mode-hook))
               (add-hook mode (lambda () (display-line-numbers-mode 0))))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 0)

;; ..:: emacs usage quality of life ::..

(use-package which-key
  :ensure t
  :init (which-key-mode))

(use-package ivy
  :ensure t
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))

;; floating M-x buffer basically
(use-package ivy-posframe
  :ensure t
  :after ivy
  :diminish
  :custom-face
  (ivy-posframe-border ((t (:background "#ffffff"))))
  :config
  ;; Different command can use different display function.
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center))
		ivy-posframe-height-alist '((t . 20))
		ivy-posframe-parameters '((internal-border-width . 10)))
  (setq ivy-posframe-width 70)
  :init
  (ivy-posframe-mode 1))

(use-package counsel
  :ensure t)

(global-set-key (kbd "M-x") 'counsel-M-x)

(use-package shell-pop
  :ensure t)

(global-set-key (kbd "C-c C-t") 'shell-pop)

;; ..:: editing ::..

;; preferences
(electric-pair-mode)
(setq-default tab-width 4)

;; code
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-treemacs
  :ensure t
  :after lsp)

(setq treemacs-no-png-images t)

(use-package lsp-ivy
  :ensure t
  :after lsp)

(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
		("<tab>" . company-complete-selection))
  (:map lsp-mode-map
		("<tab>" .  company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))
  

;; languages
(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode) .
		 (lambda () (require 'ccls) (lsp))))
(setq ccls-executable "/usr/bin/ccls")

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp-deferred)
  :config
  (setq rust-format-on-save nil)
  (setq lsp-rust-server 'rls))
