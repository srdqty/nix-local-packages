(package-initialize)

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode t)
  ;; unbind C-p
  (define-key evil-normal-state-map (kbd "C-p") nil)
  ;; set bindings for moving btwn windows
  (define-key evil-normal-state-map (kbd "C-h")  'windmove-left)
  (define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
  (define-key evil-normal-state-map (kbd "C-k")    'windmove-up)
  (define-key evil-normal-state-map (kbd "C-j")  'windmove-down)
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

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(global-display-line-numbers-mode)
(setq column-number-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
