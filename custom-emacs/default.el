(package-initialize)

(use-package pollen-mode)

(use-package doom-themes
  :ensure
  :config
  (load-theme 'doom-nord-light t)
  )

(global-evil-leader-mode)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "gb" 'magit-blame
  "gq" 'magit-blame-quit
)

(evil-leader/set-key-for-mode 'agda2-mode
  "l" 'agda2-load
  "n" 'agda2-compute-normalised-maybe-toplevel
  "d" 'agda2-infer-type-maybe-toplevel
)

(evil-leader/set-key-for-mode 'idris-mode
  "l" 'idris-load-file
  "c" 'idris-case-split
  "a" 'idris-proof-search
  "e" 'idris-make-lemma
  "s" 'idris-add-clause
  "t" 'idris-type-at-point
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

;(scroll-bar-mode -1)
;(tool-bar-mode -1)
;(tooltip-mode -1)
;(menu-bar-mode -1)

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
         "@agda-path@/bin"
         "@git-path@/bin"
	 )))
  (setenv "PATH"
	  (concat (mapconcat (lambda (x) (concat x ":")) extra-paths "")
		  (getenv "PATH")))
  (setq exec-path (append extra-paths exec-path)))

(setq-default indent-tabs-mode nil)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))
