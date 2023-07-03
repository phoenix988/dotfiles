(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends (delete 'company-capf company-backends))
(add-to-list 'company-backends 'company-files)

(beacon-mode 1)

(setq doom-font (font-spec :family "JetBrains Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 16)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(map! "C-l" #'evil-window-right)
(map! "C-h" #'evil-window-left)
(map! "C-k" #'evil-window-up)
(map! "C-j" #'evil-window-down)

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

(map! :leader
      (:prefix ("d". "buffer")
       :desc "Make file in Dired" "c" #'dired-create-empty-file
       :desc "Make directory in Dired" "D" #'dired-create-directory)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previes" "d p" #'peep-dired)))


(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
  (add-hook 'peep-dired-hook 'evil-normalize-keymaps)


(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "a") 'dired-create-empty-file
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(map! :leader
      (:prefix ("d". "buffer")
       :desc "Neotree current folder" "o" #'neotree
       :desc "Neotree Hide" "h" #'neotree-hide
       :desc "Neotree pick directory" "d" #'neotree-dir
       :desc "Neotree refresh" "r" #'neotree-refresh))

(map! "<f5>" #'neotree-toggle)

;; You can use this hydra menu that have all the commands
(map! :leader "j m" 'harpoon-quick-menu-hydra)
(map! :leader "j a" 'harpoon-add-file)

;; And the vanilla commands
(map! :leader "j c" 'harpoon-clear)
(map! :leader "j t" 'harpoon-toggle-file)
(map! :leader "1" 'harpoon-go-to-1)
(map! :leader "2" 'harpoon-go-to-2)
(map! :leader "3" 'harpoon-go-to-3)
(map! :leader "4" 'harpoon-go-to-4)
(map! :leader "5" 'harpoon-go-to-5)
(map! :leader "6" 'harpoon-go-to-6)
(map! :leader "7" 'harpoon-go-to-7)
(map! :leader "8" 'harpoon-go-to-8)
(map! :leader "9" 'harpoon-go-to-9)

(map! :leader
      (:prefix ("t". "buffer")
       :desc "Term" "t" #'term
       :desc "Eshell" "e" #'eshell
       :desc "Eshell Popup" "E" #'+eshell/toggle
       :desc "Vterm" "V" #'vterm))

(setq display-line-numbers-type 'relative)

(global-display-line-numbers-mode)

(rainbow-mode 1)

(setq scroll-margin 8)

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)
(after! org
  (setq org-directory "~/nextcloud/Org/"
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "GYM(g)"            ; Things to accomplish at the gym
             "PROJ(p)"           ; A project that contains other tasks
             "VIDEO(v)"          ; Video assignments
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled

(add-hook 'prog-mode-hook 'rainbow-mode)

(rainbow-mode 1)

(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000)

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

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)

  (doom-themes-visual-bell-config)

  (doom-themes-neotree-config)

  (setq doom-themes-treemacs-theme "doom-iceberg")

  (doom-themes-treemacs-config)

  (doom-themes-org-config))

  (load-theme 'doom-iceberg t)

(use-package autothemer :ensure t)
