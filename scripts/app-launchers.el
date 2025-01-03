(use-package app-launcher
  :ensure '(app-launcher :host github :repo "SebastienWae/app-launcher")
  )

(defun emacs-run-launcher ()
  (interactive)
  (with-selected-frame
      (make-frame '((name . "emacs-run-launcher")
		    (minibuffer . only)
		    (fullscreen . 0)
		    (undercorated . t)
		    ;; (auto-raise . t)
		    ;; (tool-bar-lines . 0)
		    ;; (menu-bar-lines . 0)
		    (internal-border-width . 10)
		    (width . 80)
		    (height . 11)))
    (unwind-protect
        (app-launcher-run-app)
      (delete-frame))))

(provide 'app-launchers)
