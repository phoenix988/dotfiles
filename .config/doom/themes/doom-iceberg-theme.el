;;; doom-iceberg-theme.el --- Inspired by VSCode Horizon -*- no-byte-compile: t; -*-

;;; Commentary:
;;; This theme was inspired by the port of Horizon to Emacs
;;; see: https://github.com/aodhneine/iceberg-theme.el


;;; Code:
(defgroup doom-iceberg-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-iceberg-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-iceberg-theme
  :type 'boolean)

(defcustom doom-iceberg-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-iceberg-theme
  :type 'boolean)

(defcustom doom-iceberg-comment-bg doom-iceberg-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their legibility."
  :group 'doom-iceberg-theme
  :type 'boolean)

(defcustom doom-iceberg-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to determine the exact padding."
  :group 'doom-iceberg-theme
  :type '(choice integer boolean))

;;
(def-doom-theme doom-iceberg
  "Made A version of the iceberg colorscheme for emacs"

  ;; name        default   256       16
  ( (bg         '("#161821" "#161821" nil            ))
    (bg-alt     '("#161821" "#161821" nil            ))
    (base0      '("#161821" "#161821" "black"        ))
    (base1      '("#1E2132" "#1E2132" "brightblack"  ))
    (base2      '("#161821" "#161821" "brightblack"  ))
    (base3      '("#161821" "#161821" "brightblack"  ))
    (base4      '("#91ACD1" "#91ACD1" "brightblack"  ))
    (base5      '("#E2A478" "#E2A478" "brightblack"  ))
    (base6      '("#E2A478" "#E2A478" "brightblack"  ))
    (base7      '("#E2A478" "#E2A478" "brightblack"  ))
    (base8      '("#282A36" "#282A36" "white"        ))
    (fg-alt     '("#818596" "#818596" "brightwhite"  ))
    (fg         '("#D8DEE9" "#D8DEE9" "white"        ))

    (grey       base4)
    (red        '("#ADA0D3" "#ADA0D3" "red"          ))
    (orange     '("#ADA0D3" "#ADA0D3" "brightred"    ))
    (green      '("#8FBCBB" "#8FBCBB" "green"        ))
    (teal       '("#D4D7B6" "#D4D7B6" "brightgreen"  ))
    (yellow     '("#E2A478" "#E4A478" "yellow"       ))
    (blue       '("#A7C9E2" "#A7C9E2" "brightblue"   ))
    (dark-blue  '("#B48EAD" "#B48EAD" "blue"         ))
    (magenta    '("#D6ACFF" "#D6ACFF" "magenta"      ))
    (violet     '("#5E81AC" "#5E81AC" "brightmagenta"))
    (cyan       '("#8FBCBB" "#8FBCBB" "brightcyan"   ))
    (dark-cyan  '("#54828E" "#54828E" "cyan"   ))
    (lightred   '("#E98989" "#E98989" "lightred"   ))

    ;; additional highlighting colours for iceberg
    (hor-highlight  (doom-lighten base3 0.05))
    (hor-highlight-selected (doom-lighten base3 0.1))
    (hor-highlight-bright (doom-lighten base3 0.2))

    ;; face categories -- required for all themes
    (highlight      red)
    (vertical-bar   base0)
    (selection      violet)
    (builtin        violet)
    (comments       (if doom-iceberg-brighter-comments magenta hor-highlight-bright))
    (doc-comments   yellow)
    (constants      orange)
    (functions      lightred)
    (keywords       violet)
    (methods        magenta)
    (operators      base4)
    (type           blue)
    (strings        yellow)
    (variables      red)
    (numbers        orange)
    (region         hor-highlight)
    (error          red)
    (warning        dark-cyan)
    (success        green)
    (vc-modified    orange)
    (vc-added       green)
    (vc-deleted     red)


    ;; custom categories
    (hidden     `(,(car bg) "black" "black"))
    (-modeline-bright doom-iceberg-brighter-modeline)
    (-modeline-pad
      (when doom-iceberg-padded-modeline
        (if (integerp doom-iceberg-padded-modeline) doom-iceberg-padded-modeline 4)))

    (modeline-fg     (doom-darken fg 0.2))
    (modeline-fg-alt (doom-lighten bg 0.2))

    (modeline-bg
      (if -modeline-bright
          base4
        `(,(car base1), (cdr fg-alt))))
    (modeline-bg-l
      (if -modeline-bright
          base4
        `(,(car base1), (cdr fg))))
    (modeline-bg-inactive   base1)
    (modeline-bg-inactive-l base1))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")


    ;; ((line-number &override) :foreground (doom-lighten bg 0.05))
    ((line-number &override) :foreground "#444B71" :background "#1E2132")
    ((line-number-current-line &override) :background "#191724" :foreground "#E0DEF4" )

    (font-lock-comment-face
      :inherit 'italic
      :foreground "#6B7089"
      :background (if doom-iceberg-comment-bg (doom-lighten bg 0.03)))
    (font-lock-doc-face
      :inherit 'font-lock-comment-face
      :foreground doc-comments)

    (mode-line
      :background modeline-bg :foreground modeline-fg
      :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
    (mode-line-inactive
      :background modeline-bg-inactive :foreground modeline-fg-alt
      :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
    (mode-line-emphasis
      :foreground (if -modeline-bright base8 highlight))
    (header-line :inherit 'mode-line :background fg-alt)
    (mode-line-highlight :background base1 :foreground fg)

    ;; modeline
    (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
    (doom-modeline-highlight :foreground (doom-lighten bg 0.3))
    (doom-modeline-project-dir :foreground red :inherit 'bold )
    (doom-modeline-buffer-path :foreground red)
    (doom-modeline-buffer-file :foreground fg)
    (doom-modeline-buffer-modified :foreground violet)
    (doom-modeline-panel :background base1)
    (doom-modeline-urgent :foreground modeline-fg)
    (doom-modeline-info :foreground cyan)


    (solaire-mode-line-face
      :inherit 'mode-line
      :background modeline-bg-l
      :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
    (solaire-mode-line-inactive-face
      :inherit 'mode-line-inactive
      :background modeline-bg-inactive-l
      :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

    ;; --- major-mode faces -------------------
    ;; NOTE: there are lots of tweaks here to mimic the VSCode theme

    ;; css-mode / scss-mode
    (css-proprietary-property :foreground violet)
    (css-property             :foreground fg)
    (css-selector             :foreground red)

    ;; mic-paren
    (paren-face-match    :foreground green   :background base0 :weight 'ultra-bold)
    (paren-face-mismatch :foreground yellow :background base0   :weight 'ultra-bold)
    (paren-face-no-match :inherit 'paren-face-mismatch :weight 'ultra-bold)

    ;; markdown-mode
    (markdown-markup-face           :foreground cyan)
    (markdown-link-face             :foreground orange)
    (markdown-link-title-face       :foreground yellow)
    (markdown-header-face           :foreground red :inherit 'bold)
    (markdown-header-delimiter-face :foreground red :inherit 'bold)
    (markdown-language-keyword-face :foreground orange)
    (markdown-markup-face           :foreground fg)
    (markdown-bold-face             :foreground violet)
    (markdown-table-face            :foreground fg :background base1)
    ((markdown-code-face &override) :foreground orange :background base1)

    ;; outline (affects org-mode)
    ((outline-1 &override) :foreground blue :background nil)

    ;; org-mode
    ((org-block &override) :background base1)
    ((org-block-begin-line &override) :background base1 :foreground "#6B7089")
    (org-hide :foreground hidden)
    (org-link :inherit 'underline :foreground yellow)
    (org-agenda-done :foreground cyan)
    (solaire-header-line-face :background bg-alt :foreground fg)
    (header-line :background base2 :foreground fg)
    (org-meta-line :foreground fg-alt)
    (org-level-1 :foreground "#84A0C6")
    (org-level-2 :foreground "#A093C7")
    (org-level-3 :foreground "#8FBCBB")
    (org-level-4 :foreground "#5E81AC")
    (org-level-5 :foreground "#A3B8D1")
    (org-level-6 :foreground "#E9B189")

    ;; tooltip
    (tooltip              :background base0 :foreground fg)

    ;; haskell
    (haskell-type-face :foreground violet)
    (haskell-constructor-face :foreground yellow)
    (haskell-operator-face :foreground fg)
    (haskell-literate-comment-face :foreground hor-highlight-selected)

    ;; magit
    (magit-section-heading :foreground red)
    (magit-branch-remote   :foreground orange)
    (magit-diff-removed-highlight :background lightred :foreground "#4C566A" )

    ;; --- extra variables ---------------------
    ;; basics
    (link :foreground yellow :inherit 'underline)
    (fringe :background bg)

    ;; evil
    (evil-ex-search          :background hor-highlight-selected :foreground fg)
    (evil-ex-lazy-highlight  :background hor-highlight :foreground fg)

    ;; ivy
    (ivy-current-match       :background hor-highlight :distant-foreground nil)
    (ivy-posframe-cursor     :background red :foreground base0)
    (ivy-minibuffer-match-face-2 :foreground red :weight 'bold)
    (cursor :foreground "#A3B8D1" :weight 'bold  :background "#A3B8D1")
    (set-cursor-color :foreground "#A3B8D1" :weight 'bold :background "#A3B8D1")

    ;; company
    (company-box-background    :background base0 :foreground fg)
    (company-tooltip-common    :foreground red :weight 'bold)
    (company-tooltip-selection :background hor-highlight :foreground fg)

   ;; treemacs
   (treemacs-root-face :foreground fg :weight 'bold :height 1.2)
   (doom-themes-treemacs-root-face :foreground fg :weight 'ultra-bold :height 1.2)
   (doom-themes-treemacs-file-face :foreground fg)
   (treemacs-directory-face :foreground fg)
   (treemacs-git-modified-face :foreground green)

   ;; js2-mode
   (js2-object-property        :foreground red)

   ;; Highlight line
   (hl-line :background base8)

  ;; Dired
  (diredfl-compressed-file-suffix :foreground red)
  (diredfl-ignored-file-name :foreground fg-alt)

  ;; Search
  (evil-ex-search :background red :foreground bg)

   ;; Neotree
   (doom-themes-neotree-executable-file-face :foreground cyan)

   ;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-tag-bracket-face :foreground red)
   (rjsx-attr :foreground cyan :slant 'italic :weight 'medium)

   ;; web-mode
   (web-mode-html-tag-bracket-face :foreground red)
   (web-mode-html-tag-face         :foreground red)
   (web-mode-html-attr-name-face   :foreground orange)
    ))

;;; doom-iceberg-theme.el ends here

