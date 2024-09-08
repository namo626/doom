;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "Fira Code" :size 13 :weight 'normal))
(setq doom-font (font-spec :family "Julia Mono" :size 14 :weight 'normal))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-spacegrey)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/orgmode/")
(setq org-agenda-files '("~/Documents/orgmode/" "~/Documents/orgmode/roam/"))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Org mode
(after! org
  (setq org-log-done 'time)
                                        ; DOn't put extra newline when creating new bullets
  (setq org-blank-before-new-entry (quote ((heading . nil)
                                           (plain-list-item . nil))))
  (add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (setq org-todo-keywords '((sequence "TODO" "WORKING" "CANCELED" "|" "DONE" )))
  (setq org-todo-keyword-faces
        '(("WORKING" . "orange") ("CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold)))
        )

  (setq
   org-superstar-headline-bullets-list '("◉" "○" "*" "✸" "✿")
   )
  (setq org-hide-emphasis-markers t)

  ;; (setq org-agenda-span 'day)
  (setq org-agenda-custom-commands
        '(("n" "Agenda / INTR / PROG / NEXT"
           ((agenda "" nil)
            (todo "WORKING" nil)
            (todo "TODO" nil)
            (todo "CANCELED" nil))
           nil)))
  (add-hook 'org-mode-hook '(lambda () (company-mode -1)) ))


;; Git branch modeline update
(setq auto-revert-check-vc-info t)

;; Fortran
(setq-default fortran-line-length 200)
(map! :after fortran
      ;:map evil-insert-state-map
      :map fortran-mode-map
      "RET" #'reindent-then-newline-and-indent)

;; Racket
(after! racket
  (add-hook 'racket-mode-hook '(lambda () (racket-smart-open-bracket-mode -1)))
  ;(racket-smart-open-bracket-mode -1)
)

;; SSH
(after! evil
  (setq evil-respect-visual-line-mode t)
  (setq-default tramp-use-ssh-controlmaster-options nil))

;; Clojure
(after! clojure
  (define-key paredit-mode-map (kbd "RET") nil))
(after! cider
  (set-popup-rule! "cider" :ignore t))
(plist-put +popup-defaults :modeline t)

;; Xetex
(after! latex
  (setq-default TeX-engine 'xetex))
