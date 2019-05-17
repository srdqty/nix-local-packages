(package-initialize)

(use-package agda2)

(use-package pollen-mode)

(use-package doom-themes
  :ensure
  :config
  (load-theme 'doom-vibrant t)
  )

(use-package evil
  :config
  (evil-mode t)
  )

(use-package proof-site)

(use-package whitespace
  :config
  (global-whitespace-mode t)
  :custom
  (whitespace-style
   '(face empty tabs lines-tail trailing whitespace-line-column))
  )

(use-package xclip
  :ensure
  :config
  (xclip-mode 1)
  :custom
  (xclip-method 'xclip)
  )

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; show line and column numbers
(global-display-line-numbers-mode) ; show line numbers to the left
(setq column-number-mode t) ; show column number in footer

;; delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; disable backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; highlight matching parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)

(let
    ((extra-paths
       '("@xclip-path@/bin"
         "@coq-path@/bin"
         "@hlint-path@/bin"
         "@idris-path@/bin"
	 )))
  (setenv "PATH"
	  (concat (mapconcat (lambda (x) (concat x ":")) extra-paths "")
		  (getenv "PATH")))
  (setq exec-path (append extra-paths exec-path)))
