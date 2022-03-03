;;; package --- summary
;;; Commentary:
;;; Code:
;; idk emacs yelled at me for not having those

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	'("234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "18bec4c258b4b4fb261671cf59197c1c3ba2a7a47cc776915c3e8db3334a0d25" default))
 '(package-selected-packages
	'(org-bullets org-mode cmake-mode clangd emacs-ccls lsp-clangd ccls evil-nerd-commenter auto-package-update font-lock+ all-the-icons-dired dashboard which-key doom-modeline doom-themes flycheck lsp-python-ms company-box lsp-treemacs lsp-ivy omnisharp company fzf csharp-mode lsp-ui lsp-mode nord-theme rust-mode evil-collection evil dracula-theme counsel ivy command-log-mode use-package exec-path-from-shell))
 '(temp-buffer-resize-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; load config.org
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
