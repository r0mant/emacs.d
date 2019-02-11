(require 'color-theme)

(defvar mailgun-fg "#000000")
(defvar mailgun-fg-inactive "grey50")

(defvar mailgun-bg "grey98")
(defvar mailgun-line "grey70")
(defvar mailgun-bg-dark "light steel blue")
(defvar mailgun-bg-warning "burlywood3")
(defvar mailgun-border "light grey")

(defvar mailgun-function "brown")
(defvar mailgun-keyword "steel blue")
(defvar mailgun-constant "forest green")
(defvar mailgun-comment "grey40")
(defvar mailgun-type "MediumOrchid4")



(defun color-theme-mailgun ()
  "Color theme for Emacs used @mailgun."
  (interactive)
  (color-theme-install
   `(color-theme-mailgun
     ((background-color . ,mailgun-bg)
      (background-mode . dark)
      (border-color . ,mailgun-fg)
      (cursor-color . ,mailgun-fg)
      (foreground-color . ,mailgun-fg)
      (mouse-color . "black"))

     ;; Font-locks
     (font-lock-function-name-face ((t (:foreground ,mailgun-function))))

     (font-lock-keyword-face ((t (:foreground ,mailgun-keyword))))
     (font-lock-variable-name-face ((t (:foreground ,mailgun-keyword))))

     (font-lock-constant-face ((t (:foreground ,mailgun-constant))))
     (font-lock-string-face ((t (:foreground ,mailgun-constant)))) ;;:font "Inconsolata-italics-13"))))
     (font-lock-comment-face ((t (:foreground ,mailgun-comment)))) ;; :font "Inconsolata-italics-13"))))

     (font-lock-builtin-face ((t (:foreground ,mailgun-type))))
     (font-lock-type-face ((t (:foreground ,mailgun-type))))

     ;; Flymake stuff
     (flymake-errline ((t (:background ,mailgun-bg-warning))))

     ;; Hightlighting and region selection
     (region ((t (:foreground ,mailgun-fg :background ,mailgun-bg-dark))))
     (isearch ((t (:background ,mailgun-bg-dark :foreground ,mailgun-fg))))
     (isearch-lazy-highlight-face ((t (:foreground ,mailgun-fg :background ,mailgun-bg-dark))))

     ;; Parenthesis Matching
     (paren-face-match ((t (:inherit show-paren-match-face))))
     (paren-face-match-light ((t (:inherit show-paren-match-face))))
     (paren-face-mismatch ((t (:inherit show-paren-mismatch-face))))

     (show-paren-match-face ((t (:background ,mailgun-bg :foreground ,mailgun-fg :bold t))))
     (show-paren-mismatch-face ((t (:background ,mailgun-bg-warning :foreground ,mailgun-fg :bold t))))

     ;; UI Items - fringe and border
     (fringe ((t (:background ,mailgun-border))))
     (minibuffer-prompt ((t (:foreground ,mailgun-keyword))));; :bold t))))
     (mode-line ((t (:background ,mailgun-border :foreground ,mailgun-fg :box (:line-width 1 :color ,mailgun-line :style nil)))))
     (mode-line-inactive ((t (:background ,mailgun-border :foreground ,mailgun-fg-inactive :box (:line-width 1 :color ,mailgun-line :style nil)))))
     (mode-line-emphasis ((t (:bold t))))
     (mode-line-highlight ((t (:background ,mailgun-bg-dark :box nil))))
)))

(provide 'color-theme-mailgun)
