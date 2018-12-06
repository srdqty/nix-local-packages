(package-initialize)

(use-package doom-themes
  :ensure
  :config
  (load-theme 'doom-vibrant t)
  )

(use-package evil
  :config
  (evil-mode t)
  )

(use-package proof-site
  :custom
  (coq-prog-name "@coq-path@/bin/coqtop")
  (coq-compiler "@coq-path@/bin/coqc")
  )

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
  (xclip-program "@xclip-path@/bin/xclip")
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
