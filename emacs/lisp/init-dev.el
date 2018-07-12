(add-to-list 'load-path "/home/sapristi/.emacs.d/lisp")
(add-to-list 'custom-theme-load-path "/home/sapristi/.emacs.d/themes/")


(require 'global)
(require 'better-defaults)
;; in case there needs to be huge commands (require 'dev-global)
(load-theme 'zenburn t)

(setq frame-title-format (list "%f - " (getenv "USER") "@" (getenv "HOSTNAME") "-dev"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (use-package fish-mode outshine))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; tuareg

(let ((tuareg-file-path  "/home/sapristi/.opam/system/share/emacs/site-lisp/tuareg-site-file"))
  (if (file-exists-p tuareg-file-path)
      (load "/home/sapristi/.opam/system/share/emacs/site-lisp/tuareg-site-file")
    (message "tuareg file is not present; consider setting the right path or installing with opam")))
