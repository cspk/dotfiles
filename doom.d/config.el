;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pavel Serebryakov"
      user-mail-address "cspk@list.ru")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq custom-theme-directory "/home/cspk/src/dotfiles/doom.d/themes")
(setq doom-theme 'doom-cspk)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq doom-font (font-spec :family "Terminus" :size 16 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Liberation Sans") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Terminus" :size 16 :weight 'normal)
      doom-big-font (font-spec :family "Terminus" :size 19))

(setq auto-save-default nil)
(setq super-save-idle-duration 60)
(setq super-save-auto-save-when-idle t)
(super-save-mode 1)

(setq-default cursor-type 'bar)
(blink-cursor-mode t)
(setq-default blink-cursor-blinks 0)
(setq-default blink-cursor-delay 1)
(setq-default blink-cursor-interval 1)

(setq mode-line-percent-position nil)

(setq projectile-project-search-path '("~/src/" "~/src/gcore"))

(global-set-key (kbd "M-w") 'easy-kill)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-<down>") 'scroll-up-line)
(global-set-key (kbd "C-<up>") 'scroll-down-line)

(global-total-lines-mode)

(defun inhibit-save-message (f &rest args)
  (let ((inhibit-message t))
    (funcall f)))

(advice-add 'save-buffer :around #'inhibit-save-message)

(after! doom-modeline
  (doom-modeline-def-segment total-line-count
    (propertize (format " %dL" total-lines)
                'face (if (doom-modeline--active) 'mode-line 'mode-line-inactive)))

  (doom-modeline-def-modeline 'my-simple-line
    '(buffer-info remote-host total-line-count buffer-position parrot selection-info)
    '(misc-info minor-modes input-method buffer-encoding major-mode process vcs checker))

  (defun setup-custom-doom-modeline ()
     (doom-modeline-set-modeline 'my-simple-line 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline))

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)

(setq-default fci-rule-column 80)
(add-hook 'prog-mode-hook 'fci-mode); set long line ruler

(defun kill-magit-diff-buffer-in-current-repo (&rest _)
  "Delete the magit-diff buffer related to the current repo"
  (let ((magit-diff-buffer-in-current-repo (magit-mode-get-buffer 'magit-diff-mode)))
    (kill-buffer magit-diff-buffer-in-current-repo)))

;; When 'C-c C-c' or 'C-c C-k' are pressed in the magit commit message buffer,
;; delete the magit-diff buffer related to the current repo.
(add-hook 'git-commit-setup-hook
          (lambda ()
            (add-hook 'with-editor-post-finish-hook #'kill-magit-diff-buffer-in-current-repo
                      nil t)
            (add-hook 'with-editor-post-cancel-hook #'kill-magit-diff-buffer-in-current-repo
                      nil t)))

(setq-default persp-autokill-persp-when-removed-last-buffer 'kill)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
