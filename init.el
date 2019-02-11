(add-to-list 'load-path "~/.emacs.d/plugins")
;(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-solarized")

(package-initialize)

; ==============
; Display tweaks
; ==============

(setq inhibit-startup-message t)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(display-time)

(column-number-mode 1)
(line-number-mode 1)

(show-paren-mode 1)
(setq show-paren-delay 0)

; cursor type
(setq-default cursor-type 'bar)

;(mouse-avoidance-mode 'banish)

(global-hl-line-mode 1)
(set-face-background 'hl-line "#222444")
(set-face-background 'hl-line "#eee8d5")
; turn off line highlighting mode for the terminal buffer
;; (make-variable-buffer-local 'global-hl-line-mode)
;; (add-hook 'term-mode-hook '(lambda () (setq global-hl-line-mode nil)))


; Highlight matching parentheses

;; (require 'paren)
;; (set-face-background
;;  'show-paren-match-face nil)
;; (set-face-foreground
;;  'show-paren-match-face "yellow")
;; (set-face-attribute
;;  'show-paren-match-face nil :weight 'extra-bold :underline nil :overline nil :slant 'normal)

(setq-default line-spacing 9)

;; (if (member "Roboto Mono for Powerline" (font-family-list))
;;     (set-face-attribute 'default nil :font "Roboto Mono for Powerline" :height 130))

;; (if (member "Inconsolata" (font-family-list))
;;     (set-face-attribute 'default nil :font "Inconsolata" :height 120))

(if (member "Monaco" (font-family-list))
    (set-face-attribute 'default nil :font "Monaco" :height 120))

;; (if (member "Inconsolata LGC" (font-family-list))
;;     (set-face-attribute 'default nil :font "Inconsolata LGC" :height 150))

;; (if (member "Consolas" (font-family-list))
;;     (set-face-attribute 'default nil :font "Consolas" :height 120))

;; (if (member "Space Mono" (font-family-list))
;;     (set-face-attribute 'default nil :font "Space Mono" :height 130))

(setq-default line-spacing 5)

;; (if (member "Go Mono" (font-family-list))
;;     (set-face-attribute 'default nil :font "Go Mono" :height 120))

; (set-face-attribute 'default nil :height 150)

; Display line numbers on the left side of the buffer
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
(setq linum-format " %d ")

; Color theme
;(add-to-list 'custom-theme-load-path "~/.emacs.d/plugins/color-theme-solarized")
;(require 'color-theme-solarized)
;(color-theme-solarized-dark)
;(load-theme 'solarized t)
;(require 'color-theme)
;(color-theme-initialize)

;(load-theme 'solarized-light)

(add-hook 'after-init-hook (lambda () (load-theme 'solarized-light t)))

;; select theme - first list element is for windowing system, second is for console/terminal
(setq color-theme-choices '(color-theme-mailgun color-theme-tango color-theme-hober))
;; test for each frame or console
(require 'cl)
(lexical-let ( (cols color-theme-choices) )
  (defun test-win-sys (frame)
    (let ( (color-theme-is-global nil) )
      (select-frame frame)
      (eval (append '(if (window-system frame))
     		    (mapcar (lambda (x) (cons x nil)) cols))))))
;; hook on after-make-frame-functions
(add-hook 'after-make-frame-functions 'test-win-sys)

;; set an awesome theme and override some colors
;; (load-theme 'bubbleberry t)
;; (custom-theme-set-faces
;;  'bubbleberry
;;  '(region                 ((t (:background "#ffff00" ))))
;;  '(cursor                 ((t (:background "#222444" ))))
;;  '(linum                  ((t (:background "#202020" :foreground "#ffffff" :box nil :height 100 )))))

;; (if window-system
;; ;;    (color-theme-wombat))
;;     (color-theme-tango))
;; ;;    (color-theme-mailgun))
;; (if (not (window-system))
;; ;;     (color-theme-hober))
;;     (color-theme-solarized-dark))

; Eighty-column rule
(require 'fill-column-indicator)
(setq fci-rule-width 5)
(setq fci-rule-color "grey70")
(setq-default fill-column 80)
(add-hook 'python-mode-hook (lambda () (fci-mode 1)))
(add-hook 'go-mode-hook (lambda () (fci-mode 1)))

; Highlight symbols after 80 column
(require 'whitespace)
(setq whitespace-style '(face tabs lines-tail trailing))
(add-hook 'python-mode-hook (lambda () (whitespace-mode 1)))

; global-whitespace-mode slows things down a lot, so disable (some)
; fontification. Tip due to http://www.emacswiki.org/emacs/WhiteSpace
(defun whitespace-post-command-hook() nil)

; repositories
(require 'package)
(setq package-archives '(("melpa" . "http://stable.melpa.org/packages/")))
                         ;; ("gnu" . "http://elpa.gnu.org/packages/")
                         ;; ("marmalade" . "http://marmalade-repo.org/packages/")))

; powerline
(add-to-list 'load-path "~/.emacs.d/plugins/powerline")
(require 'powerline)
;(powerline-default-theme)

;; (setq powerline-color1 "#073642")
;; (setq powerline-color2 "#002b36")

;; (set-face-attribute 'mode-line nil
;;                     :foreground "#fdf6e3"
;;                     :background "#2aa198"
;;                     :box nil)
;; (set-face-attribute 'mode-line-inactive nil
;;                     :box nil)

; Mac specific
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)


; ===============
; Behavior tweaks
; ===============

; save sessions on exit and restore on start
(desktop-save-mode 1)

; confirm before exit
(setq confirm-kill-emacs 'y-or-n-p)

(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq default-tab-width 4)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(delete-selection-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))


; Fullscreen mode

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

; (toggle-fullscreen)

; Sudo edit

(defun sudo-edit (&optional arg)
  (interactive "p")
  (if arg
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun sudo-edit-current-file ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer)))))

; Keep emacs backups (*~) in separate dir

(push '("." . "~/.emacs-backups") backup-directory-alist)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

; Move line

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defun shift-region-left (n)
  (interactive "p")
  (indent-rigidly (region-beginning) (region-end) (- 1)))

(defun shift-region-right (n)
  (interactive "p")
  (indent-rigidly (region-beginning) (region-end) 1))

; Buffer move

(require 'buffer-move)

;
(setq x-select-enable-clipboard t)

; Highlight symbol at cursor
(require 'highlight-symbol)
(global-set-key (kbd "<f9>") 'highlight-symbol-at-point)
(global-set-key (kbd "<f11>") 'highlight-symbol-next)
(global-set-key (kbd "<f12>") 'highlight-symbol-prev)

; Very useful ThingAtPoint library and extension allows to mark various things.
; Use along with wrap-region minor mode to quickly wrap regions with
; punctuations (e.g. surround word with quotes, etc.)
(require 'thing-cmds)
(thgcmd-bind-keys)
(require 'wrap-region)
(wrap-region-global-mode t)

; Ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
;; disable auto searching for files unless called explicitly
(setq ido-auto-merge-delay-time 99999)
(ido-mode 1)

; Reuse the same buffer in Dired mode when pressing 'a'
(put 'dired-find-alternate-file 'disabled nil)

; Show human-friendly sizes in Dired listings
(setq dired-listing-switches "-lah")

; Prevent clicking in grep results windown from openinig new buffers
(setq split-height-threshold 999)

; Switch between windows with Alt-<number>
(autoload 'window-number-meta-mode "window-number" t)
(window-number-meta-mode t)

; anything.el search dir


; ===============
; Git integration
; ===============

(require 'magit)
(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

; Change magit diff colors
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))

(global-set-key (kbd "M-g s") 'magit-status)
(global-set-key (kbd "M-g l") 'magit-display-log)


; =======
; Unicode
; =======

(prefer-coding-system       'utf-8)

(set-default-coding-systems 'utf-8)

(set-terminal-coding-system 'utf-8)

(set-keyboard-coding-system 'utf-8)

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


; ============================
; Programming modes & settings
; ============================

; Python

;; (autoload 'python-mode "python-mode" "Python editing mode." t)
(add-to-list 'load-path "~/.emacs.d/plugins/python-mode.el-6.2.0")
(setq py-install-directory "~/.emacs.d/plugins/python-mode.el-6.2.0")
(require 'python-mode)

(require 'tramp)

(autoload 'python-pep8 "python-pep8" "PEP8" t)
(autoload 'pep8 "python-pep8" "PEP8" t)

(autoload 'python-pylint "python-pylint" "PyLINT" t)
(autoload 'pylint "python-pylint" "PyLINT" t)

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))

(setq-default py-indent-offset 4)

;; add pylookup to your loadpath, ex) ~/.emacs.d/pylookup
(setq pylookup-dir "~/.emacs.d/plugins/pylookup")
(add-to-list 'load-path pylookup-dir)

;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup"
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

(require 'browse-url)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(require 'jinja2-mode)

; Go
(setenv "PATH" (concat "/usr/local/go/bin:/home/r0mant/code/goworld/bin:/Users/r0mant/code/goworld/bin:" (getenv "PATH")))
(setq exec-path (append exec-path '("/Users/r0mant/code/goworld/bin")))
(setq exec-path (append exec-path '("/home/r0mant/code/goworld/bin")))
(setq exec-path (append exec-path '("/usr/local/go/bin")))
(setenv "GOPATH" "/home/r0mant/code/goworld")
(require 'go-mode-autoloads)
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
(global-set-key (kbd "C-c j") 'godef-jump)
(global-set-key (kbd "C-c J") 'godef-jump-other-window)
(require 'go-guru)
(add-hook 'go-mode-hook 'go-guru-hl-identifier-mode)

; Lua
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

; Docker
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("*(D|d)ockerfile$" . dockerfile-mode))

; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

; JSX (React)
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

; ==============
; Python plugins
; ==============

;; (require 'flymake-point)

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes (quote ("c73c384550e8204077d230edf564b57d77bb0f80803781ca7ba3832aac9a84d8" default)))
;;  '(py-pychecker-command "~/.emacs.d/pychecker")
;;  '(py-pychecker-command-args (quote (""))))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(flymake-errline ((((class color)) (:underline "red"))))
;;  '(flymake-warnline ((((class color)) (:underline "orange")))))

;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))

;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; (setq flymake-no-changes-timeout 7)

;; (global-set-key (kbd "C-c f") 'flymake-error-under-point)


; ========
; Terminal
; ========

(require 'term)

(defun create-terminal (buffer-name)
  (interactive "sShell name: ")
  (ansi-term "/bin/bash")
  (rename-buffer (concat buffer-name ".terminal") t))

(setq ansi-term-color-vector [unspecified
                              "black"
                              "red3"
                              "lime green"
                              "yellow3"
                              "DeepSkyBlue?3"
                              "magenta3"
                              "cyan3"
                              "white"])


; ====
; Misc
; ====

;; (require 'multi-term)
;; (setq multi-term-program "/bin/bash")

; Binding to find and edit init.el

(defun edit-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

; IBuffer

(setq ibuffer-saved-filter-groups
      '(("ibuffer"
         ("emacs config" (filename . ".emacs.d"))
         ("analytics tests" (filename . "analytics/tests"))
         ("analytics" (filename . "analytics"))
         ("api tests" (filename . "api/tests"))
         ("api" (filename . "api"))
         ("arsenal tests" (filename . "arsenal/tests"))
         ("arsenal" (filename . "arsenal"))
         ("mgcore tests" (filename . "mgcore/tests"))
         ("mgcore" (filename . "mgcore"))
         ("website tests" (filename . "website/tests"))
         ("website" (filename . "website")))))
(setq ibuffer-show-empty-filter-groups nil)
(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)
             (ibuffer-switch-to-saved-filter-groups "ibuffer")))


; =========
; Shortcuts
; =========

(global-set-key (kbd "C-c d") 'duplicate-line)
(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "C-x ?") 'help-for-help)
;; (global-set-key [f11] 'toggle-fullscreen)
(global-set-key (kbd "C-c C-r") 'sudo-edit-current-file)
(global-set-key (kbd "C-c p") 'pep8)
(global-set-key (kbd "C-c P") 'pylint)
(global-set-key (kbd "C-c e") 'edit-init-file)
(global-set-key (kbd "M-p") 'move-line-up)
(global-set-key (kbd "M-n") 'move-line-down)
(global-set-key (kbd "C->") 'shift-region-right)
(global-set-key (kbd "C-<") 'shift-region-left)
(global-set-key (kbd "<C-S-up>") 'buf-move-up)
(global-set-key (kbd "<C-S-down>") 'buf-move-down)
(global-set-key (kbd "<C-S-left>") 'buf-move-left)
(global-set-key (kbd "<C-S-right>") 'buf-move-right)
(global-set-key [f3] 'rgrep)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c t") 'create-terminal)


; =============
; Mailgun stuff
; =============

(defun run-nosetests ()
  (let ((noseshell (concat (expand-file-name "~") "/" ".emacs.d" "/" "nosetests.sh")))
    (if (get-buffer "*nosetests*")
        (kill-buffer "*nosetests*"))
    (ansi-term noseshell "nosetests")))

(defun run-nosetests-all ()
  (interactive)
  (setenv "CURRENT_BUFFER" "")
  (run-nosetests))

(defun run-nosetests-current ()
  (interactive)
  (setenv "CURRENT_BUFFER" (buffer-file-name (current-buffer)))
  (run-nosetests))

(defun run-nosetests-project (project-name)
  (interactive
   (list
    (completing-read "Project name: " '("arsenal"
                                        "mgcore"
                                        "api"
                                        "website"
                                        "analytics"
                                        "reputation"
                                        "jobs"
                                        "turret"
                                        "mgcounter"
                                        "watchdog"
                                        "billing"
                                        "bunker"))))
  (setenv "CURRENT_BUFFER" project-name)
  (run-nosetests))

(defun deploy-master ()
  (interactive)
  (let ((deployshell (concat (expand-file-name "~") "/" ".emacs.d" "/" "deploy-master.sh")))
    (if (get-buffer "*deploy-master*")
        (kill-buffer "*deploy-master*"))
    (ansi-term deployshell "deploy-master")))

(defun run-website ()
  (interactive)
  (let ((website (concat (expand-file-name "~") "/" ".emacs.d" "/" "run-website.sh")))
    (if (get-buffer "*website*")
        (kill-buffer "*website*"))
    (ansi-term website "website")))

(defun run-api ()
  (interactive)
  (let ((api (concat (expand-file-name "~") "/" ".emacs.d" "/" "run-api.sh")))
    (if (get-buffer "*api*")
        (kill-buffer "*api*"))
    (ansi-term api "api")))

(defun run-queue ()
  (interactive)
  (let ((queue (concat (expand-file-name "~") "/" ".emacs.d" "/" "run-queue.sh")))
    (if (get-buffer "*queue*")
        (kill-buffer "*queue*"))
    (ansi-term queue "queue")))

(defun run-jobs ()
  (interactive)
  (let ((jobs (concat (expand-file-name "~") "/" ".emacs.d" "/" "run-jobs.sh")))
    (if (get-buffer "*jobs*")
        (kill-buffer "*jobs*"))
    (ansi-term jobs "jobs")))

(defun run-analytics ()
  (interactive)
  (let ((jobs (concat (expand-file-name "~") "/" ".emacs.d" "/" "run-analytics.sh")))
    (if (get-buffer "*analytics*")
        (kill-buffer "*analytics*"))
    (ansi-term jobs "analytics")))


; =================
; Mailgun shortcuts
; =================

(global-set-key (kbd "C-c n") 'run-nosetests-all)
(global-set-key (kbd "C-c b") 'run-nosetests-current)
(global-set-key (kbd "C-c B") 'run-nosetests-project)
; (global-set-key (kbd "C-c d") 'deploy-master)
; (global-set-key (kbd "C-c s") 'start-development-server)

; ===========
; Experiments
; ===========

;; (define-minor-mode vim-nav-mode
;;   "Vim-style navigation (hjkl)",
;;   :init-value nil
;;   :lighter " Vim-Nav"
;;   :keymap
;;   `(;; (, (kbd "h") . backward-char)
;;     ;; (, (kbd "j") . next-line)
;;     ;; (, (kbd "k") . previous-line)
;;     ;; (, (kbd "l") . forward-char)
;;     (, (kbd "j") . (lambda () (interactive) (scroll-up 1)))
;;     (, (kbd "k") . (lambda () (interactive) (scroll-down 1))))
;;   :global 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8abee8a14e028101f90a2d314f1b03bed1cde7fd3f1eb945ada6ffc15b1d7d65" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "01ce486c3a7c8b37cf13f8c95ca4bb3c11413228b35676025fdf239e77019ea1" default)))
 '(package-selected-packages
   (quote
    (rjsx-mode terraform-mode tango-2-theme solarized-theme reykjavik-theme protobuf-mode markdown-mode json-mode groovy-mode go-rename go-playground go-guru docker))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
