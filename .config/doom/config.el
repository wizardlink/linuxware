;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Alexandre Cavalheiro S. Tiago da Silva"
      user-mail-address "alexandre.cssilva@gmail.com")

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

(setq doom-font (font-spec :family "FantasqueSansMono NF" :size 13 :weight 'regular))
;;(setq doom-font (font-spec :family "Hasklig" :size 12 :weight 'regular))

(setq doom-unicode-font doom-font) ; extend glyphs

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/notes"
      org-agenda-files (doom-files-in `(,org-directory, "~/Documents/zettlekasten/daily") :type 'files :match "\\.org\\'"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


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

;; Set the tab width to 2 and enable tab indentation
(setq tab-width 2)

;; Make sure hl-line-mode doesn't overrides rainbow-mode
(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

;; Show gravatars on commits
(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

;; Enable fullscreen when activating zen mode
(setq writeroom-fullscreen-effect t)

;; Configure elcord
(setq elcord-client-id "794300845000228897"
      elcord-mode-text-alist '(
                               (cpp-mode . "C++")
                               (emacs-lisp-mode . "Elisp")
                               (gdscript-mode . "GDScript")
                               (js-mode . ":(")
                               (json-mode . "D:")
                               (lua-mode . "PLEASE")
                               (org-mode . "c:")
                               (sh-mode . ":c")
                               (typescript-mode . ":)")
                               (magit-mode . "Git magic")
                               (elixir-mode . "Elixir")
                               (nim-mode "Nim")
                               )
      elcord-mode-icon-alist '(
                               (cpp-mode . "cpp_mode")
                               (emacs-lisp-mode . "elisp_mode")
                               (gdscript-mode . "gdscript_mode")
                               (js-mode . "js_mode")
                               (json-mode . "json_mode")
                               (lua-mode . "lua_mode")
                               (org-mode . "org_mode")
                               (sh-mode . "sh_mode")
                               (typescript-mode . "typescript_mode")
                               (magit-mode . "magit_mode")
                               (elixir-mode . "elixir_mode")
                               (nim-mode . "nim_mode")
                               )
      elcord-editor-icon "elmo_fire"
      elcord--editor-name "Coding is overrated."
      )

;; Configure initial major mode for the scratch buffer
(setq initial-major-mode 'org-mode)

;; Configure orm-roam
(setq org-roam-v2-ack t) ; flag that it has been successfully migrated
(setq org-roam-directory "~/Documents/zettlekasten")
(map! (:leader :desc "Opens a daily note through the calendar" :n "nrdF" #'org-roam-dailies-find-date))
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n#+filetags: :daily:\n\n* Morning Journal\n** What are you grateful for?\n** What do you want today's highlight to be?\n** What's on your mind?\n* Tasks\n* Input\n* Output\n* Evening Reflection\n** How are you feeling today?\n** What could you have done better?\n** Amazing things that happened\n** What did you learn today?"))))

;; Function to add directories done by hlissner (Henrik) https://github.com/hlissner/doom-emacs/issues/5305#issuecomment-923996238
(defun doom/add-directory-as-project (dir)
  "Register an arbitrary directory as a project.
If DIR is not a valid project, a .project file will be created within it. This
command will throw an error if a parent of DIR is a valid project (which would
mask DIR)."
  (interactive "D")
  (let ((short-dir (abbreviate-file-name dir))
        (proj-dir (doom-project-root dir)))
    (unless (and proj-dir (file-equal-p proj-dir dir))
      (with-temp-file (doom-path dir ".project")))
    (setq proj-dir (doom-project-root dir))
    (unless (and proj-dir (file-equal-p proj-dir dir))
      (user-error "Can't add %S as a project, because %S is already a project"
                  short-dir (abbreviate-file-name proj-dir)))
    (message "%S was not a project; adding .project file to it" short-dir)
    (projectile-add-known-project dir)))

;; Setup elixir-ls
(setq lsp-clients-elixir-server-executable '("~/.local/share/elixir-ls/release/language_server.sh"))
