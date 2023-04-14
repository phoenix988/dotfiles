;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Karl Fredin"
      user-mail-address "karlfredin@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; Load package doom-theme
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Choose your theme Here
  (load-theme 'doom-nord-aurora t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-nord") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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


;; Keybindings
;; Tab/workspaces keybindings
(map! :leader
      (:prefix ("t". "buffer")
       :desc "Newtab" "n" #'+workspace/new
       :desc "Deletetab" "d" #'+workspace/delete
       :desc "Newname" "N" #'+workspace/new-named
       :desc "Swap Left" "j" #'+workspace/swap-left
       :desc "Swap Right" "k" #'+workspace/swap-right
       :desc "Load tab" "L" #'+workspace/load
       :desc "Toggle tabs" "h" #'centaur-tabs-mode
       :desc "Switch to tab number 0" "1" #'+workspace/switch-to-0
       :desc "Switch to tab number 1" "2" #'+workspace/switch-to-1
       :desc "Switch to tab number 2" "3" #'+workspace/switch-to-2
       :desc "Switch to tab number 3" "4" #'+workspace/switch-to-3
       :desc "Switch to tab number 4" "5" #'+workspace/switch-to-4
       :desc "Switch to tab number 5" "6" #'+workspace/switch-to-5
       :desc "Switch to tab number 6" "7" #'+workspace/switch-to-6
       :desc "Switch to tab number 7" "8" #'+workspace/switch-to-7
       :desc "Switch to tab number 8" "9" #'+workspace/switch-to-8))

;; Switch workspace using ctrl + number
(map! "C-1" #'+workspace/switch-to-0)
(map! "C-2" #'+workspace/switch-to-1)
(map! "C-3" #'+workspace/switch-to-2)
(map! "C-4" #'+workspace/switch-to-3)
(map! "C-5" #'+workspace/switch-to-4)
(map! "C-6" #'+workspace/switch-to-5)
(map! "C-7" #'+workspace/switch-to-6)
(map! "C-8" #'+workspace/switch-to-7)
(map! "C-9" #'+workspace/switch-to-8)


;; Neotree Keybindings
(map! :leader
      (:prefix ("d". "buffer")
       :desc "Neotree open in current folder" "o" #'neotree
       :desc "Neotree hider" "h" #'neotree-hide
       :desc "Neotree dir choose directory" "d" #'neotree-dir
       :desc "Neotree refresh" "r" #'neotree-refresh))
(map! "<f5>" #'neotree-toggle)

;; Open terminals in Emacs
(map! :leader
      (:prefix ("t". "buffer")
       :desc "Term" "t" #'term
       :desc "Eshell" "e" #'eshell
       :desc "Eshell Popup" "E" #'+eshell/toggle
       :desc "Vterm" "V" #'vterm))

;; Move around in splits with vim keys
(map! "C-l" #'evil-window-right)
(map! "C-h" #'evil-window-left)
(map! "C-k" #'evil-window-up)
(map! "C-j" #'evil-window-down)

;; Use vim keys in dired
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)


;; Shell configuration in emacs
(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000)


(setq eshell-rc-script "~/.config/doom/eshell/profile"
      eshell-aliases-file "~/.config/doom/eshell/aliases"
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

;; Centaur tabs mode on
(setq centaur-tabs-set-bar 'over)
(centaur-tabs-mode t)

;; Sets line to relative
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)


