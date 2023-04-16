(beacon-mode 1)

(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends (delete 'company-capf company-backends))
(add-to-list 'company-backends 'company-files)

;;(setq centaur-tabs-set-bar 'over)
;;(centaur-tabs-mode t)

(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-nord-aurora t)

  (doom-themes-visual-bell-config)

  (doom-themes-neotree-config)

  (setq doom-themes-treemacs-theme "doom-nord")

  (doom-themes-treemacs-config)

  (doom-themes-org-config))

(setq +workspaces/display t)

(map! :leader
      (:prefix ("t". "buffer")
       :desc "Toggle tabs" "h" #'centaur-tabs-mode
       :desc "New Workspace" "n" #'+workspace/new
       :desc "Delete Workspace" "d" #'+workspace/delete
       :desc "Rename Workspace" "N" #'+workspace/new-named
       :desc "Swap Workspace left" "j" #'+workspace/swap-left
       :desc "Swap Workspace right" "k" #'+workspace/swap-right
       :desc "Load Workspace" "L" #'+workspace/load
       :desc "Switch to Workspace 1" "1" #'+workspace/switch-to-0
       :desc "Switch to Workspace 2" "2" #'+workspace/switch-to-1
       :desc "Switch to Workspace 3" "3" #'+workspace/switch-to-2
       :desc "Switch to Workspace 4" "4" #'+workspace/switch-to-3
       :desc "Switch to Workspace 5" "5" #'+workspace/switch-to-4
       :desc "Switch to Workspace 6" "6" #'+workspace/switch-to-5
       :desc "Switch to Workspace 7" "7" #'+workspace/switch-to-6
       :desc "Switch to Workspace 8" "8" #'+workspace/switch-to-7
       :desc "Switch to Workspace 9" "9" #'+workspace/switch-to-8))

(map! "C-1" #'+workspace/switch-to-0)
(map! "C-2" #'+workspace/switch-to-1)
(map! "C-3" #'+workspace/switch-to-2)
(map! "C-4" #'+workspace/switch-to-3)
(map! "C-5" #'+workspace/switch-to-4)
(map! "C-6" #'+workspace/switch-to-5)
(map! "C-7" #'+workspace/switch-to-6)
(map! "C-8" #'+workspace/switch-to-7)
(map! "C-9" #'+workspace/switch-to-8)

(map! "C-l" #'evil-window-right)
(map! "C-h" #'evil-window-left)
(map! "C-k" #'evil-window-up)
(map! "C-j" #'evil-window-down)

(map! :leader
      (:prefix ("d". "buffer")
       :desc "Make file in Dired" "c" #'dired-create-empty-file
       :desc "Make directory in Dired" "D" #'dired-create-directory))


(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
  (add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(map! :leader
      (:prefix ("d". "buffer")
       :desc "Neotree current folder" "o" #'neotree
       :desc "Neotree Hide" "h" #'neotree-hide
       :desc "Neotree pick directory" "d" #'neotree-dir
       :desc "Neotree refresh" "r" #'neotree-refresh))

(map! "<f5>" #'neotree-toggle)

(map! :leader
      (:prefix ("t". "buffer")
       :desc "Term" "t" #'term
       :desc "Eshell" "e" #'eshell
       :desc "Eshell Popup" "E" #'+eshell/toggle
       :desc "Vterm" "V" #'vterm))


(defface my-eshell-prompt-face-1
  '((t (:foreground "cyan" :weight bold)))
  "Face for custom Eshell prompt color 1.")

(defface my-eshell-prompt-face-2
  '((t (:foreground "magenta" :weight bold)))
  "Face for custom Eshell prompt color 2.")

(setq eshell-prompt-face 'my-eshell-prompt-face-1)
(setq eshell-prompt-separator-face 'my-eshell-prompt-face-2)
