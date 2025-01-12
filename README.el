(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'elpaca-setup)   ;; the Elpaca Package Manager
(require 'buffer-move)    ;; Buffer-Move for better window management
(require 'app-launchers)  ;; Run-launcher functionality through emacs

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(use-package beacon
  :init (beacon-mode))

(setq beacon-size 180)

(use-package company
  :defer 2
  :diminish
  :custom
    (company-begin-commands '(self-insert-command))
    (company-idle-delay .1)
    (company-minimum-prefix-length 2)
    (company-show-numbers t)
    (company-tooltip-align-annotations 't)
    (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package dashboard
  :ensure t
  :init
    (setq initial-buffer-choice 'dashboard-open)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-icon-type 'all-the-icons)
    (setq dashboard-startup-banner 'logo)
    (setq dashboard-center-content t)
    (setq dashboard-items '((recents . 5)
                            (bookmarks . 3)
                            (projects . 3)
                            (registers . 5)
                            (agenda . 5)))
  :config
    (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
    (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
    (dashboard-setup-startup-hook))

(use-package diminish)

(use-package dired-open
  :config
    (setq dired-open-extensions '(("gif" . "feh")
                                  ("jpg" . "feh")
                                  ("jpg" . "feh")
                                  ("mkv" . "mpv")
                                  ("mp4" . "mpv"))))

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal dired-mode-map (kbd "k") 'peep-dired-prev-file)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file))

(setq evil-undo-system 'undo-redo)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :ensure t
  :after evil
  :init
  (evil-collection-init))

(use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))


;; Using RETURN to follow links in Org/Evil
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
(setq org-return-follows-link t)

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

(set-face-attribute 'default nil
  :height 130
  :weight 'medium)

(set-face-attribute 'variable-pitch nil
  :height 150
  :weight 'medium)

(set-face-attribute 'fixed-pitch nil
  :height 130
  :weight 'medium)

(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-increase)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode t)
(global-visual-line-mode t)
(setq display-line-numbers-type 'relative)

(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background 90))

(use-package counsel
  :after ivy
  :diminish
  :config (counsel-mode))

(use-package ivy
  :bind
    (("C-c C-r" . ivy-resume) 
    ("C-x B" . ivy-switch-buffer-other-window))
  :custom
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (setq enable-recursive-minibuffers t)
  :config
    (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode t))

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1)
  :custom
    (ivy-virtual-abbreviate 'full
    ivy-rich-switch-buffer-align-virtual-buffer t
    ivy-rich-path-style 'abbrev)
  :config
    (ivy-set-display-transformer 'ivy-switch-buffer
                                 'ivy-rich-switch-buffer-transformer))

(use-package general
  :config
  (general-evil-setup)
  (general-create-definer wolf/leader
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

(wolf/leader
  ;; buffer stuff
  "b"  '(:ignore t :wk "Buffers/Bookmarks")
  "b b" '(ibuffer :wk "Ibuffer")
  "b k" '(kill-this-buffer :wk "Kill this buffer")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Revert buffer")
  "b m" '(bookmark-set :wk "Set bookmark")
  "b r" '(bookmark-delete :wk "Delete bookmark")
  "b l" '(list-bookmarks :wk "List bookmark")
)

(wolf/leader
  "d"   '(:ignore t :wk "Dired")
  "d d" '(dired :wk "Open dired")
  "d j" '(dired-jump :wk "Dired jump to current")
  "d n" '(neotree-dir :wk "Open directory in neotree")
  "d p" '(peep-dired :wk "Peep-dired"))

(wolf/leader
  "e"  '(:ignore t :wk "Eshell/Evaluate")
  "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
  "e d" '(eval-defun :wk "Evaluate defun containing or after point")
  "e e" '(eval-expression :wk "Evaluate an elisp expression")
  "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
  "e r" '(eval-region :wk "Evaluate elisp in region")
  "e h" '(counsel-esh-history :wk "Eshell history")
  "e s" '(eshell :wk "Eshell")
)

(wolf/leader
  "h"     '(:ignore t :wk "Help")
  "h d"   '(:ignore t :wk "Documentation")
  "h d a" '(about-emacs :wk "About Emacs")
  "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
  "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
  "h d m" '(info-emacs-manual :wk "The Emacs manual")
  "h d n" '(view-emacs-news :wk "View Emacs news")
  "h d o" '(describe-distribution :wk "How to obtain Emacs")
  "h d p" '(view-emacs-problems :wk "View Emacs problems")
  "h d t" '(view-emacs-todo :wk "View Emacs todo")
  "h d w" '(describe-no-warranty :wk "Describe no warranty")
  "h f"   '(describe-function :wk "Describe function")
  "h v"   '(describe-variable :wk "Describe variable")

  "h r"   '(:ignore t :wk "Reload")
  "h r r"  '((lambda () (interactive) 
               (load-file "~/.config/emacs/init.el")
               (ignore (elpaca-process-queues))) :wk "Reload emacs config")
  )

(wolf/leader
  "g"  '(:ignore t :wk "Magit")
  "g g"  '(magit-status :wk "Magit Status")
)

(wolf/leader
  "."  '(find-file :wk "Find File") 
  "SPC"  '(counsel-M-x :wk "Counsel M-x") 
  "f p" '((lambda () (interactive) (find-file "~/.config/emacs/README.org")) :wk "Edit emacs config")
  "f n" '((lambda () (interactive) (find-file "~/.dotfiles/flake.nix")) :wk "Edit nix configuration")
  "f r" '(counsel-recentf :wk "Find recent files")
  "TAB TAB"  '(comment-line :wk "Comment lines") 
)

(wolf/leader
  "o"   '(:ignore t :wk "Org")
  "o e" '(org-export-dispatch :wk "Org export dispatch")
  "o f" '((lambda () (interactive) (find-file "~/org")) :wk "Open the org files directory in dired")
  "o i" '(org-toggle-item :wk "Org toggle item")
  "o t" '(org-todo :wk "Org todo")
  "o I" '(org-toggle-inline-images :wk "Org toggle inline images")
  "o B" '(org-babel-tangle :wk "Org babel tangle")

  "o b" '(:ignore t :wk "Tables")
  "o b -" '(org-table-insert-hline :wk "Insert hline in table")

  "o a" '(:ignore t :wk "Org Agenda")
  "o a a" '(org-agenda :wk "Agenda")
  "o a t" '(org-todo-list :wk "Org todo list")

  "o d" '(:ignore t :wk "Date/deadline")
  "o d t" '(org-time-stamp :wk "Org time stamp")
)

(wolf/leader
  "q"   '(:ignore t :wk "Quit")
  "q q" '(save-buffers-kill-terminal :wk "Quit emacs")
  "q f" '(delete-frame :wk "Quit this frame"))

(wolf/leader
  "t"  '(:ignore t :wk "Toggle")
  "t l"  '(display-line-numbers-mode :wk "Toggle line numbers")
  "t n"  '(neotree-toggle :wk "Toggle neotree")
  "t V"  '(vterm :wk "Toggle vterm fullscreen")
  "t v"  '(vterm-toggle :wk "Toggle vterm")
)

(wolf/leader
  "w" '(:ignore t :wk "Windows")
  ;; Window splits
  "w c" '(evil-window-delete :wk "Close window")
  "w n" '(evil-window-new :wk "New window")
  "w s" '(evil-window-split :wk "Horizontal split window")
  "w v" '(evil-window-vsplit :wk "Vertical split window")
  ;; Window motions
  "w h" '(evil-window-left :wk "Window left")
  "w j" '(evil-window-down :wk "Window down")
  "w k" '(evil-window-up :wk "Window up")
  "w l" '(evil-window-right :wk "Window right")
  "w w" '(evil-window-next :wk "Goto next window")
  ;; Move Windows
  "w H" '(buf-move-left :wk "Window move left")
  "w J" '(buf-move-down :wk "Window move down")
  "w K" '(buf-move-up :wk "Window move up")
  "w L" '(buf-move-right :wk "Window move right")))

(use-package lua-mode)
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package transient)

(use-package magit
  :ensure t)

(global-set-key [escape] 'keyboard-escape-quit)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
    (setq doom-modeline-height 30
          doom-modeline-bar-width 5
          doom-modeline-persp-name t
          doom-modeline-persp-icon t))

(use-package neotree
  :config
    (setq neo-smart-open t
          neo-show-hidden-files t
          neo-window-width 45
          neo-window-fixed-size nil
          inhibit-compacting-font-caches t
          projectile-switch-project-action 'neotree-projectile-action)
    (add-hook 'neo-after-create-hook
      #'(lambda (_)
          (with-current-buffer (get-buffer neo-buffer-name)
            (setq truncate-lines t)
            (setq word-wrap nil)
            (make-local-variable 'auto-hscroll-mode)
            (setq auto-hscroll-mode nil)))))

(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'org-tempo)

(setq org-agenda-files '("~/org"))

(use-package projectile
  :diminish
  :config
    (projectile-mode 1))

(use-package rainbow-mode
  :diminish
  :hook
    ((org-mode prog-mode) . rainbow-mode))

;; (electric-pair-mode 0)
;; (add-hook 'org-mode-hook (lambda ()
;;            (setq-local electric-pair-inhibit-predicate
;;                    `(lambda (c)
;;                   (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config (eshell-syntax-highlighting-global-mode +1))

(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "htop" "ssh" "top" "zsh"))

(use-package vterm
  :config
    (setq shell-file-name "zsh"
	    vterm-shell "zsh"
          vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
    (setq vterm-toggle-fullscreen-p nil)
    (setq vterm-toggle-scope 'project)
    (add-to-list 'display-buffer-alist
		 '((lambda (buffer-or-name _)
		     (let ((buffer (get-buffer buffer-or-name)))
		       (with-current-buffer buffer
			 (or (equal major-mode 'vterm-mode)
			     (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
		   (display-buffer-reuse-window display-buffer-in-direction)
		   ;;(display-buffer-reuse-window display-buffer-in-direction)
		   ;;display-buffer-in-direction/direction/dedicated is added in emacs27
		   ;;(direction . bottom)
		   ;;(dedicated . t) ;dedicated is supported in emacs27
		   (reusable-frames . visible)
		   (window-height . 0.3))))

(use-package sudo-edit
  :config
    (wolf/leader
      "f u" '(sudo-edit-find-file :wk "Sudo find file")
      "f U" '(sudo-edit :wk "Sudo edit file")
    )
)

(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
    which-key-sort-order #'which-key-key-order-alpha
    which-key-sort-uppercase-first nil
    which-key-add-column-padding 1
    which-key-max-display-columns nil
    which-key-min-display-lines 6
    which-key-side-window-slot -10
    which-key-side-window-max-height 0.25
    which-key-idle-delay 0.8
    which-key-max-description-length 25
    which-key-allow-imprecise-window-fit t
    which-key-separator " → "))
