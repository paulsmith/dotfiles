;; Main .emacs for sharing across machines (Emacs 22+) -- machine
;; specific settings are in local.el

;; set up load path
(setq load-path
      `("~/.emacs.d"
	"~/src/clojure-mode"
	"~/src/swank-clojure/src/emacs"
	"~/src/slime"
	"~/src/go/misc/emacs"
        ,@load-path))

;; startup quietly
(setq inhibit-startup-message t)
(setq inhibit-echo-area-message t)

;; load local settings if present
(load "local.el" t)

;; start Emacs server -- attach with emacsclient
(server-start)

;; keep all backup and autosave files in ~/.emacs-backup
(defvar user-temporary-file-directory
  "~/.emacs-backup")
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
	(,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

;; default to sane encodings
(prefer-coding-system 'utf-8-unix)
(set-variable 'default-buffer-file-coding-system 'utf-8-unix)

;; all lines should max out at 79 characters (PEP 8!)
(set-fill-column 79)

;; C-w is best for deleting the previous word, ala vim and shell
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; Press 'e' in dired to edit filenames
(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)))

;; styles
(set-background-color "black")
(set-foreground-color "white")
(set-cursor-color "cyan")
(set-mouse-color "goldenrod")
(setq frame-background-mode 'dark)
(set-face-background 'modeline "#8B0000")
(set-face-foreground 'modeline "#ffffff")

;; disable suspend, which doesn't work well with xmonad
(global-set-key (kbd "C-z") nil)

;; tabs v. spaces
(setq tab-width 4)
(setq c-basic-offset 4) ;; amount of tab key indentation
(setq indent-tabs-mode nil) ;; insert spaces for indentation

;; disable window chrome
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; show the line and column number in the mode line
(line-number-mode 1)
(column-number-mode 1)

;; handle shell color (M-x shell)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; Turn off word wrap and make shell prompt read-only
(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

;; easy underline function -- "C-c u" then the underline char
(defun ps-make-underline (line-char)
  "Inserts an underline the same length as the line above"
  (interactive "cUnderline character: ")
  (save-excursion
    (previous-line)
    (end-of-line)
    (let ((len (current-column)))
      (newline)
      (insert-char line-char len))))
(global-set-key (kbd "C-c u") 'ps-make-underline)

;; make interacting with the X11 clipboard sane
(global-set-key [(shift delete)]   'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [(shift insert)]   'clipboard-yank)

;; display and delete trailing whitespace
;;  C-c e -- display trailing ws
;;  C-c w -- delete trailing ws
(defun ps-toggle-display-whitespace ()
  (interactive)
  (save-excursion
    (setq show-trailing-whitespace
      (not show-trailing-whitespace))
    (force-window-update (current-buffer))
  (message (concat "Display of EOL spaces "
           (if show-trailing-whitespace
               "enabled"
             "disabled")))))
(global-set-key "\C-ce" 'ps-toggle-display-whitespace)
(global-set-key "\C-cw" 'delete-trailing-whitespace)

;; virtualenv support
(defun virtualenv-insert-load-line (virtualenv-dir)
  "Activate a virtualenv for your current interactive Python shell"
  (interactive "DVirtualenv directory: ")
  (let ((activate-file (expand-file-name (concat virtualenv-dir "./bin/activate_this.py"))))
    (if (file-exists-p activate-file)
        (insert
         (concat "execfile('" activate-file
                 "', dict(__file__='" activate-file "'))"))
      (error "No ./bin/activate_this.py in that virtualenv (maybe update virtualenv?)"))))
(global-set-key (kbd "C-x v") 'virtualenv-insert-load-line)

;; M-# comments out the region
(global-set-key (kbd "M-#") 'comment-region)

;; toggle line number display
(global-set-key (kbd "C-c n") 'global-linum-mode)

;; F5 compiles / calls make
(global-set-key (kbd "<f5>") 'recompile)

;; F6 stores a position in a file, F7 brings you back to this position
(global-set-key (kbd "<f6>") '(lambda () (interactive) (point-to-register ?1)))
(global-set-key (kbd "<f7>") '(lambda () (interactive) (register-to-point ?1)))

;; really useful feature to avoid over-long lines in source code
(global-set-key (kbd "<f9>") 'highlight-beyond-fill-column)

;; align text with C-x \
(global-set-key (kbd "C-x \\") 'align-regexp)

;; save sessions between restarts (hallelujah)
(desktop-save-mode 1)

;; modes -------------------------------------------------------------

;; python-mode.el -- https://launchpad.net/python-mode
(autoload 'python-mode "python-mode" "Python mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'python-mode-hook
	  (lambda ()
	    (set (make-variable-buffer-local 'beginning-of-defun-function)
		 'py-beginning-of-def-or-class)
	    (setq outline-regexp "def\\|class ")))
(require 'ipython)

;; tramp -- remote editing
(require 'tramp)
(setq tramp-default-method "ssh")

;; nxhtml -- multi-mode editing of HTML files (like Django templates)
(load "nxhtml/autostart.el")
(global-set-key (kbd "C-c D") 'django-html-mumamo-mode)

;; CSS

; CSS color values colored by themselves
; http://xahlee.org/emacs/emacs_html.html
  
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background 
                     (match-string-no-properties 0)))))))
  
(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)

;; Clojure
(require 'clojure-mode)
(setq swank-clojure-jar-path "~/.clojure/clojure.jar"
      swank-clojure-extra-classpaths (list
				      "~/src/swank-clojure/src/main/clojure"
				      "~/.clojure/clojure-contrib.jar"))
(require 'swank-clojure-autoload)
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))
(require 'slime)
(slime-setup)

;; Fix a HTML export bug in org-mode
(eval-after-load "htmlize"
  '(progn
(defadvice htmlize-faces-in-buffer (after org-no-nil-faces activate)
       "Make sure there are no nil faces"
       (setq ad-return-value (delq nil ad-return-value)))))

;; Magit
(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)

;; Go
(require 'go-mode-load)

;; ido-mode
;; do not confirm a new file or buffer
(setq confirm-nonexistent-file-or-buffer nil)
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-tramp-completion nil)
(setq ido-enable-last-directory-history nil)
(setq ido-confirm-unique-completion nil) ;; wait for RET, even for unique?
(setq ido-show-dot-for-dired t) ;; put . as the first item
(setq ido-use-filename-at-point t) ;; prefer file names near point

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(grep-files-aliases (quote (("asm" . "*.[sS]") ("c" . "*.c") ("cc" . "*.cc *.cxx *.cpp *.C *.CC *.c++") ("cchh" . "*.cc *.[ch]xx *.[ch]pp *.[CHh] *.CC *.HH *.[ch]++") ("hh" . "*.hxx *.hpp *.[Hh] *.HH *.h++") ("ch" . "*.[ch]") ("el" . "*.el") ("h" . "*.h") ("l" . "[Cc]hange[Ll]og*") ("m" . "[Mm]akefile*") ("tex" . "*.tex") ("texi" . "*.texi") ("py" . "*.py"))))
 '(ipython-command "/home/paul/.virtualenvs/everyblock/bin/ipython"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
