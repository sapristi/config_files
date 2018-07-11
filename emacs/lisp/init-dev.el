(add-to-list 'load-path "/home/Documents/config files/emacs")
(add-to-list 'custom-theme-load-path "/home/Documents/config files/emacs/themes/")

(require 'better-defaults)
(require 'global)
(require 'dev-global)
(load-theme 'zenburn t)

(setq frame-title-format (list "%f - " (getenv "USER") "@" (getenv "HOSTNAME") "-dev"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (fish-mode outshine))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
