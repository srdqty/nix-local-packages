(package-initialize)

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode)
  ;; unbind C-p
  (define-key evil-normal-state-map (kbd "C-p") nil)
  ;; set bindings for moving btwn windows
  (define-key evil-normal-state-map (kbd "C-h")  'windmove-left)
  (define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
  (define-key evil-normal-state-map (kbd "C-k")    'windmove-up)
  (define-key evil-normal-state-map (kbd "C-j")  'windmove-down)
  )

(use-package proof-site
;  :ensure proofgeneral
  :demand
  :custom
  (coq-prog-name "@coq-path@/bin/coqtop")
  (coq-compiler "@coq-path@/bin/coqc")
  )
