
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(package-initialize)

(add-to-list 'load-path "/home/sapristi/Documents/config files/emacs/emacs-common/lisp")
(add-to-list 'custom-theme-load-path "/home/sapristi/Documents/config files/emacs/emacs-common/themes")
                        
(require 'global)
(require 'better-defaults)

;; in case there needs to be huge commands (require 'dev-global)
(load-theme 'zenburn t)

(setq frame-title-format (list "%f || " (getenv "USER") "@" (system-name) "-dev"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (web-mode outshine merlin tuareg fish-mode use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; tuareg + merlin
;; if tuareg is installed via opam

;; (let ((tuareg-file-path  
;;	"/home/sapristi/.opam/4.06.1/share/emacs/site-lisp/tuareg-site-file"))
;;  (if (file-exists-p tuareg-file-path)
;; (load "/home/sapristi/.opam/4.06.1/share/emacs/site-lisp/tuareg-site-file")
;;    (message "tuareg file is not present; consider setting the right path or installing with opam")))


(use-package tuareg
  :ensure t)

(use-package merlin
  :ensure t)

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var"
                                                     "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))

;; lisp mode for dune files
(add-to-list 'auto-mode-alist '("dune" . emacs-lisp-mode))



;; outshine

(defvar outline-minor-mode-prefix "\M-#")

(use-package outshine
  :ensure t)

(require 'outshine)
(add-hook 'outline-minor-mode-hook 'outshine-mode)
(add-hook 'prog-mode-hook 'outline-minor-mode)


;; project org-mode todo states

(setq org-todo-keywords
      '((sequence "TODO" "STARTED" "CURRENT"  "|" "DONE" "CANCELED")))


(setq org-todo-keyword-faces
      '(("TODO" . "yellow")
        ("STARTED" . "orange")
        ("CURRENT" .  (:foreground "red" :weight bold))
        ("DONE"    .  "lime green")
        ("CANCELED" .  "deep blue sky")))



;; web mode

(use-package web-mode
  :ensure t)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(setq web-mode-engines-alist
      '(("html"    . "\\.html\\'"))
)
