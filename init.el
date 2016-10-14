;; init.el --- Emacs configuration of Cody Chan
;;
;; Copyright (c) 2012-2014 Cody Chan <cody.chan.cz@gmail.com>
;;
;; Author: Cody Chan <cody.chan.cz@gmail.com>
;; URL: https://github.com/c0dy/dotemacs.d
;; Keywords: convenience
;;
;; This file is not part of GNU Emacs.
;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation; either version 3 of the License, or (at your option) any later
;; version.
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;; details.
;; You should have received a copy of the GNU General Public License along with
;; GNU Emacs; see the file COPYING. If not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
;; USA.
;;
;; If you want to using package manager like Vundle, use
;; https://github.com/lunaryorn/.emacs.d/blob/master/init.el#L176
;; http://oli.me.uk/2014/10/20/making-package-el-behave-like-vundle/
;; https://github.com/Wolfy87/dotfiles/blob/d24591ebd7b3a36f629fb5a4ebd921c72f2b5b91/emacs/init.el#L61-L96
;; http://www.reddit.com/r/emacs/comments/2jtojf/packageel_didnt_prune_my_unused_packages_so_i/
;; http://www.lonecpluspluscoder.com/2014/11/set-emacs-use-melpa-melpa-stable

;; byte compile emacs lisp files of current dir
;; emacs -batch -f batch-byte-compile *.el
;; I just found that you can just use the MENU
;; (the one between the Right-Alt and Right-Ctrl key) key
;; to replace M-x
;;
;; http://tuhdo.github.io/emacs-tutor3.html
;; Three ways to set a global key
;; (global-set-key (kbd "C-x C-b") 'ibuffer) ;; recommended
;; (global-set-key "\C-x\C-b" 'ibuffer)
;; (global-set-key [?\C-x?\C-b] 'ibuffer)
;;
;; the kbd issue
;; F1-f edmacro-mode
;; (kbd "C-<backspace>")
;; (kbd "<f7>")
;; [(f8)]
;; [f9]
;; "\C-ce"
;; "\M-n"
;; "\C-x\ \C-r"
;; (kbd "SPC")
;; (kbd "")
;; (kbd "C-x C-b")
;; (kbd "RET")
;; (kbd "<end/home>") ; End/Home
;; (kbd "<prior/next>") ; PageUp/Down
;; (kbd "<backtab") ;; S-TAB or C-iso-tab
;; (kbd "<S-return>")
;; (kbd "S-C-<left>")
;; (kbd "C-x <up>")
;; (kbd "C-{")
;; (kbd "C-<tab>") -- C-S-tab
;; (kbd "C-S-<iso-lefttab>")
;; (kbd "C->")
;; [(meta control S)]
;; [(meta control s)]


;; C-h b to show all the shortkeys
;;
;; shortcuts summary:
;; M-x check-parens to quickly check for mismatched parentheses
;; M-x info-apropos to search all info manuals
;; C-h e switch to buffer *Message*
;; C-h m 'describe-mode show all active modes and brief description
;; C-M-a/e 'beginning/end-of-defun
;; C-M-h 'mark-defun
;; C-S-m for 'menu-bar-mode
;; Enter or C-j to 'newline-and-indent
;; C-c e to 'show-ws-toggle-show-trailing-whitespace
;; F7 to 'switch-to-minibuffer-window
;; F8 to make the frame transparent
;; F9 to 'search-all-buffers
;; C-c r to 'rev('revert-buffer)
;; C-x s to 'sh('shell)
;; C-x C-r to 'recentf-open-files
;; C-k to 'kill-line to the end of the line
;; M-k to 'kill-line to the beginning of the line
;; S-C-<left> to 'shrink-window-horizontally
;; S-C-<right> to 'enlarge-window-horizontally
;; S-C-<down> to 'shrink-window
;; S-C-<up> to 'enlarge-window
;; C-x c to 'emacs-lisp-byte-compile-and-load
;; C-c d to 'delete-trailing-whitespace
;; C-x C-j to 'dired-jump
;; C-c y to 'yas-reload-all
;; C-c a to 'align-regexp
;; C-M-n/p Move forward/backward over a parenthetical group
;; C-M-u/d Move up/down in parenthesis structure
;; M-$ -> i -> y to insert the string into personal dictionary
;;           the personal dictionary asides in ~/.hunspell_en_US
;;           file has already been linked to .emacs.d/
;; in the comment, if you want to insert another comment line, use M-j
;; M-m 'back-to-indentation move point to first non-whitespace character
;; M-x find-library will lead you to the right .el file

;; Windows style line endings (DOS support)
;; C-x RET f undecided-dos RET	   --> \r\n (windows)
;; C-x RET f undecided-unix RET	   --> \n  (unix/Linux)
;; M-x tabify/untabify convert from spaces to tabs and vice verse
;; NOTE: call untabify/tabify with prefix argument, it will convert for the entire buffer

;; If Emacs stucks at startup, uncomment the following lines or put
;; 255.255.255.255 host.does.not.exist
;; in /etc/hosts
;; (setq tramp-default-method "ssh")
;; (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

;;; Code:
;; (setq debug-on-error t)

;; make starup quicker
(setq gc-cons-threshold (* 100 1024 1024))
(let ((file-name-handler-alist nil)) "~/.emacs.d/init.elc")

;; proxy goagent
;; (setq url-proxy-services '(("http*" . "127.0.0.1:8087")))

;; Makes *scratch* empty.
;;(setq initial-scratch-message "")

;; encode, the last line will be the highest priority
(set-language-environment 'UTF-8)
(setq-default path-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(prefer-coding-system 'cp950)
(prefer-coding-system 'gb2312)
(prefer-coding-system 'cp936)
(prefer-coding-system 'gb18030)
;;(prefer-coding-system 'utf-16le-with-signature)
(prefer-coding-system 'utf-16)
(prefer-coding-system 'utf-8)
;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)

;; http://www.toryanderson.com/tech/upgrading-emacs-built-org-mode-4-easy-steps
;; Add this before setting any Org option(loading org-mode)
;; and M-x package-install under `emacs -q`(prevents it from loading my .emacs file,
;; which includes many references to org-mode stuff.)
;; to prevent two versions of org-mode messed-up
(package-initialize)
(require 'bind-key)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(defalias 'man 'woman)
;; use man for a function inside Emacs
(dolist (hook
		 '(
		   ;; c-mode-hook
		   ;; c++-mode-hook
		   c-mode-common-hook))
  (add-hook hook
			(lambda ()
			  (local-set-key (kbd "C-h d")
							 (lambda ()
							   (interactive)
							   (manual-entry (current-word)))))))

(setq byte-compile-warnings nil)
(defalias 'eit 'emacs-init-time)
;; re/compile every elisp file when saving it
(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(add-hook 'after-save-hook 'emacs-lisp-byte-compile t t)))
;; Delete the existed/no-existed .emacs.elc and recompile and reload
(defun byte-compile-init-file ()
  (when (equal user-init-file buffer-file-name)
	(when (file-exists-p (concat user-init-file ".elc"))
	  (delete-file (concat user-init-file ".elc")))
	(emacs-lisp-byte-compile-and-load)))
(add-hook 'after-save-hook 'byte-compile-init-file)
;; find ~/.emacs.d -name "*.elc" | xargs rm -rfv
;; C-0 M-x bd or M-x bd C-0 to bd
(defalias 'bd 'byte-recompile-directory)
;; byte-comple and load *.el using "C-x c"
(bind-keys :map emacs-lisp-mode-map
		   ("C-x c" . emacs-lisp-byte-compile-and-load)
		   ("C-c c" . eval-buffer))
(bind-keys*
 ("C-c C-e" . (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
 ("C-c C-u" . (lambda () (interactive) (find-file "/run/media/chz/UDISK/WORK-HOME")))
 ("C-c C-r" . (lambda () (interactive) (load-file "~/.emacs.d/init.elc")))
 ;; C-h e to switch to *Message* buffer
 ("C-x M-z" . (lambda () (interactive) (switch-to-buffer "*scratch*"))))

;; assembly
;; replace auto-mode-alist for multiple extensions
(mapc
 (lambda (file)
   (add-to-list 'auto-mode-alist
				(cons (concat (regexp-quote file) "\\'") 'org-mode)))
 '(".asm" ".s" ".S"))
;; To set your own indentation level to 4:
(add-hook 'nasm-mode-hook
		  (lambda () (setq-default nasm-basic-offset 4)))

;; compile
;; use `C-c ! n/p` 'flycheck-next/previous-error to navigate errors
;; or use M-g n/p for next/previous-error
(require 'compile)
(setq compilation-last-buffer nil)
;; save all modified buffers without asking before compilation
(setq compilation-ask-about-save nil)
(defun compile-again (ARG)
  "Run the same compile as the last time.

First split the current source code window in a given size if
no existed window contains *compilation* buffer.

With a prefix argument or no last time, this acts like M-x compile,
and you can reconfigure the compile args."
  (interactive "p")
  (if (not (get-buffer-window "*compilation*"))
	  (split-window-vertically -10))
  (if (and (eq ARG 1) compilation-last-buffer)
	  (recompile)
	(call-interactively 'compile)))
(bind-key* "C-x C-m" 'compile-again)
;; 1.
;; (defun compilation-exit-autoclose (STATUS code msg)
;;   "Close the compilation window if there was no error at all."
;;   (when (and (eq STATUS 'exit) (zerop code))
;; 	(bury-buffer)
;; 	(delete-window (get-buffer-window (get-buffer "*compilation*" t))))
;;   (cons msg code))
;; (setq compilation-exit-message-function 'compilation-exit-autoclose)
;; 2.
(setq compilation-finish-functions
	  (lambda (buf str)
		(if (null (string-match ".*exited abnormally.*" str))
			;;no errors, make the compilation window go away in a few seconds
			(progn
			  (run-at-time
			   "1 sec" nil 'delete-windows-on
			   (get-buffer-create "*compilation*"))
			  (message "No Compilation Errors!")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Emacs Face Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq bookmark-save-flag t)
(setq column-number-mode t)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook 'highlight-beyond-fill-column)

;; C-x </> 'scroll-left/right if line is too long
(put 'scroll-left 'disabled nil)
(setq comment-style 'extra-line)
;; file size in mode line
(setq size-indication-mode t)
;; symbol to indicate the end of the buffer
(setq-default indicate-empty-lines t)
;; change the color and symbol of the tilde
(progn
  (define-fringe-bitmap 'tilde [0 0 0 113 219 142 0 0] nil nil 'center)
  (setcdr (assq 'empty-line fringe-indicator-alist) 'tilde))
(set-fringe-bitmap-face 'tilde nil)
(set-fringe-mode '(8 . 0))
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(require 'nlinum)
(bind-keys*
 ("C-S-m" . menu-bar-mode)
 ("C-S-l" . nlinum-mode))
;; scroll text up/down by one line, not cursor
(global-set-key (kbd "C-M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "C-M-p") (kbd "C-u 1 M-v"))

;; in c-mode
(setq c-backspace-function 'backward-delete-char)
;; Toggle which-function-mode and projectile-global-mode, useful after finishing using tramp.
;; Do not use when using tramp, it will stuck tramp a little bit
(global-set-key (kbd "C-S-p")
				'(lambda ()
				   (interactive)
				   (if (bound-and-true-p which-function-mode)
					   (which-function-mode -1)
					 (which-function-mode 1))
				   (if (bound-and-true-p projectile-global-mode)
					   (projectile-global-mode -1)
					 (projectile-global-mode 1))))

;; line space between lines, default to 0
;; (setq line-spacing 2)
;;
;; display buffer name or absolute file path name in the frame tittle
;; NOTE: you should comment the last line of
;; /usr/share/emacs/site-lisp/default.el, or this setting won't work
;; and put time in frame-title to make the mode line clean
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq global-mode-string nil)
;; this will not always show the day of week, weird
;; (setq frame-title-format
;; '("%b@%f" "--" display-time-string))
(setq frame-title-format
	  '("%b" (:eval (if (buffer-file-name)
						(concat "@"
								(abbreviate-file-name default-directory))))
		" - " display-time-string))
;;
;; syntax highlight
(global-font-lock-mode t)
;; highlight TODO:/NOTE:/FIXME:/BUG: keywords
(dolist (hook '(prog-mode-hook org-mode-hook))
  (add-hook hook
			(lambda ()
			  (font-lock-add-keywords
			   nil
			   ;; '(("\\<\\(TODO\\|FIXME\\|BUG\\):" 1
			   '(("\\<\\(TODO:\\|NOTE:\\|FIXME:\\|BUG:\\)" 1
				  font-lock-warning-face t))))))

;; Turn on font lock mode in all the files
(setq font-lock-maximum-decoration t)
;;
;; Improve performance when editing large size of file
(defadvice helm-find-files (after helm-find-files activate)
  ;; "If a file is over a given size, turn off minor modes."
  (progn
	(when (> (buffer-size) (* 1024 100)) ;; 100 KB
	  (when (> (buffer-size) (* 1024 1024)) ;; 1 MB
		(require 'vlf)
		(vlf-mode))
	  (linum-mode -1))))
;; C-x C-s to use save-buffer for regular files and use sudo to prompt passwd to
;; save file need root permission, C-x C-q to edit the root file first
;; Note that this C-x C-s will fail if the buffer is not a file, in this case,
;; use C-x C-w instead
(global-set-key (kbd "C-x C-s")
				'(lambda ()
				   (interactive)
				   (progn
					 (if (file-writable-p buffer-file-name) (save-buffer)
					   (write-file (concat "/sudo:root@localhost:" buffer-file-name))))))

;; displays the argument list for current func, work for all languages
(eldoc-mode)
(dolist (mode '(prog-mode-hook python-mode-hook ielm-mode-hook))
  (add-hook mode
			'(lambda ()
			   (eldoc-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;   theme & font
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; theme
;;
;; Enabling a light theme temporarily, use M-x load-theme <TAB> flatui if you
;; want to enable it after start up, add the two lines like below
;;
;; the following will get rid of prompt when M-x load-theme, treat all
;; themes as safe
(setq custom-safe-themes t)
;;
;; afternoon
;; (require 'afternoon-theme)
;;
;; ;; molokai
;; (load-theme 'molokai t)
;; (require 'molokai-theme)
;;
;; moe-theme, a very colorful and powerful theme
;; for more setting at https://github.com/kuanyui/moe-theme.el
(require 'moe-theme)
;; Resize titles
(setq moe-theme-resize-markdown-title '(1.3 1.2 1.1 1.0 1.0 1.0))
(setq moe-theme-resize-org-title '(1.3 1.2 1.1 1.0 1.0 1.0 1.0 1.0 1.0))
;; disable default mode-line buffer-id highlight
(setq moe-theme-highlight-buffer-id nil)
(moe-dark)
;;
;; font and size of startup
;;
;; List all fonts available to emacs
;; (print (font-family-list))
;;
;; Test font in current session;
;; Set font for all windows, keep window size fixed
;; (set-frame-font "PragmataPro-10" t t)
;; set font for all windows, don't keep window size fixed
;; (set-frame-font "PragmataPro-10" nil t)
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
	  (progn
		;; use 120 char wide window for largish displays
		;; and smaller 80 column windows for smaller displays
		;; pick whatever numbers make sense for you
		(if (> (x-display-pixel-width) 1500)
			;; (add-to-list 'default-frame-alist (cons 'width 85))
			;; (add-to-list 'default-frame-alist (cons 'width 85)))
			(setq default-frame-alist
				  '((top . 0) (left . 0)
					(width . 95) (height . 48)
					;; or Monaco, Bitstream Vera Sans Mono, Liberation Mono
					(font . "Input Mono Compressed-14")))
		  (setq default-frame-alist
				'((top . 0) (left . 0)
				  (width . 85) (height . 37)
				  (font . "Input Mono Compressed-13.5")
				  ;; (font . "PragmataPro-13")
				  ;; (:family "Menlo-Italic")
				  )))))
  ;; the following two settings are specifically for afternoon-theme
  ;; the combination colors of highlighted line and comments
  ;; (custom-set-faces
  ;;  '(font-lock-comment-face
  ;; 	 ((t (:foreground "gray60" :slant italic :weight normal :family "Menlo")))
  ;; 	 ))
  ;; (set-face-background 'highlight "gray30")
  )
;;
(set-frame-size-according-to-resolution)
;;
;; disable scroll-bar-mode in newly created frame
(add-hook 'after-make-frame-functions
		  '(lambda (frame)
			 (modify-frame-parameters
			  frame
			  '((vertical-scroll-bars . nil)
				(horizontal-scroll-bars . nil)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;        all about mode line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; do no just use ("%2b"), or stick-buffer function won't work
(setq-default
 mode-line-buffer-identification
 '(#("%2b" 0 3
	 (local-map
	  (keymap
	   (header-line keymap
					(mouse-3 . mode-line-next-buffer)
					(down-mouse-3 . ignore)
					(mouse-1 . mode-line-previous-buffer)
					(down-mouse-1 . ignore))
	   (mode-line keymap
				  (mouse-3 . mode-line-next-buffer)
				  (mouse-1 . mode-line-previous-buffer)))
	  mouse-face mode-line-highlight help-echo
	  "Buffer name\nmouse-1: Previous buffer\nmouse-3: Next buffer"
	  face mode-line-buffer-id))))
;; show which function in mode-line
(which-function-mode 1)
;; make which-function-mode work only for specific modes
(eval-after-load "which-func"
  '(setq which-func-modes '(c-mode c++-mode emacs-lisp-mode python-mode)))
;; replace ??? to n/a
(setq which-func-unknown "n/a")
(set-face-attribute 'which-func nil :background nil :foreground nil)
;; repalce the 8 with other number to change the position
(let ((which-func '(which-func-mode ("" which-func-format " "))))
  (setq-default mode-line-format
				(remove which-func mode-line-format))
  (setq-default mode-line-misc-info
				(remove which-func mode-line-misc-info))
  (setq cell (last mode-line-format 8)) ;; just next to buffer name
  (setcdr cell (cons which-func (cdr cell))))
;; line/column/percent/size, just "(%l,%c)[%p/%I]" if not highlight
(setq-default mode-line-position
			  '(("(%l_"
				 (:eval (propertize "%c" 'face
									(if (>= (current-column) 80)
										'mode-line-80col-face
									  'mode-line-position-face)))
				 "|%p_%I) ")))
;; highlight when point is over 80th column
(make-face 'mode-line-80col-face)
(make-face 'mode-line-position-face)
(set-face-attribute 'mode-line-80col-face nil :background "red1")
(set-face-attribute 'mode-line-position-face nil)
(set-face-attribute 'mode-line nil :background "dim gray" :foreground "white")
(set-face-attribute 'mode-line-buffer-id nil :foreground nil :background nil)
(set-face-attribute 'mode-line-inactive nil :background nil)
;; mode-line color

;; whole structure of mode line
(setq-default mode-line-format
			  '(
				"%e"
				mode-line-front-space
				mode-line-mule-info
				mode-line-client
				mode-line-modified
				mode-line-remote
				mode-line-frame-identification
				mode-line-buffer-identification
				(which-func-mode
				 ("" which-func-format " "))
				" " mode-line-position
				(vc-mode vc-mode)
				" " mode-line-modes
				mode-line-misc-info
				"%-"))

(global-hl-line-mode 1)
(set-face-attribute hl-line-face nil :underline t)
(set-default 'cursor-type '(bar . 3))
(setq-default cursor-in-non-selected-windows 1)

;; highlight the active window
;; flash the active window
(bind-key* "s-<f12>" 'flash-active-buffer)
(make-face 'flash-active-buffer-face)
(set-face-attribute 'flash-active-buffer-face nil
                    :background "blue" :foreground nil)
(defun flash-active-buffer ()
  (interactive)
  (run-at-time "150 millisec" nil
               (lambda (remap-cookie)
                 (face-remap-remove-relative remap-cookie))
               (face-remap-add-relative 'default 'flash-active-buffer-face)))
;; another way to highlight the active window
(defun highlight-active-window ()
  "Highlight active window with a different background color."
  (walk-windows (lambda (w)
                  (unless (eq w (selected-window))
                    (with-current-buffer (window-buffer w)
                      (buffer-face-set '(:background "#111"))))))
  (buffer-face-set 'default))
(add-hook 'buffer-list-update-hook 'highlight-active-window)

;; using a visible bell when error occurs
;;(setq visible-bell t)

;; Using F8 to make the face transparent
(bind-key* "<f8>" 'loop-alpha)
(setq alpha-list '((70 70) (100 100)))
;; When showing warning: reference to free variable `alpha-list'
;; add the `(defvar alphs-list)`
(defvar alpha-list)
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))
	((lambda (a ab)
	   (set-frame-parameter (selected-frame) 'alpha (list a ab))
	   (add-to-list 'default-frame-alist
					(cons 'alpha (list a ab))))
	 (car h) (car (cdr h)))
	(setq alpha-list (cdr (append alpha-list (list h))))))

;; ;; smooth-scrolling, just deal with C-n/p and arrow
(setq redisplay-dont-pause t
	  scroll-margin 1
	  scroll-step 1
	  scroll-conservatively 10000
	  auto-window-vscroll nil
	  scroll-preserve-screen-position 1)
(setq-default
 scroll-up-aggressively 0.01
 scroll-down-aggressively 0.01)
;; deal with C/M-v and mouse/touchpad
(require 'smooth-scroll)
(smooth-scroll-mode t)
(setq mouse-wheel-scroll-amount '(0.08)
	  mouse-wheel-progressive-speed nil)

;; set the query-replace from top
(defun query-replace-from-top ()
  (interactive)
  (save-excursion
	(goto-char (point-min))
	(call-interactively 'query-replace)))
(bind-key* "M-%" 'query-replace-from-top)

;; flush blank lines
(defun flush-blank-lines (start end)
  (interactive "r")
  (flush-lines "^\\s-*$" start end nil))

(bind-keys*
 ("C-S-a" . beginning-of-visual-line)
 ("C-S-e" .
  (lambda ()
	(interactive)
	(end-of-visual-line)
	(backward-char))))
(defun keep-beginning-of-line (ARG)
  "Make `C-a` keep going to first non-whitespace character _and_then_ beginning of
  next line(previous with C-u).
It will not work as expected in comment block because of goddamn rebox2"
  (interactive "P")
  (when (bolp) (forward-line (if ARG -1 1)))
  (let ((orig-point (point)))
	(back-to-indentation)
	(when (= orig-point (point))
	  (move-beginning-of-line 1))))
(defun keep-end-of-line (ARG)
  "Make `C-e` keep going to end of next line(previous with C-u).
It will become normal in comment block because of goddamn rebox2"
  (interactive "P")
  (when (eolp) (forward-line (if ARG -1 1)))
  (move-end-of-line nil))
;; (global-set-key [remap move-beginning-of-line] #'keep-beginning-of-line)
;; (global-set-key [remap move-end-of-line] #'keep-end-of-line)
(bind-keys*
 ("C-a" . keep-beginning-of-line)
 ("C-e" . keep-end-of-line))

(defun increment-region (&optional beg end ARG)
  "Increment all decimal numbers in region between `beg' and `end' by `ARG'.
If no prefix ARG is given, increment by 1.
If the mark is not active, try to build a region using `symbol-at-point'."
  (interactive "r\np")
  (or ARG (setq ARG 1))
  (unless (and mark-active transient-mark-mode)
	(let ((bounds (bounds-of-thing-at-point 'symbol)))
	  (if bounds (setq beg (car bounds) end (cdr bounds)))))
  (if (< end beg)
	  (let ((tmp end))
		(setq beg end end tmp)))
  (save-excursion
	(goto-char beg)
	(while (re-search-forward "-?[0-9]+" end t)
	  (replace-match (number-to-string (+ ARG (string-to-number (match-string 0)))))))
  (setq deactivate-mark nil))
;;
(defun decrement-region (&optional beg end ARG)
  "Decrement all decimal numbers in region between `beg' and `end' by `ARG'.
 If no prefix ARG is given, increment by 1.
 If the mark is not active, try to build a region using `symbol-at-point'."
  (interactive "r\np")
  (or ARG (setq ARG 1))
  (unless (and mark-active transient-mark-mode)
	(let ((bounds (bounds-of-thing-at-point 'symbol)))
	  (if bounds (setq beg (car bounds) end (cdr bounds)))))
  (increment-region beg end (- ARG)))
(bind-keys*
 ("S-M-<up>" . increment-region)
 ("S-M-<down>" . decrement-region))

;; make the default sentence ending with two spaces concept nil
;; Now it work for expand-region to expand sentence
(setq sentence-end-double-space nil)

;; You can do M-c/u/l the whole word in any position inside the word
(defadvice endless/upcase (before upcase-word-advice activate)
  (unless (looking-back "\\b")
	(backward-word)))
(defadvice endless/downcase (before downcase-word-advice activate)
  (unless (looking-back "\\b")
	(backward-word)))
(defadvice endless/capitalize (before capitalize-word-advice activate)
  (unless (looking-back "\\b")
	(backward-word)))
;; TODO: make the following function accept arg-num
(defun toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Toggles between: “all lower”, “Init Caps”, “ALL CAPS”.

Based on the comment of http://ergoemacs.org/emacs/modernization_upcase-word.html"
  (interactive)
  (let (p1 p2 (deactivate-mark nil) (case-fold-search nil))
	(if (region-active-p)
		(setq p1 (region-beginning) p2 (region-end))
	  (let ((bds (bounds-of-thing-at-point 'word)))
		(setq p1 (car bds) p2 (cdr bds))))
	(when (and p1 p2)
	  (when (not (eq last-command this-command))
		(save-excursion
		  (goto-char p1)
		  (cond
		   ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
		   ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps"))
		   ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps"))
		   ((looking-at "[[:lower:]]") (put this-command 'state "all lower"))
		   ((looking-at "[[:upper:]]") (put this-command 'state "all caps"))
		   (t (put this-command 'state "all lower")))))
	  (cond
	   ((string= "all lower" (get this-command 'state))
		(upcase-initials-region p1 p2) (put this-command 'state "init caps"))
	   ((string= "init caps" (get this-command 'state))
		(upcase-region p1 p2) (put this-command 'state "all caps"))
	   ((string= "all caps" (get this-command 'state))
		(downcase-region p1 p2) (put this-command 'state "all lower"))))))
(bind-key* "C-x M-c" 'toggle-letter-case)
;; automatically convert the comma/dot once downcase/upcase next character
(defun endless/convert-punctuation (rg rp)
  "Look for regexp RG around point, and replace with RP.
Only applies to text-mode."
  (let ((f "\\(%s\\)\\(%s\\)")
		(space "?:[[:blank:]\n\r]*"))
	;; We obviously don't want to do this in prog-mode.
	(if (and (derived-mode-p 'text-mode)
			 (or (looking-at (format f space rg))
				 (looking-back (format f rg space))))
		(replace-match rp nil nil nil 1))))
(defun endless/capitalize ()
  "Capitalize region or word.
Also converts commas to full stops, and kills
extraneous space at beginning of line."
  (interactive)
  ;; convert from head of the word
  (unless (looking-back "\\s-")
	(backward-word))
  (endless/convert-punctuation "," ".")
  (if (use-region-p)
	  (call-interactively 'capitalize-region)
	;; A single space at the start of a line:
	(when (looking-at "^\\s-\\b")
	  ;; get rid of it!
	  (delete-char 1))
	;; (call-interactively 'subword-capitalize)
	(call-interactively 'capitalize-word))
  (unless (eolp) (forward-char 1)))
(defun endless/downcase ()
  "Downcase region or word.
Also converts full stops to commas."
  (interactive)
  ;; convert from head of the word
  (unless (looking-back "\\s-")
	(backward-word))
  (endless/convert-punctuation "\\." ",")
  (if (use-region-p)
	  (call-interactively 'downcase-region)
	;; (call-interactively 'subword-downcase)
	(call-interactively 'downcase-word))
  (unless (eolp) (forward-char 1)))
(defun endless/upcase ()
  "Upcase region or word."
  (interactive)
  ;; convert from head of the word
  (unless (looking-back "\\s-")
	(backward-word))
  (if (use-region-p)
	  (call-interactively 'upcase-region)
	;; (call-interactively 'subword-upcase)
	(call-interactively 'upcase-word))
  (unless (eolp) (forward-char 1)))
(bind-keys*
 ("M-c" . endless/capitalize)
 ("M-l" . endless/downcase)
 ("M-u" . endless/upcase))

;; use M-x list-processes then d to delete
(defalias 'lps 'list-processes)
(defun delete-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
	(cond ((and process
				(processp process))
		   (delete-process process)
		   (revert-buffer))
		  (t
		   (error "no process at point!")))))
(bind-key "d" 'delete-process-at-point process-menu-mode-map)

;; Removing duplicated lines
;; Note that the last line should contain the EOF
(defun delete-duplicated-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
	(save-restriction
	  (narrow-to-region beg end)
	  (goto-char (point-min))
	  (while (not (eobp))
		(kill-line 1)
		(yank)
		(let ((next-line (point)))
		  (while
			  (re-search-forward
			   (format "^%s" (regexp-quote (car kill-ring))) nil t)
			(replace-match "" nil nil))
		  (goto-char next-line))))))
(defalias 'ddl 'delete-duplicated-lines)

(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
	(save-excursion
	  (let ((text (if use-region        ;Get region if active, otherwise line
					  (buffer-substring (region-beginning) (region-end))
					(prog1 (thing-at-point 'line)
					  (end-of-line)
					  (if (< 0 (forward-line 1)) ;Go to beginning of next line,
										;or make a new one
						  (newline))))))
		(dotimes (i (abs (or n 1)))		;Insert N times, or once if not
										;specified
		  (insert text))))
	(if use-region nil		   ;Only if we're working with a line (not a region)
	  (let ((pos (- (point) (line-beginning-position)))) ;Save column
		(if (> 0 n) 					;Comment out original with negative arg
			(comment-region (line-beginning-position) (line-end-position)))
		(forward-line 1)
		(forward-char pos)))))
(bind-key* "C-c C-d" 'duplicate-line-or-region)

;; convert DOS to UNIX
(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'unix 't))

(defun cp ()
  "Copy the path of current buffer file to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "'%s' path copied!" filename))))

(defun insert-date-or-time (ARG)
  "Without prefix, print `2016-08-11'
With C-u, print `15:39:35'
With C--, print `2016-08-11 15:39:43'
With C-u C-u, print `Thu, 11. Aug 2016'"
  (interactive "P")
  (let ((format (cond
				 ((not ARG) "%Y-%m-%d")
				 ((equal ARG '-) "%Y-%m-%d %H:%M:%S")
				 ((equal ARG '(4)) "%H:%M:%S")
				 ((equal ARG '(16)) "%a, %d. %b %Y")))
		(system-time-locale "en_US"))
	(insert (format-time-string format))))

;; Display trailing whitespace at end of lines
(defun toggle-trailing-whitespace-display ()
  "Toggle the display of trailing whitespace, by changing the
buffer-local variable `show-trailing-whitespace'."
  (interactive)
  (save-excursion
	(if show-trailing-whitespace
		(setq show-trailing-whitespace nil)
	  (setq show-trailing-whitespace t))
	(force-window-update (current-buffer)))
  (message (concat "Display of EOL spaces "
				   (if show-trailing-whitespace
					   "enabled" "disabled"))))
(bind-key* "C-c e" 'show-ws-toggle-show-trailing-whitespace)
;; M-^ delete Up to Non-Whitespace Character, 'delete-indentation, combine two lines
;; M-Backspace delete to the previous word 'backword-kill-word
;; M-\ delete kill _all_ spaces at point 'delete-horizontal-space
(defun shrink-whitespaces ()
  "Remove whitespaces around cursor to just one or none.
If current line does have visible characters: shrink whitespace around cursor to just one space.
If current line does not have visible chars, then shrink all neighboring blank lines to just one.
Repeat the function will remove the remaining one space or blank line.
If current line is a single space, remove that space.
`shrink-whitespaces` combine `delete-blank-lines`, `just-one-space`, `fixup-whitespace`,
`delete-horizontal-space`, and `cycle-spacing`(in emacs 24.4) into one.
--URL http://ergoemacs.org/emacs/emacs_shrink_whitespace.html version 2015-11-04"
  (interactive)
  (let ((pos (point))
		line-has-char-p			   ; current line contains non-white space chars
		has-space-tab-neighbor-p
		whitespace-begin whitespace-end
		space-or-tab-begin space-or-tab-end)
	(save-excursion
	  (setq has-space-tab-neighbor-p (if (or (looking-at " \\|\t") (looking-back " \\|\t")) t nil))
	  (beginning-of-line)
	  (setq line-has-char-p (search-forward-regexp "[[:graph:]]" (line-end-position) t))
	  (goto-char pos)
	  (skip-chars-backward "\t ")
	  (setq space-or-tab-begin (point))
	  (skip-chars-backward "\t \n")
	  (setq whitespace-begin (point))
	  (goto-char pos)
	  (skip-chars-forward "\t ")
	  (setq space-or-tab-end (point))
	  (skip-chars-forward "\t \n")
	  (setq whitespace-end (point)))
	(if line-has-char-p
		(if has-space-tab-neighbor-p
			(let (deleted-text)
			  ;; remove all whitespaces in the range
			  (setq deleted-text
					(delete-and-extract-region space-or-tab-begin space-or-tab-end))
			  ;; insert a whitespace only if we have removed something different than a simple whitespace
			  (when (not (string= deleted-text " "))
				(insert " ")))
		  (progn
			(when (equal (char-before) 10) (delete-char -1))
			(when (equal (char-after) 10) (delete-char 1))))
	  (progn (delete-blank-lines)))))
(bind-key* "C-<backspace>" 'shrink-whitespaces)
;;;
;; delete not kill it into kill-ring
;; http://ergoemacs.org/emacs/emacs_kill-ring.html
(defun delete-word (ARG)
  "Delete(not kill) characters forward until encountering the end of the syntax-subword.
With argument, do this many times."
  (interactive "p")
  ;; eolpp is about the end-of-line, because if you are at the eol and doing
  ;; M-Backspace, if will combine the following line with the current
  (let (eolpp) (setq eolpp 1))
  (setq eolpp (if (eolp) 1 nil))
  (shrink-whitespaces)
  (delete-region (point) (progn (syntax-subword-forward-syntax ARG) (point)))
  (if eolpp (if (not (eolp)) (open-line 1))))
(defun delete-word-backward (ARG)
  "Delete(not kill) characters backward until encountering the beginning of the syntax-subword.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- ARG)))
(defun delete-line (ARG)
  "Delete text from current position to end of line char.
With argument, forward ARG lines."
  (interactive "p")
  (let (x1 x2)
	(setq x1 (point))
	(if (eolp) (forward-line ARG) (forward-line (- ARG 1)))
	(move-end-of-line 1)
	(setq x2 (point))
	(delete-region x1 x2))
  (when (bolp) (delete-char 1)))
(defun delete-line-backward (ARG)
  "Delete text between the beginning of the line to the cursor position.
With argument, backward ARG lines."
  (interactive "p")
  (let (x1 x2)
	(setq x1 (point))
	(if (bolp) (forward-line (- ARG)) (forward-line (- 1 ARG)))
	(move-beginning-of-line 1)
	(setq x2 (point))
	(delete-region x1 x2)))
(bind-keys*
 ("M-d" . delete-word)
 ("<M-backspace>" . delete-word-backward)
 ("C-k" . delete-line)
 ("C-S-k" . delete-line-backward))

(defun xah-fill-or-unfill ()
  "Reformat current paragraph or region to `fill-column', like `fill-paragraph' or “unfill”.
When there is a text selection, act on the the selection, else, act on a text block separated by blank lines.
URL `http://ergoemacs.org/emacs/modernization_fill-paragraph.html'
Version 2016-07-13"
  (interactive)
  ;; This command symbol has a property “'compact-p”, the possible values are t and nil. This property is used to easily determine whether to compact or uncompact, when this command is called again
  (let ( (-compact-p
          (if (eq last-command this-command)
              (get this-command 'compact-p)
            (> (- (line-end-position) (line-beginning-position)) fill-column)))
         (deactivate-mark nil)
         (-blanks-regex "\n[ \t]*\n")
         -p1 -p2
         )
    (if (use-region-p)
        (progn (setq -p1 (region-beginning))
               (setq -p2 (region-end)))
      (save-excursion
        (if (re-search-backward -blanks-regex nil "NOERROR")
            (progn (re-search-forward -blanks-regex)
                   (setq -p1 (point)))
          (setq -p1 (point)))
        (if (re-search-forward -blanks-regex nil "NOERROR")
            (progn (re-search-backward -blanks-regex)
                   (setq -p2 (point)))
          (setq -p2 (point)))))
    (if -compact-p
        (fill-region -p1 -p2)
      (let ((fill-column most-positive-fixnum ))
        (fill-region -p1 -p2)))
    (put this-command 'compact-p (not -compact-p))))
(global-set-key (kbd "M-q") 'xah-fill-or-unfill)

;; C-c e to 'show-ws-toggle-show-trailing-whitespace
(defun cleanup-buffer ()
  "Cleanup the buffer:
1. origami-open-all-nodes to avoid date loss
2. delete-trailing-whitespace
"
  (interactive)
  (origami-open-all-nodes) ;; avoid data loss
  (delete-trailing-whitespace))
(bind-key* "C-c d" 'cleanup-buffer)
(defvar all-make-modes
  '(makefile-makepp-mode makefile-bsdmake-mode makefile-imake-mode
						 makefile-automake-mode makefile-mode makefile-gmake-mode)
  "A list of the makefile major modes")
(defun indent-buffer-safe ()
  "Indent the whole buffer unless it is a Makefile,
Emacs by default won't treat the TAB as indent"
  (interactive)
  ;; indent the whole buffer but not Makefile because of must TAB
  (when (and (derived-mode-p 'prog-mode 'web-mode)
			 (not (member major-mode all-make-modes)))
	(indent-region (point-min) (point-max))))
(bind-key* "C-c C-w" 'indent-buffer-safe)
(add-hook 'before-save-hook
		  (lambda ()
			(cleanup-buffer)
			(indent-buffer-safe)))

;; indent marked files in dirs
;; C-u C-x d dir --> -lsR --> * / --> * t (then unmark the files no needed)
;; --> M-x indent-marked-files
;; C-M-\ 'indent-region(mark first)
(defun indent-marked-files ()
  (interactive)
  (dolist (file (dired-get-marked-files))
	(find-file file)
	(indent-region (point-min) (point-max))
	(save-buffer)
	(kill-buffer nil)))
;; C-x k to kill a buffer specified
(bind-key* "C-S-q" 'kill-this-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; minibuffer & buffers & dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; dired
;;
;; Rename files in a directory, the permission can also be changed
;; 1. C-x C-j 'dired-jump goto that dir
;; 2. C-x j 'wdired-change-to-wdired-mode, change it to editable mode, Start rename by editing
;; 3. C-c C-c 'wdired-finish-edit, Commit changes
;; 4. C-c ESC 'wdired-abort-changes, Abort changes
;; 5. you can use M-% 'query-replace or C-M-% 'query-replace-regexp
;; Actually, when you're in dired-mode, you can use C-x C-q
;; 'dired-toggle-read-only to make the dir editable/un-editable
;; same effect as wdired-change-to-wdired-mode, but the latter cannot disable the editable-mode
;; (even if you didn't change a thing)until you save your change or abort.
;; (global-set-key (kbd "C-x j") 'wdired-change-to-wdired-mode)
;; sort dirs first in dired-mode
(defun dired-sort-dirs-first ()
  "Dired sort hook to list directories first."
  (save-excursion
	(let (buffer-read-only)
	  (forward-line 2) ;; beyond dir. header
	  (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
	   (fboundp 'dired-insert-set-properties)
	   (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))
(add-hook 'dired-after-readin-hook 'dired-sort-dirs-first)
;; change the format of the files(dirs)
(setq dired-listing-switches "-Al --time-style long-iso")
;; in dired, hide hidden files by default, toggle them using `C-x M-o`
(require 'dired-x)
(defun dired-get-size ()
  "Get the size of a directory or a series of marked files and directories."
  (interactive)
  (let ((files (dired-get-marked-files)))
	(with-temp-buffer
	  (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
	  (message
	   "Size of all marked files: %s"
	   (progn
		 (re-search-backward "\\(^[0-9.,]+[A-Za-z]+\\).*total$")
		 (match-string 1))))))
(setq dired-omit-files "^\\...+$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))
;; map H from dired-do-hardlink to dired-omit-mode since it will not be used
(bind-keys :map dired-mode-map
		   ("H" . dired-omit-mode)
		   ("z" . dired-get-size))
;; dired+
;; stop Emacs dired mode from opening so many buffers
(require 'dired+)
(setq diredp-hide-details-initially-flag nil)
(toggle-diredp-find-file-reuse-dir 1)
;; sort in dired, `C-u s` then -S(sort by size), -u(sort by access time),
;; -c(sort by last modification time), -X(sort by file extension),
;; another, in dired `s`
;;
;; move cursor between minibuffer and buffers using F7
(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
	(select-window (active-minibuffer-window))))
(bind-keys*
 ("<f7>" . switch-to-minibuffer-window)
 ("C-c b" . ibuffer))
;; don't let the cursor go into minibuffer prompt, donnot know the actual effect
;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
(setq minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)))
(setq ibuffer-use-other-window t)
;; improve the profermance of the minibuffer
(setq echo-keystrokes 0.001)
;; use minibuffer recursively, don't know what does it mean
(setq enable-recursive-minibuffers t)

;;ignore asterisked buffers like *helm..* and *Messages*...
(defun prev-user-buffer ()
  "Switch to the previous user buffer(not started with “*”.)"
  (interactive)
  (previous-buffer)
  (let ((i 0))
	(while (and (string-equal "*" (substring (buffer-name) 0 1)) (< i 20))
	  (setq i (1+ i)) (previous-buffer))))
(defun next-user-buffer ()
  "Switch to the next user buffer(not started with “*”.)"
  (interactive)
  (next-buffer)
  (let ((i 0))
	(while (and (string-equal "*" (substring (buffer-name) 0 1)) (< i 20))
	  (setq i (1+ i)) (next-buffer))))
(bind-keys*
 ("<C-prior>" . prev-user-buffer)
 ("<C-next>" . next-user-buffer))
;; switch to last visited buffer
(defun last-visited-buffer ()
  "Switch to last visited buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(bind-key* "C-x x" 'last-visited-buffer)
(defun last-visited-window ()
  "Switch to last visited window.
Repeated invocations toggle between the two most recently open windows."
  (interactive)
  (let ((win (get-mru-window t t t)))
	(unless win (error "Last window not found!"))
	(let ((frame (window-frame win)))
	  (raise-frame frame)
	  (select-frame frame)
	  (select-window win))))
(bind-key* "C-x o" 'last-visited-window)

;; search-all-buffers-ignored-files, F9 to call this function
(defcustom search-all-buffers-ignored-files
  (list (rx-to-string '(and bos (or ".bash_history" "TAGS") eos)))
  "Files to ignore when searching buffers via \\[search-all-buffers]."
  :type 'editable-list)
;;(require 'grep)
(defun search-all-buffers (regexp prefix)
  "Searches file-visiting buffers for occurence of REGEXP.	With
prefix > 1 (i.e., if you type C-u \\[search-all-buffers]),
searches all buffers."
  (interactive (list (grep-read-regexp)
					 current-prefix-arg))
  (message "Regexp is %s; prefix is %s" regexp prefix)
  (multi-occur
   (if (member prefix '(4 (4)))
	   (buffer-list)
	 (remove-if
	  (lambda (b)
		(some (lambda (rx)
				(string-match rx (file-name-nondirectory
								  (buffer-file-name b))))
			  search-all-buffers-ignored-files))
	  (remove-if-not 'buffer-file-name (buffer-list))))
   regexp))
(bind-key* "<f9>" 'search-all-buffers)

;; lock/stick the buffer
(defun stick-buffer ()
  "Make the current window always display this buffer."
  (interactive)
  (let* ((window (get-buffer-window (current-buffer)))
		 (dedicated (window-dedicated-p window)))
	(if (not dedicated)
		(face-remap-add-relative 'mode-line-buffer-id '(:background "blue"))
	  (face-remap-add-relative 'mode-line-buffer-id '(:background "dim gray")))
	(set-window-dedicated-p window (not dedicated))))
(bind-key* "<f11>" 'stick-buffer)

;; Generate unique buffer names if you open many files with same basename
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
;; don't muck with special buffers
(setq uniquify-ignore-buffers-re "^\\*")
(setq uniquify-strip-common-suffix nil)

;; highlight buffer modifications
;; you can also(before saving):
;; 1. M-x diff-buffer-with-file
;; 2. After C-x C-c, type d to differ
;; If you are in vc dir, use C-x v = to diff the current version with the repo
(bind-keys*
 ("C-h C-b" . diff-buffer-with-file)
 ("C-h C-v" . highlight-changes-visible-mode)
 ("M-<f1>" . highlight-changes-previous-change)
 ("M-<f2>" . highlight-changes-next-change))
(global-highlight-changes-mode t)
;; initial invisible, use C-h C-v to toggle the highlight of changes
(setq highlight-changes-visibility-initial-state nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; line issues
;;;;;;;;;;;;;;;;;;;;;;;;;
;; what should be done when you ask Emacs to take you to the next
;; line and you already are located at the last line of the buffer
;; t means inserting a new line(t is the default option)
;; nil means ringing the bell
(setq next-line-add-newlines nil)
;; Always end a file with a newline
(setq require-final-newline nil)

(defun in-comment-p ()
  "Testy if cursor/point in a commented line? lispy--in-comment-p is not working in org-mode, so combine lispy--in-comment-p with org-at-comment-p"
  (save-excursion
	(if (derived-mode-p 'org-mode)
		(save-match-data (beginning-of-line) (looking-at "^[ \t]*#"))
	  (lispy--in-comment-p))))
(defun advanced-return (&optional ARG)
  "Customized return, more powerful.

Default(without prefix), create a line, jump into it and indent(like C-e C-m)
With prefix argument(C-u), it will create a new line, jump into it but no indent(like C-e C-o C-n).
With negative prefix argument(C--), it will create a new line above the current
line and jump into it(like C-a C-o)

In comments, RET will automatically use C-M-j instead.
In other non-comment situations, try C-M-j to split."
  (interactive "P")
  (if (equal ARG '-)
	  (progn
		(beginning-of-line)
		(open-line 1))
	(if (equal ARG '(4))
		(progn
		  (end-of-line)
		  (open-line 1)
		  (forward-line))
	  (progn
		(end-of-line)
		(newline-and-indent)))))
(defun Meta-return ()
  (interactive)
  (progn
	;; executing key in a function
	(call-interactively (key-binding (kbd "C-M-j")))
	(indent-according-to-mode)))
(bind-key "M-RET" 'Meta-return)
;; donnot use bind-key*, it will affect the Enter in minibuffer
(bind-key "RET" 'advanced-return)

;; comment in C code,`M-;` means /* */, use // in C++ code
(add-hook 'c++-mode-hook
		  (lambda ()
			(setq comment-start "//" comment-end "")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Default configuration change
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; to cause the *compilation* buffer to automatically scroll to the end of new output
(setq compilation-scroll-output t)
;; overwrite selected region when typing, yanking
(delete-selection-mode t)
;; When C-x n n/s to narrwow the marked region, don't ask whether for future
;; session or not C-x n w to go back to normal
(put 'narrow-to-region 'disabled nil)
;; disable Insert key for plugged keyboard
(unbind-key "<insert>" global-map)
;; disable C-z(suspend-frame) , and you can use C-z for others
(unbind-key "C-z" global-map)
;; color
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;
;; http://ergoemacs.org/emacs/emacs_shell_vs_term_vs_ansi-term_vs_eshell.html
(bind-key* "C-x s" 'shell)
;; shell will prompt if you try to kill the buffer, but eshell will not.  eshell
;; will not use the .bashrc/.fishrc, but shell will makes shell command always
;; start a new shell, use C-u M-x eshell to create a new eshell,
(defadvice shell (around always-new-shell)
  "Always start a new shell."
  (let ((buffer
		 (generate-new-buffer-name "*shell*")))
	ad-do-it))
;; make shell in emacs load .bashrc/.fishrc
;; (setq shell-command-switch "-lc")
;; (ad-activate 'shell)

;; copy/paste between system/Emacs
;; 1. after copy Ctrl+c in Linux X11, you can C-y in emacs
(setq x-select-enable-clipboard t)
;; 2. after mouse selection in X11, you can C-y in emacs primary selection.
;; When you select a text using mouse, the text is automatically put into
;; the primary selection, and middle click will paste it.
;; (setq x-select-enable-primary t)

;; yes/no --> y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; when you edit a file, use C-x C-j to go to the dir which the current file lies
(bind-key* "C-x C-j" 'dired-jump)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; Window
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; resize the opened windows
(bind-keys*
 ("S-C-<left>" . shrink-window-horizontally)
 ("S-C-<right>" . enlarge-window-horizontally)
 ("S-C-<down>" . shrink-window)
 ("S-C-<up>" . enlarge-window))
;; winner-mode, max a window temporarily and restore the state
;; C-c <left/right> 'winner-undo/redo
;; you can C-x 1 to close other windows and C-c <left> to restore
;; (winner-mode 1)
;; use the following functions is better
(defun toggle-maximize-buffer ()
  "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
	  (jump-to-register '_)
	(progn
	  (window-configuration-to-register '_)
	  (delete-other-windows))))
(defun toggle-maximize-other-buffer ()
  "Maximize other buffer"
  (interactive)
  (if (= 1 (length (window-list)))
	  (jump-to-register '_)
	(progn
	  (window-configuration-to-register '_)
	  (delete-window))))
(bind-keys*
 ("C-x z" . toggle-maximize-buffer)
 ("C-x C-z" . toggle-maximize-other-buffer))

;; register copy/paste
;; C-x r SPC/j save/jump position
;; C-x r s/x/g/i save/insert register
;; a lot of other register commands
(defun register-1-copy ()
  "Copy current line or text selection to register 1.
See also: `register-1-paste', `copy-to-register'.
URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
Version 2015-12-08"
  (interactive)
  (let (-p1 -p2)
    (if (region-active-p)
        (progn (setq -p1 (region-beginning))
               (setq -p2 (region-end)))
      (progn (setq -p1 (line-beginning-position))
             (setq -p2 (line-end-position))))
    (copy-to-register ?1 -p1 -p2)
    (message "copied to register 1: 「%s」." (buffer-substring-no-properties -p1 -p2))))
(defun register-1-paste ()
  "Paste text from register 1.
See also: `register-1-copy', `insert-register'.
URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
Version 2015-12-08"
  (interactive)
  (when (use-region-p)
    (delete-region (region-beginning) (region-end)))
  (insert-register ?1 t))
(bind-keys*
 ("C-x r !" . register-1-copy)
 ("C-x r 1" . register-1-paste))

;; Try C-x 4 C-h for C-x 4 info
(defun vsplit-last-buffer ()
  "Split the window vertically and display the previous buffer."
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))
(defun hsplit-last-buffer ()
  "Split the window horizontally and display the previous buffer."
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))
(bind-keys*
 ("C-x 2" . vsplit-last-buffer)
 ("C-x 3" . hsplit-last-buffer))
;;
;; split new window direction by default
;; (setq split-width-threshold 90)

;; reuse frames
(setq-default display-buffer-reuse-frames t)
;; toggle two windows between vertically and horizontally
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
	  (let* ((this-win-buffer (window-buffer))
			 (next-win-buffer (window-buffer (next-window)))
			 (this-win-edges (window-edges (selected-window)))
			 (next-win-edges (window-edges (next-window)))
			 (this-win-2nd
			  (not (and (<= (car this-win-edges)
							(car next-win-edges))
						(<= (cadr this-win-edges)
							(cadr next-win-edges)))))
			 (splitter
			  (if (= (car this-win-edges)
					 (car (window-edges (next-window))))
				  'split-window-horizontally
				'split-window-vertically)))
		(delete-other-windows)
		(let ((first-win (selected-window)))
		  (funcall splitter)
		  (if this-win-2nd (other-window 1))
		  (set-window-buffer (selected-window) this-win-buffer)
		  (set-window-buffer (next-window) next-win-buffer)
		  (select-window first-win)
		  (if this-win-2nd (other-window 1))))))
;; C-x 4 t 'toggle-window-split
(bind-key "t" 'toggle-window-split ctl-x-4-map)

;; ediff split horizontal, default is vertically
(eval-after-load "ediff"
  '(progn
	 (setq ediff-split-window-function
		   'split-window-horizontally) ;; use | to change the style
	 (setq ediff-window-setup-function
		   'ediff-setup-windows-plain)
	 ;; delete these buffers (if they are not modified) after q
	 (setq ediff-keep-variants nil)))

;; You can use C-x o 'other-window, but the following is better
;; move your point to another window in the specific direction
(bind-keys*
 ("C-x <left>" . windmove-left)
 ("C-x <right>" . windmove-right)
 ("C-x <up>" . windmove-up)
 ("C-x <down>" . windmove-down))

;;
;; revert buffer without confirmation
(global-auto-revert-mode 1)
(defun rev()
  (interactive)
  (revert-buffer nil t))
(bind-key* "C-c r" 'rev)
(defalias 'rtf 'recover-this-file)
;;
;; reopen killed buffer
(defvar killed-buffers-list nil
  "List of recently killed buffers.")
(defun add-file-to-killed-buffers-list ()
  "If buffer is associated with a file name, add that file to the
`killed-buffers-list' when killing the buffer."
  (when buffer-file-name
	(push buffer-file-name killed-buffers-list)))
(add-hook 'kill-buffer-hook #'add-file-to-killed-buffers-list)
(defun reopen-killed-buffer-fancy ()
  "Pick a file to revisit from a list of files killed during this
Emacs session."
  (interactive)
  (if killed-buffers-list
	  (let ((file
			 (completing-read "Reopen killed file: " killed-buffers-list
							  nil nil nil nil (car killed-buffers-list))))
		(when file
		  (setq killed-buffers-list
				(cl-delete file killed-buffers-list :test #'equal))
		  (find-file file)))
	(error "No recently-killed files to reopen")))
(bind-key* "C-S-t" 'reopen-killed-buffer-fancy)

;; set M-x align to C-c a, or use align-regexp
(bind-key "C-c a" 'align)

;; put cursor at the #include line, C-c o open the header file
;; c-mode-common-hook equals to c-mode-hook + c++-mode-hook
(add-hook 'c-mode-common-hook
		  (lambda()
			(local-set-key	(kbd "C-c o") 'ff-find-other-file)))

;; Saveplace & desktop
(if (version< emacs-version "25.0")
    (progn
      (require 'saveplace)
      (setq-default save-place t))
  (save-place-mode 1))
;;
(setq desktop-save 'ask)
;;desktop-save ask means always ask
(desktop-save-mode nil)

;; show the possible errors in C/C++ source codes(cwarn mode)
(global-cwarn-mode 1)

;; spell check
(require 'ispell)
(defalias 'ib 'ispell-buffer)
;; spell check
(require 'ispell)
(defalias 'ib 'ispell-buffer)
;; spell check engine
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))
(add-hook 'org-mode-hook 'flyspell-mode)
;; C-. or C-M-i 'flyspell-auto-correct-word
;; if you don't know how to spell the rest of a word
(bind-keys*
 ("C-?" . ispell-complete-word)
 ;; check comments and string constants already in the file
 ("<f6>" . ispell-comments-and-strings))
;; check in the comments and string constants as you type
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; click the left button to show the correct words list
(eval-after-load "flyspell"
  '(define-key flyspell-mouse-map [mouse-1] #'flyspell-correct-word)
  ;;(define-key flyspell-mouse-map [mouse-3] #'undefined)
  )
;; or use the M-f8 to check from the beginning and correct
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))
(bind-key* "M-<f8>" 'flyspell-check-next-highlighted-word)
;;
(add-hook 'ispell-initialize-spellchecker-hook
		  (lambda ()
			(setq ispell-base-dicts-override-alist
				  '((nil ; default
					 "[A-Za-z]" "[^A-Za-z]" "[']" t
					 ("-d" "en_US" "-i" "utf-8") nil utf-8)
					("american" ; Yankee English
					 "[A-Za-z]" "[^A-Za-z]" "[']" t
					 ("-d" "en_US" "-i" "utf-8") nil utf-8)
					("british" ; British English
					 "[A-Za-z]" "[^A-Za-z]" "[']" t
					 ("-d" "en_GB" "-i" "utf-8") nil utf-8)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; Tab & indent
;;;;;;;;;;; '(global-)whitespace-mode to show tab/space
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(bind-key* (kbd "C-c w") 'whitespace-mode)

;; nil-->use spaces instead of tabs, t -- don't replace
(require 'cc-vars)
(setq-default indent-tabs-mode t)
(setq-default tab-always-indent 'complete)
;; sometimes tab-width (4) will make the char's position different from turning on whitespace-mode
;; (setq-default tab-width 4)
;; for C++
(setq c-basic-offset 4)
;; (setq indent-line-function 'insert-tab)
(add-hook 'text-mode-hook
		  (lambda ()
			(setq indent-tabs-mode t)
			;; this will cause the position problem in org-mode
			;; (setq tab-width 4)
			))
(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(setq tab-width 4)))
(add-hook 'python-mode-hook
		  (lambda ()
			(setq indent-tabs-mode nil)
			(setq tab-width 4)))
;;
(add-hook 'c-mode-hook
		  (lambda ()
			(c-set-style "linux")
			(setq tab-width 8)
			(setq indent-tabs-mode t) ;;default in linux kernel
			(setq c-basic-offset 8)
			;; make comment aligned with the code block/line
			(c-set-offset 'comment-intro 0)))
(add-hook 'c++-mode-hook
		  (lambda ()
			(c-set-style "linux")
			(setq tab-width 4)
			(setq indent-tabs-mode t) ;;default in linux kernel
			(setq c-basic-offset 4)
			(c-set-offset 'comment-intro 0)))
(add-hook 'makefile-mode-hook
		  (lambda ()
			(setq tab-width 8)))

;; ;;;;;;;Documentation/CodingStyle
;; ;;Using spaces for alignment, but tabs for indentation
;; (defun c-lineup-arglist-tabs-only (ignored)
;;	 "Line up argument lists by tabs, not spaces"
;;	 (let* ((anchor (c-langelem-pos c-syntactic-element))
;;			(column (c-langelem-2nd-pos c-syntactic-element))
;;			(offset (- (1+ column) anchor))
;;			(steps (floor offset c-basic-offset)))
;;	   (* (max steps 1)
;;		  c-basic-offset)))
;; (add-hook 'c-mode-common-hook
;;			 (lambda ()
;;			   ;; Add kernel style
;;			   (c-add-style
;;				"linux-tabs-only"
;;				'("linux" (c-offsets-alist
;;						   (arglist-cont-nonempty
;;							c-lineup-gcc-asm-reg
;;							c-lineup-arglist-tabs-only))))))
;; (add-hook 'c-mode-hook
;;			 (lambda ()
;;			   (let ((filename (buffer-file-name)))
;;				 (setq indent-tabs-mode t)
;;				 (c-set-style "linux-tabs-only"))))
;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; Parentheses
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; show the double parenthesis/expression
(show-paren-mode t)
(setq show-paren-style 'expression)
(defadvice show-paren-function
	(after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the echo area.
Has no effect if the character before point is not of the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
		 (matching-text (and cb
							 (char-equal (char-syntax cb) ?\) )
							 (blink-matching-open))))
	(when matching-text (message matching-text))))

;; show the open parentheses when typing the closing one
(setq blink-matching-paren t)

;; use cperl-mode as default mode for Perl code instead of perl-mode
;; cperl-mode offers much more features than perl-mode.
;; http://ergoemacs.org/emacs/emacs_perl_vs_cperl_mode.html
(setq auto-mode-alist (rassq-delete-all 'perl-mode auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.\\(p\\([lm]\\)\\)\\'" . cperl-mode))
(setq interpreter-mode-alist (rassq-delete-all 'perl-mode interpreter-mode-alist))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
(eval-after-load "cperl-mode"
  '(bind-key "C-{" 'insert-c-block-parentheses-without-indent cperl-mode-map))

;; gdb, Debugging with GDB Many Windows layout
;; https://tuhdo.github.io/c-ide.html
;; Use M-x gdb-display-* to show more functions
;; M-x tool-bar-mode to show the tools
;; M-x gdb --> gdb -i=mi bin-file
(require 'init-gdb)
(eval-after-load "init-gdb"
  '(progn
	 ;; use gdb-many-windows by default
	 (setq gdb-many-windows t)
	 ;; Non-nil means display source file containing the main routine at startup
	 (setq gdb-show-main t)
	 ))
(defun va ()
  "valgrind in Emacs, execute it in shell-mode after `va ./binary`
- Put your corsor in the error line, type enter or use your mouse to jump into the line.
- In shell, use M-n/p 'compilation-next/previous-error, use RET 'compile-goto-error
- The 'complation' after 'Shell:run' in mode-line indicates the va is activated"
  (interactive)
  (if compilation-minor-mode
	  (setq compilation-minor-mode nil)
	(compilation-minor-mode)))
(bind-key  "C-c v" 'va prog-mode-map)
(defvar all-gud-modes
  '(gud-mode comint-mode gdb-locals-mode gdb-frames-mode gdb-breakpoints-mode)
  "A list of modes when using gdb")
(defun kill-all-gud-buffers ()
  "Kill all gud buffers including Debugger, Locals, Frames, Breakpoints.
Do this after `q` in Debugger buffer."
  (interactive)
  (save-excursion
	(let ((count 0))
	  (dolist (buffer (buffer-list))
		(set-buffer buffer)
		(when (member major-mode all-gud-modes)
		  (setq count (1+ count))
		  (kill-buffer buffer)
		  (delete-other-windows))) ;; fix the remaining two windows issue
	  (message "Killed %i buffer(s)." count))))
(defalias 'kg 'kill-all-gud-buffers)

;; cedet -- built-in
;; more detail: http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
;; and: http://www.logilab.org/blogentry/173886
;; the following add-to-list should be put before (semantic-mode 1)
(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;; stickyfunc-enhance package
(require 'stickyfunc-enhance)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;;
(setq semantic-load-turn-useful-things-on t)
;; Semantic's customization
(semantic-mode 1)
;; enable global support for Semanticdb
;; the semanticdb should be in cedet packages
;; (require 'semanticdb)
(global-semanticdb-minor-mode t)
;; with semanticdb, you can use databased made by global, ctags, ebrowser, cscope
;; global for example
;; (require 'semanticdb-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
;;
;; enables automatic bookmarking of tags that you edited,
;; so you can return to them later with 'semantic-mrub-switch-tags
(global-semantic-mru-bookmark-mode t)
;; activates automatic parsing of source code in the idle time;
(global-semantic-idle-scheduler-mode t)
;; Show the function point is currently in(like which-function-mode) at the
;; first line of the current buffer, more details than which-function, but not
;; instantly sometimes:
;; (global-semantic-stickyfunc-mode t)
;; activates displaying of possible name completions in the idle time.	Requires
;; that global-semantic-idle-scheduler-mode was enabled;
(global-semantic-idle-completions-mode t)
;; activates displaying of information about current tag in the idle time.
;; Requires that global-semantic-idle-scheduler-mode was enabled.
(global-semantic-idle-summary-mode t)
;; To enable more advanced functionality for name completion, etc.,
;; The next three lines should be put after (semantic-mode 1)
(require 'semantic/ia)
;; System header files, if error on this following line,
;; install gcc-c++
(require 'semantic/bovine/c)
(require 'semantic/bovine/gcc)
;;
(defun my-include-semantic-hook ()
  (semantic-add-system-include "/usr/include/" 'c-mode)
  (semantic-add-system-include "/usr/include/" 'c++-mode))
(add-hook 'semantic-init-hooks 'my-include-semantic-hook)
(setq-mode-local c-mode semanticdb-find-default-throttle
				 '(project unloaded system recursive))
;; Semantic's work optimization, optimize work with tags
;; Integration with imenu
(defun my-semantic-hook ()
  (imenu-add-to-menubar "GTAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)
;; Enables project mode on all files.
(global-ede-mode t)
;; Starting for inline completion when "." is pressed
(bind-key "." 'semantic-complete-self-insert prog-mode-map)
;;
(add-hook 'org-mode-hook
		  (lambda() (set
					 (make-local-variable 'semantic-mode) nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages from  elpa, marmelade and melpa.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
;; Package repositories
(setq package-archives
	  '(
		("gnu" . "http://elpa.gnu.org/packages/")
		("melpa" . "https://melpa.org/packages/")
		("melpa-stable" . "https://stable.melpa.org/packages/")
		("marmalade" . "https://marmalade-repo.org/packages/")
		("ELPA" . "http://tromey.com/elpa/")
		))
(defalias 'pi 'package-install)
(defalias 'pmm 'package-menu-mode)
(defun package--save-selected-packages (&rest opt) nil)
;; (defalias 'plp 'package-list-packages)
;;
;; spinner required by paradox
(defalias 'plp 'paradox-list-packages)
(setq paradox-github-token t)
(setq paradox-execute-asynchronously t)
;; Update the packages automatically
;;(when (not package-archive-contents) (package-refresh-contents))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; plugin installed by M-x package-install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; dropdown-list required by yasnippet (optional)
;; yasnippet
;; C-c & C-v('yas-visit-snippet-file) to edit a snippet in current mode
;; C-c & C-n('yas-new-snippet) to create a new one for current mode
;; C-c C-c('yas-load-snippet-buffer) to reload it
(require 'yasnippet)
(require 'dropdown-list)
(setq yas-prompt-functions '(yas-dropdown-prompt
							 yas-ido-prompt
							 yas-completing-prompt
							 yas-x-prompt
							 yas-no-prompt))
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)
;; stop yasnippet auto-indent
;; (setq yas/indent-line nil)
(bind-key "C-c y" 'yas-reload-all)

;; ecb, use M-x ecb-minor-mode, or Tools->Start Code Browser you'll be suprised
;; If you want to load the ECB first after starting it by ecb-activate
;; (Advantage: Fast loading. Disadvantage: ECB- and semantic-options first
;; available after starting ECB):
(autoload 'ecb-autoloads "ecb-autoloads" t)
(defalias 'emm 'ecb-minor-mode)
;; If you want to load the complete ECB at (X)Emacs-loadtime
;; (Advantage: All ECB-options available after loading ECB. Disadvantage: Increasing loadtime):
;; (require 'ecb)

;; hippie-expand-etx
(autoload 'hippie-exp-ext "hippie-exp-ext" t)
(bind-keys*
 ("C-@" . hippie-expand-dabbrev-limited-chars)
 ;; (global-set-key (kbd "M-/") 'hippie-expand-file-name) ;; from hippie-exp-ext
 ("M-/" . hippie-expand))
(defun try-expand-by-dict (old)
  ;; old is true if we have already attempted an expansion
  (unless (bound-and-true-p ispell-minor-mode)
	(ispell-minor-mode 1))
  (let ((lookup-func
		 (if (fboundp 'ispell-lookup-words)
			 'ispell-lookup-words
		   'lookup-words)))
	(unless old
	  (he-init-string (he-lisp-symbol-beg) (point))
	  (if (not (he-string-member he-search-string he-tried-table))
		  (setq he-tried-table (cons he-search-string he-tried-table)))
	  (setq he-expand-list
			(and (not (equal he-search-string ""))
				 (funcall lookup-func
						  (concat (buffer-substring-no-properties
								   (he-lisp-symbol-beg) (point)) "*")))))
	(if (null he-expand-list)
		(if old (he-reset-string))
	  (he-substitute-string (car he-expand-list))
	  (setq he-expand-list (cdr he-expand-list)) t)))
;; the built-in hippie-exp config
(setq hippie-expand-try-functions-list
      '(
		;; from yasnippet
		yas-hippie-try-expand
		;;
		try-expand-dabbrev
		try-expand-dabbrev-visible
		try-expand-dabbrev-all-buffers
		try-expand-dabbrev-from-kill
		try-complete-file-name-partially
		try-complete-file-name
		try-expand-all-abbrevs
		try-expand-list
		try-expand-line
		try-complete-lisp-symbol-partially
		try-complete-lisp-symbol
		try-expand-by-dict))

;; multiple-cursors
;; How to add string at the beginning of multiple lines
;; 1. mark M-x replace-regexp ^ RET string RET
;; 2. mark C-x r t string
;; watch the emacs-rocks-13-multiple-cursors.mov video
(autoload 'multiple-cursors "multiple-cursors" t)
;; When you have an active region that spans multiple lines, the following will
;; add a cursor to each line
(bind-key* "C-S-c C-S-c" 'mc/edit-lines)
;; When you want to add multiple cursors not based on continuous lines, but
;; based on keywords in the buffer, first mark the word, then add more cursors:
(bind-keys*
 ("C->" . mc/mark-next-like-this)
 ("C-<" . mc/mark-previous-like-this)
 ("C-c C-<" . mc/mark-all-like-this))

;; ace-jump-mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode" t)
;; insensitive-->t
(setq ace-jump-mode-case-fold nil)
;; enable a more powerful jump back function from ace jump mode
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
;; Use C-x SPC or C-u C-SPC to jump back
(bind-keys*
 ("C-c SPC" . ace-jump-mode-pop-mark)
 ("C-c j" . ace-jump-mode)
 ("C-c J" . ace-jump-char-mode)
 ("C-c l" . ace-jump-line-mode))

;;
;; dash required by ace-jump-buffer
(autoload 'dash "dash" t)
;; ace-jump-buffer, requires dash and ace-jump-mode
(autoload 'ace-jump-buffer "ace-jump-buffer" t)
;; C-x C-b default to 'list-buffers
(unbind-key "C-x C-b" global-map)
(bind-key* "C-x C-b" 'ace-jump-buffer)

;; sml-mode requird by expand-region
(autoload 'sml-mode "sml-mode" t)
;;
;; expand-region
(autoload 'expand-region "expand-region" t)
(bind-key* "C-S-SPC" 'er/expand-region)
;; mark word->sentence->paragraph->buffer
(defun er/add-text-mode-expansions ()
  (make-variable-buffer-local 'er/try-expand-list)
  (setq er/try-expand-list (append
							er/try-expand-list
							'(
							  er/mark-sentence
							  mark-paragraph
							  mark-page))))
(dolist (hook '(org-mode-hook markdown-mode-hook))
  (add-hook hook 'er/add-text-mode-expansions))

;; change-inner -- require expand-region
;; `change-inner "` would kill the contents of the string
;; `change-outer "` would kill the entire string(including ")
;; `change-inner {` would kill the content inside of {}
;; `change-outer {` would kill the entire block（including {）
;; Giving these commands a prefix argument `C-u` means copy instead of kill.
(bind-keys*
 ("M-i" . change-inner)
 ("M-o" . change-outer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;	 company-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'company "company" t)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-global-modes t)
(setq company-tooltip-limit 20)
(setq company-minimum-prefix-length 3)
(setq company-show-numbers t)
(setq company-transformers '(company-sort-by-occurrence))
(setq company-selection-wrap-around t)
(setq company-tooltip-align-annotations t)
(setq company-dabbrev-downcase nil)
(setq company-dabbrev-other-buffers t)
;; donnot change this, company issues #584
(setq company-dabbrev-ignore-case t)
;; default company-backends for all modes
(setq company-backends
	  '(
		(
		 company-files
		 company-dabbrev
		 company-keywords
		 company-capf
		 company-yasnippet
		 company-semantic
		 company-ispell
		 )
		(company-dabbrev company-dabbrev-code company-abbrev)
		))
;; turn on this, space will insert the candidate not space
;; (setq company-auto-complete t)
;; use F1 or C-h in the drop list to show the doc, Use C-s/C-M-s to search the candidates,
;; M-NUM to select specific one, C-w to view its source file
(global-set-key (kbd "C-c <tab>") 'company-files)
;; this will show a lot of garbage, use it only necessary
;; (add-to-list 'company-backends 'company-ispell)
(defalias 'ci 'company-ispell)
;; TAB to complete keywords in org-mode
(defun my-org-mode-hook ()
  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
(add-hook 'org-mode-hook #'my-org-mode-hook)
(add-hook 'c-mode-common-hook
		  (lambda ()
			(set (make-local-variable 'company-backends)
				 (list
				  (cons
				   '((
					  company-c-headers
					  company-clang
					  company-gtags))
				   (car company-backends))))))
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (list
                  (cons 'company-elisp
                        (car company-backends))))))
(add-hook 'python-mode-hook
		  (lambda ()
			(set (make-local-variable 'company-backends)
				 (list
				  (cons
				   'company-ropemacs
				   (car company-backends))))))
;; grouped default back-ends for all major mode
;; (with-eval-after-load 'company
;;   (add-hook 'company-mode-hook
;; 			(lambda ()
;; 			  (add-to-list 'company-backends
;; 						   '(
;; 							 company-dabbrev-code
;; 							 company-semantic
;; 							 company-capf
;; 							 ;; company-dabbrev
;; 							 company-keywords
;; 							 company-clang
;; 							 company-elisp
;; 							 company-files
;; 							 company-gtags
;; 							 company-etags
;; 							 company-c-headers
;; 							 company-yasnippet
;; 							 company-bbdb
;; 							 ;; company-nxml
;; 							 ;; company-css
;; 							 ;; company-eclim
;; 							 ;; company-xcode
;; 							 ;; company-ropemacs
;; 							 ;; company-cmake
;; 							 ;; company-oddmuse
;; 							 )))))

;; undo-tree
;; C-x u -> undo-tree-visualize
;; more infomation please check the doc
;; replace the standard undo system
(global-undo-tree-mode)
(unbind-key "C-_" global-map)
(unbind-key "M-_" global-map)
(bind-keys*
 ("C-z" . undo-tree-undo)
 ("C-S-z" . undo-tree-redo)
 ("C-x u" . undo-tree-visualize))

;; findr
(autoload 'findr-search "findr" "Find text in files." t)
(autoload 'findr-query-replace "findr" "Replace text in files." t)
(bind-keys*
 ("C-M-S-s" . findr)
 ("C-M-s" . findr-search)
 ("C-M-r" . findr-query-replace))

;; iy-go-to-char better work with multiple-cursors
(autoload 'iy-go-to-char "iy-go-to-char" t)
(bind-keys*
 ("C-c f" . iy-go-to-char)
 ("C-c F" . iy-go-to-char-backward))
;; (global-set-key (kbd "C-c ;") 'iy-go-to-or-up-to-continue)
;; (global-set-key (kbd "C-c ,") 'iy-go-to-or-up-to-continue-backward)
;;
;; To make `iy-go-to-char' works better with `multiple-cursors`, add
;; `iy-go-to-char-start-pos' to `mc/cursor-specific-vars' when mc is loaded:
;; The following one line should be put after multiple-cursors plugin
;; (add-to-list 'mc/cursor-specific-vars 'iy-go-to-char-start-pos)
;; markdown-mode, http://jblevins.org/projects/markdown-mode/

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
;; markdown-mode+
(autoload 'markdown-mode+ "markdown-mode+" t)

;; xcscope -- requird by ascope

;; ascope
;; Usage: in Emacs, use M-x cscope-index-files or in terminal, `cscope-index -r -v` to cr
;; Almost all the features are provided by xcscope(cscope-* commands), ascope is
;; extension to xcscope, it allow cscope to keep the history of jumping in one
;; *cscope* buffer and M-n/p commands
;; In *cscope* buffer:
;; M-n/p to navigate between the found files,
;; n/p 'ascope-next/prev-symbol between the results(sometimes multiple positions
;; in one file)
;; " "(blank) 'ascope-show-entry-other-window, show the result in other buffer
;; but keep point
;; RET 'ascope-select-entry-other-window-delete-window, but jump into result
;; C-c s u 'cscope-pop-mark to go back
(add-hook 'c-mode-common-hook
		  (lambda ()
			;; defined in xcscope
			(cscope-minor-mode)))
(defadvice cscope-bury-buffer (after cscope-bury-buffer activate)
  "Kill the *cscope* window after hitting q or Q instead of leaving it open."
  (delete-window))

;; ggtags
;; ggtags supports jump/navigation
;; cedet supports highlighting, project, smart jump, context-sensitive
;; completion, symbol references, code generation...
;; ggtags: https://github.com/leoliu/ggtags
;; C-x d to the source dir, M-x ggtags-create-tags --> dir --> ctags(no)
;; or just M-x ggtags-create-tags(ggtags-update-tags to update an existed tag)
;; will create tags for source code or reference the ~/Recentchange/emacs
;; M-n/p, M-* to go back, RET to exit ggtags status
;; C-c M-h 'ggtags-view-tag-history, stores the places in files you visited
;; C-c M-/ 'ggtags-view-search-history, stores the tag operations you performed
(add-hook 'c-mode-common-hook
		  (lambda ()
			(when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
			  (ggtags-mode 1))))
;; hide project(containing GTAGS.. files) name
(setq ggtags-mode-line-project-name nil)

;; org-mode
(autoload 'package "package" t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; both org and org-plus-contrib are needed for full org-mode
;; org, http://orgmode.org/worg/org-faq.html
;;
;; C-c @ or M-h to mark, C-c @ is for elements, M-h is for paragraphs
;;
;; The following two set-key has the side affect that
;; you can not use the semantic-mode prefix
;; and ede-minor-mode prefix in C/C++ mode
;; or you can use C-c , to set the TODO priority
;; (define-key semantic-mode-map "\C-c," 'org-priority)
;; or you have to M-x org-mode to use (C-u)C-c . org-time-stamp
(bind-key "\C-c." 'org-time-stamp ede-minor-mode-map)
;;
;; the next line is needed before load org-mode
;; Non-nil means single character alphabetical bullets are allowed.
;; or the shortkeys like M-q won't work in org-mode
(setq org-list-allow-alphabetical t)
;; To make sure all your variables work you should not use (require 'org).
;; Instead use the following setting
;; You should also make sure that you do not require any other org-...
;; files in your .emacs file before you have set your org variables,
;; since these will also cause org.el to be loaded.
;; To be safe, load org files after you have set your variables.
(require 'org-install)
;;(require 'org-habit)
(require 'ob-tangle)
(require 'org)
(setq org-completion-use-ido t)
(bind-keys :map org-mode-map
		   ("C-c a" . org-agenda)
		   ("C-c c" . org-capture)
		   ("<C-return>" . org-insert-heading-after-current)
		   ("RET" . advanced-return)
		   ;; show/unshow the descriptive and literal links
		   ("C-c C-x l" . org-toggle-link-display))
;; If you would like to embed a TODO within text without treating it as
;; an outline heading, you can use inline tasks. Simply add:
(require 'org-inlinetask)
;; org agenda seems very slow
;; Here are some other ideas for speeding up the agenda: :
;; 1. Use a one day agenda view (rather than a seven day view).
(setq org-agenda-span 1)
;; 2. Archive inactive items to separate files.
;; C-c C-x C-s (org-archive-subtree)
;; 3. Do not include the global todo list in your agenda view.
;; 4. Make sure that your org files are byte-compiled.
;; replace auto-mode-alist for multiple extensions
(mapc
 (lambda (file)
   (add-to-list 'auto-mode-alist
				(cons (concat (regexp-quote file) "\\'") 'org-mode)))
 '("README" ".txt"))
;; TODO
;; different sequential states in the process of working on an item
;; C-c C-t SPC for nothing
;; (setq org-todo-keywords
;; 	  '((sequence "TODO(t)" "READ(r)" "|" "DONE(d)")
;; 		;; multiple sets for one file
;; 		;; (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)""|" "FIXED(f)")
;; 		;; (sequence "|" "CANCELED(c)")
;; 		))
;; Keep track of when a certain TODO item was finished.
;; (setq org-log-done 'time)
;; record a note along with the timestamp
(setq org-log-done 'note)
;; ;; If you would like a TODO entry to automatically change to DONE
;; ;; when all children are done, you can use the following setup:
;; (defun org-summary-todo (n-done n-not-done)
;;	 "Switch entry to DONE when all subentries are done, to TODO otherwise."
;;	 (let (org-log-done org-log-states)	  ; turn off logging
;;	   (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
;; (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
;; tags, shortcut
;; (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))
;; Clocking working time, to save the clock history across Emacs sessions
;; (setq org-clock-persist 'history)
;; (org-clock-persistence-insinuate)
;; If you would like a TODO entry to automatically
;; change to DONE when all children are done:
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)	; turn off logging
	(org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
(setq org-tags-column 0)
;; syntax highlight in the source code snippet
(setq org-src-fontify-natively t)
;; TAB to indent the _whole_(not lines) code snippet block comparing with "#+BEGIN_SRC" part
;; already forget its effect, but enabling the following will make Enter key insert 3 lines
;;(setq org-src-tab-acts-natively t)
;; space before src content and the header such as #+BEGIN_SRC
;; (setq org-edit-src-content-indentation 4)
;; fix problems of more spaces before source code lines in the exported html file
(setq org-src-preserve-indentation t)
(add-hook 'org-mode-hook
		  (lambda ()
			;; in code snippet block, `C-c '` and then TAB to format code snippet lines
			;; display one lone line in one window, get rid of straight right arrow
			(setq truncate-lines nil)
			;; DO NOT end a org file with a newline, default is t(with newline)
			(setq require-final-newline nil)
			(setq org-hide-leading-stars nil)))
;; don not put this into hook
(setq org-startup-indented t)
(setq org-indent-indentation-per-level 3)
;; Prevents accidentally editing hidden text when the point is inside a folded region.
;; use C-c C-r 'org-reveal to show where your point is
(setq org-catch-invisible-edits 'error)
;; disable '_' to subscript or '^' to superscript export
(setq org-export-with-sub-superscripts nil)
;; *bold* is bold without *
;; (setq org-hide-emphasis-markers t)
(defun org-src-format ()
  "Replace
1. `C-c '` to call `org-edit-special`
2. `C-x h` to mark all the source code
3. `TAB` to format it
into one step."
  (interactive)
  (when (org-in-src-block-p)
	(org-edit-special)
	(indent-region (point-min) (point-max))
	(org-edit-src-exit)))
(bind-key "C-c <C-tab>" 'org-src-format org-mode-map)
;; in org-mode file
(setq org-emphasis-alist
	  '(
		("*" (:foreground "cyan" :weight bold))
		("/" (:foreground "cyan" :slant italic))
		("_" (:foreground "cyan" :underline t))
		("=" (:foreground "cyan" :weight bold))
		("~" (:foreground "cyan" :weight bold
						  :box (:line-width 3 :color "#545454" :style released-button)))
		("+" (:foreground "cyan" :strike-through t))))
;; in html file
(setq org-html-text-markup-alist
	  '((bold . "<b>%s</b>")
		(code . "<kbd>%s</kbd>")
		(italic . "<i>%s</i>")
		(strike-through . "<del>%s</del>")
		(underline . "<span class=\"underline\">%s</span>")
		(verbatim . "<code>%s</code>")))
;; C-tab(original 'org-force-cycle-archived) to show the element
;; in another window(simpler version of org-panes.el)
;; then M-PageUp/Down to scroll another window
(bind-key "C-<tab>" 'org-tree-to-indirect-buffer org-mode-map)
;; (setq org-emphasis-alist
;; (append org-emphasis-alist '((" ` " bold "<b>" "</b>"))))
;; (add-to-list 'org-emphasis-alist '("`" (:foreground "cyan")))
;;;;;;;;;;;;;;;
;; org-plus-contrib
;;
;; org-export stylesheet
(setq org-html-head-extra
	  "<link rel=\"stylesheet\" href=\"/home/chz/.emacs.d/lisp/org.css\" type=\"text/css\" />")
(defun my/org-inline-css-hook (exporter)
  "Insert custom inline css to automatically set the
background of code to whatever theme I'm using's background"
  (when (eq exporter 'html)
	(let* ((my-pre-bg (face-background 'default))
		   (my-pre-fg (face-foreground 'default)))
	  (setq
	   org-html-head-extra
	   (concat
		org-html-head-extra
		(format "<style type=\"text/css\">\n pre.src {background-color: %s; color: %s;}</style>\n"
				my-pre-bg my-pre-fg))))))
(add-hook 'org-export-before-processing-hook 'my/org-inline-css-hook)
;; If you never use "plain" footnotes like [1] or p[1], you can adjust two variables
;; to avoid org-mode wrongly interpreting square brackets as footnote
;; Use styles at http://orgmode.org/manual/Footnotes.html such as [fn:1]
;; C-c C-c to jump to/back definition/reference
(setq org-footnote-re
	  (concat "\\[\\(?:"
			  ;; Match inline footnotes.
			  (org-re "fn:\\([-_[:word:]]+\\)?:\\|")
			  ;; Match other footnotes. "\\(?:\\([0-9]+\\)\\]\\)\\|"
			  (org-re "\\(fn:[-_[:word:]]+\\)")
			  "\\)"))
(setq org-footnote-definition-re
	  (org-re "^\\[\\(fn:[-_[:word:]]+\\)\\]"))
;; remove the end part of the exported file such as `author, date, emacs and org-mode version`
(setq org-html-postamble nil)
;; ? before the star at the beginning of headline for all speed commands
(setq org-use-speed-commands t)

;; icicles
;; icicles & helm differences:
;; http://lists.gnu.org/archive/html/help-gnu-emacs/2014-04/msg00500.html
;;
;; I would not recommend to try to run Icicles and Helm in parallel.  I would
;; recommend to try them both, and decide to use only one of them.
;;
;; Generally, Helm is simpler and more straightforward, Icicles is more general
;; and comes with more flexible concept.  In daily usage, I would say that you
;; are faster with Helm, but you can do more stuff with Icicles.  I can't say if
;; I would recommend any of the packages for an Emacs newbie.
;;
;; Icicles uses recursive Minibuffers in several ways, Helm does not.

;; ;; ido for dired and kill-buffer that helm doesn't provide the TAB completion
;; (ido-mode t)
;; (ido-everywhere t)
;; (setq ido-enable-flex-matching t)
;; ;; get find-file-at-point with C-u C-x C-f
;; (setq ffap-require-prefix t)
;; ;; ido-vertical-mode
;; (ido-vertical-mode 1)
;; (setq ido-vertical-show-count t)

;; async requird by helm

;; helm
;; https://github.com/emacs-helm/helm/wiki
;; Find Files or url: ~/
;;  That show all ~/ directory.
;; Find Files or url: ~/des
;;  will show all what begin with "des"
;; Find Files or url: ~/ esk
;;  (Notice the space after ~/) will show all what contain esk.
;; Find Files or url: ~/ el$
;;  Will show all what finish with el
;; use C-{/} to narrow/enlarge the candidates buffer
;; M-<prior>/<next> 'helm-scroll-other-window/-down
;; 'helm-info-gnu/emacs/...
;; in Helm session,
;; use 'C-c ?' to get help(C-c to go back)
;; M-n to yank the symbol at point into the minibuffer
;;(require 'helm-config)
(require 'helm-files)
;; make TAB to complete the existence
(bind-key "<tab>" 'helm-execute-persistent-action helm-map)
(helm-mode 1)
(bind-keys*
 ("M-x" . helm-M-x)
 ;; M-y cycles the kill ring
 ("C-x y" . helm-show-kill-ring)
 ("C-/" . helm-semantic-or-imenu)
 ("C-c x" . helm-resume)
 ("C-s" . helm-occur)
 ;; view the content of the both the local and global mark rings in a friendly interface,
 ;; use C-h SPC to jump back to where you were, like the 'ggtags-view-tag-history
 ("C-h C-SPC" . helm-all-mark-rings)
 ;; helm-apropos describes commands, functions, variables and faces - all in one command!
 ("C-h h" . helm-apropos)
 ("C-h C-c" . helm-colors)
 ("<f1> h" . helm-apropos)
 ;; in dired(you have to go to the dir first), helm-find is like find in terminal,
 ;; helm-locate is like locate in terminal, to use local database with prefix argument C-u
 ;;
 ;; helm-for-files
 ;; list buffers, recentf, bookmarks, files in current dir and even in *locate* after typing
 ;; but it won't create a new file/buffer/bookmark if it doesn't exist in emacs/disk
 ("M-z" . helm-for-files)  ; use other shortcuts to create
 ;;
 ;; helm-mini is like helm-for-files(buffers and recentf only) = helm-buffers-list + helm-recentf
 ;; but will create a new if a buffer(only buffer) doesn't exit
 ;; use C/M-v or left/right to change part(buffers/recentf/create), up/down only work in one part
 ;; use C-x C-f to create a new file C-x b to create a new buffer
 ;; in helm-mini, *c/l to filter the c/l mode files(c/h), *c/l! show all the other but c/l
 ;; /.emacs to filter only the files/buffers in .emacs.., !/.emacs show them not in .emacs...
 ;; @elpa filter only the buffers contain the string 'elpa', then C-s to go to the positions
 ;; in the buffer selected, maybe C-SPC to mark multi-files first, C-u C-s work on the current buffer
 ;; you can combine the above cases, such as: *lisp, *c/l ^helm @helm-find-files(more than one mode using , to seperate)
 ;; ("M-z" . helm-mini)
 ;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
 ("C-x C-r" . helm-recentf)
 ;;
 ;; C-s(helm-ff-run-grep) after C-x C-f to search a file/directory on highlighted...,
 ;; With prefix argument, recursively grep a selected directory. )
 ;; In sessions such as helm-find-files or helm-mini, you can use C-SPC to
 ;; select more than one candidates and execute actions on them, such as grep or open.
 ;; helm-find-files will prompt y/n if the file doesn't exist, find-file won't
 ("C-x C-f" . helm-find-files)
 ("C-x f" . find-file-read-only))
;; create it without prompt when C-x C-f a file that doesn't exist
(setq helm-ff-newfile-prompt-p nil)
(with-eval-after-load 'helm-semantic
  (setq helm-semantic-display-style
		'((c-mode . semantic-format-tag-summarize)
		  (emacs-lisp-mode . semantic-format-tag-summarize))))
(unbind-key "C-x f" global-map)
;; (recentf-mode t)
(setq
 ;; recentf-save-file
 ;; (concat user-emacs-directory "recentf")
 recentf-max-saved-items 100
 ;; recentf-max-menu-items 15
 )
;; Use C-S-s to search other-window, when this is used in more than 3 windows,
;; it would be confused by 'other-window
(defun helm-other-occur ()
  (interactive)
  (save-selected-window
	(other-window 1)
	(helm-occur)))
(bind-key* "C-S-s" 'helm-other-occur)
(defun helm-backspace ()
  "Forward to `backward-delete-char'.
On error (read-only), quit without selecting(showing 'Text is read only' in minibuffer)."
  (interactive)
  (condition-case nil
	  (backward-delete-char 1)
	(error
	 (helm-keyboard-quit))))
(bind-key "DEL" 'helm-backspace helm-map)
(setq
 ;; helm-quick-update t  ; do not display invisible candidates
 ;; helm-split-window-default-side 'other	; open helm buffer in another window
 helm-split-window-in-side-p t ; open helm buffer inside current window, not occupy whole other window
 helm-buffers-favorite-modes
 (append helm-buffers-favorite-modes
		 '(picture-mode artist-mode))	; do not show these files in helm buffer
 helm-boring-file-regexp-list
 '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "\\.i$")
 ;; move to end or beginning of source when reaching top or bottom of source.
 ;; helm-move-to-line-cycle-in-source t
 ;; fuzzy matching buffer names when non--nil, useful in helm-mini that lists buffers
 helm-buffers-fuzzy-matching t
 helm-semantic-fuzzy-match t
 helm-M-x-fuzzy-match t
 helm-imenu-fuzzy-match t
 helm-lisp-fuzzy-completion t
 )
;; Save current position to mark ring when jumping to a different place
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)
;; helm-ag
(require 'helm-ag)
(bind-keys*
 ("C-h g" . helm-projectile-ag)
 ("C-h G" . helm-do-ag))
(setq helm-ag-fuzzy-match t
	  helm-ag-insert-at-point 'symbol)
(bind-key "RET" 'helm-ag--run-other-window-action helm-ag-map)
;;
;; helm-descbinds, describe-bindings using helm, F1-b or C-h b
(add-hook 'after-init-hook 'helm-descbinds-mode)
;; Resize candidates window  according to the number of candidates
(helm-autoresize-mode 1)
;; (setq helm-autoresize-min-height 10)
;; (setq helm-autoresize-max-height 30)
;; (helm-adaptive-mode 1)
;;
;; (setq helm-display-header-line nil)

;; helm-swoop
(require 'helm-swoop)
(bind-key "C-c s" 'helm-swoop)
;; speed(nil) or text color(t)
(setq helm-swoop-speed-or-color t)
;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows t)
;;
(setq helm-swoop-pre-input-function (lambda () ""))
(defun my-helm-swoop-move-line-with-string-at-point-if-needed ($move-fn)
  (if (equal helm-swoop-pattern "")
	  (let (($string ""))
		(with-current-buffer (get-buffer-create (cdr helm-swoop-last-point))
		  (save-excursion
			(goto-char (car helm-swoop-last-point))
			(setq $string (thing-at-point 'symbol))))
		(with-selected-window (or (active-minibuffer-window)
								  (minibuffer-window))
		  (insert $string)))
	(call-interactively $move-fn)))
(defun my-helm-swoop-next-line-with-string-at-point-if-needed ()
  (interactive)
  (my-helm-swoop-move-line-with-string-at-point-if-needed 'helm-next-line))
(defun my-helm-swoop-prev-line-with-string-at-point-if-needed ()
  (interactive)
  (my-helm-swoop-move-line-with-string-at-point-if-needed 'helm-previous-line))
(bind-keys :map helm-swoop-map
		   ("C-s" . my-helm-swoop-next-line-with-string-at-point-if-needed)
		   ("C-r" . my-helm-swoop-prev-line-with-string-at-point-if-needed))

;; projectile required by helm-projectile

;; helm-projectile
;; http://tuhdo.github.io/helm-projectile.html
;; all projectile & helm-projectile commands has prefix C-c p
(require 'helm-projectile)
(projectile-global-mode)
;; (helm-projectile-on)
;; (eval-after-load "projectile"
;;   '(progn
;; 	 (setq magit-repo-dirs
;; 		   (mapcar
;; 			(lambda (dir)
;; 			  (substring dir 0 -1))
;; 			(remove-if-not
;; 			 (lambda (project)
;; 			   (file-directory-p (concat project "/.git/")))
;; 			 (projectile-relevant-known-projects))))
;; 	 ))
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; for large projects
;;(setq helm-projectile-sources-list
;;    '(helm-source-projectile-projects
;;      helm-source-projectile-files-list))
;; cache make it quick for large project, but cache will make the `C-c c p` only
;; work for cached files, use `C-c p i` or prefix `C-u` to make the cache invalidated
(setq projectile-enable-caching t)
;; change projectile to helm-projectile
;; projectile can create a file or dir if not found, but helm-projectile cannot
(setq projectile-switch-project-action 'helm-projectile-find-file)
;;(setq projectile-switch-project-action
;;    'helm-projectile)
;; modify the indicator in mode line
(setq projectile-mode-line
	  '(:eval (format "" (projectile-project-name))))

;;;; s required by flycheck
;;;; f required by flycheck
;;
;; flycheck
;; By default, Flycheck Mode checks syntax automatically when
;; - the mode is enabled,
;; - the file is saved,
;; - new lines are inserted,
;; - or some short time after the last change to the buffer.
;; http://flycheck.readthedocs.org/en/latest/manual/usage.html#syntax-checker-configuration
;; Mode line:: Flycheck indicates its state in the mode line:
;; FlyC
;;	There are no errors in the current buffer.
;; FlyC*
;;	A syntax check is being performed currently.
;; FlyC:3/4
;;	There are three errors and four warnings in the current buffer.
;; FlyC-
;;	Automatic syntax checker selection did not find a suitable syntax checker.
;;	See Syntax checker selection for more information.
;; FlyC!
;;	The syntax check failed. Inspect the *Messages* buffer for details.
;; FlyC?
;;	The syntax check had a dubious result. The definition of the syntax checker
;;	may be flawed. Inspect the *Messages* buffer for details. This indicator
;;	should never be displayed for built-in syntax checkers. If it is, please
;;	report an issue to the Flycheck developers, as by Reporting issues.
;; C-c ! l 'flycheck-list-errors
;; C-c ! n 'flycheck-next-error
;; C-c ! p 'flycheck-previous-error
;; C-c ! c 'flycheck-buffer
;; install clang cppcheck first for c/c++ checker
;; (require 'flycheck)
(add-hook 'prog-mode-hook 'flycheck-mode)
(setq flycheck-highlighting-mode 'lines)
(eval-after-load 'flycheck
  '(progn
	 (set-face-attribute 'flycheck-error nil :foreground "red")
	 (set-face-attribute 'flycheck-warning nil :foreground "yellow" :underline nil)
	 (set-face-attribute 'flycheck-info nil :foreground "ForestGreen" :underline nil)))
;; flycheck-pos-tip
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))


;; magit
;;
;; git-commit-mode required by magit
;; git-rebase-mode required by magit
;; (eval-after-load 'info
;;   '(progn (info-initialize)
;;            (add-to-list 'Info-directory-list "~/.emacs.d/elpa/magit-*/")))
(autoload 'magit "magit: git for Emacs" t)
;; point to your favorite repos, Now use C-u M-x magit-status and have
;; magit prompt you to choose from one of your favorite repos.
;; mapc: http://tuhdo.github.io/emacs-tutor3.html
;; use C-u C-x g to ask which repo to choose, C-c m to the current dir
(bind-key* "C-x g" 'magit-status)
;; open a link not prompt yes/no
(setq vc-follow-symlinks nil)
;; make vc* and magit work for link
(setq find-file-visit-truename t)
(set-default 'magit-stage-all-confirm nil)
(set-default 'magit-unstage-all-confirm nil)
;; make git faster??
(eval-after-load "magit" '(setq magit-git-executable "/usr/bin/git"))
;; make `truncate-lines` nil in magit and `auto-fill-mode` off in commit buffers
(add-hook 'magit-status-mode-hook
		  (lambda ()
			(setq truncate-lines nil)
			(magit-filenotify-mode)
			))
(add-hook 'git-commit-mode-hook
		  (lambda ()
			(turn-off-auto-fill)
			(flyspell-mode)))
;; make the item in magit buffer easy to see after TAB
(defadvice magit-toggle-section (after magit-toggle-top activate)
  "TAB a item to scroll the of the repeat."
  (recenter-top-bottom 0))

;; emmet for web development
;; http://docs.emmet.io/
(dolist (mode '(sgml-mode-hook html-mode-hook css-mode-hook))
  (add-hook mode
			'(lambda ()
			   (emmet-mode))))
;; web-mode
;; http://web-mode.org/
(require 'web-mode)
(dolist (hook '(;; css-mode-hook
				html-mode-hook))
  (add-hook hook (lambda () (web-mode))))
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)))
(bind-key "C-S-SPC" 'web-mode-mark-and-expand web-mode-map)
(setq web-mode-enable-current-element-highlight t)
;; rainbow-mode
(add-hook 'css-mode-hook 'rainbow-mode)

;; lua-mode, default 3 spaces indent, lua-indent-level in lua-mode.el
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
(setq lua-indent-level 4)

;; hide-comments
(autoload 'hide-comnt "hide comments" t)
(defalias 'hc 'hide/show-comments-toggle)

;; yafolding
;; C-M-return 'yafolding-toggle-all
;; C-return 'yafolding-toggle-element
(autoload 'yafolding "yafolding" t)
(add-hook 'python-mode-hook 'yafolding-mode)
(add-hook 'prog-mode-hook 'yafolding-mode)

;; origami
(require 'origami)
(global-origami-mode)
(setq origami-show-fold-header t)
(set-face-attribute 'origami-fold-fringe-face nil :foreground "yellow")
(bind-keys*
 ("C-c <C-return>" . origami-toggle-node)
 ("C-c <S-return>" . origami-recursively-toggle-node)
 ("C-c <C-M-return>" . origami-toggle-all-nodes))

;; highlight-symbol
(autoload 'highlight-symbol "highlight-symbol" t)
(eval-after-load "highlight-symbol" '(highlight-symbol-nav-mode))
(dolist (hook '(prog-mode-hook python-mode-hook org-mode-hook ielm-mode-hook))
  (add-hook hook 'highlight-symbol-mode))
;; enable highlighting symbol at point automatically
(setq highlight-symbol-on-navigation-p t)
(global-set-key [(control shift mouse-1)]
				(lambda (event)
				  (interactive "e")
				  (goto-char (posn-point (event-start event)))
				  (highlight-symbol-at-point)))
;; donnot use bind-keys* here, it will affect the history in minibuffer
(bind-keys
 ("M-n" . highlight-symbol-next)
 ("M-p" . highlight-symbol-prev)
 ("M-'" . highlight-symbol-query-replace))
;;
;; highlight-parentheses-mode, highlight nested parens, brackets, braces at each
;; depth, use hl-sexp-mode to replace if you like
(add-hook 'prog-mode-hook 'highlight-parentheses-mode)
;;
;; rainbow-delimiters
;; rainbow nested parens, brackets, braces a different color at each depth
;;  like highlight-parentheses-mode but static
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'racket-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'scheme-mode-hook #'rainbow-delimiters-mode)

;; ;;
;; ;; rainbow-identifiers
;; ;; rainbow identifiers according to their names
;; (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
;; ;; dark color
;; (setq rainbow-identifiers-choose-face-function
;;    'rainbow-identifiers-cie-l*a*b*-choose-face
;;    rainbow-identifiers-cie-l*a*b*-lightness 70
;;    rainbow-identifiers-cie-l*a*b*-saturation 50
;;    rainbow-identifiers-cie-l*a*b*-color-count 65536)
;;
;; color-identifiers-mode -- better than rainbow-identifiers
(add-hook 'prog-mode-hook 'color-identifiers-mode)

;; makey required by discover-my-major and discover

;; discover-my-major
;; Discover key bindings and meaning for the current Emacs major mode
;; C-h C-m or C-h RET 'discover-my-major
(bind-key* "C-h C-m" 'discover-my-major)

;; drag-stuff
;; word(s), line(s), region, M-<left/right/up/down> to move select if (s)
(require 'drag-stuff)
(dolist (mode '(prog-mode-hook
				emacs-lisp-mode-hook
				python-mode-hook
				ielm-mode-hook
				text-mode-hook))
  (add-hook mode
			'(lambda ()
			   (drag-stuff-mode))))
;; disable drag-stuff-mode in org-mode because of the M-... in it
;; don't use remove-hook, it doesn't work here
(add-hook 'org-mode-hook
		  (lambda() (set (make-local-variable 'drag-stuff-mode) nil)))

;; transpose
(bind-keys* :prefix-map global-map
			:prefix "M-t"
			("w" . transpose-words)
			("l" . transpose-lines)
			("s" . transpose-sexps)
			("t" . anchored-transpose))
(autoload 'anchored-transpose "anchored-transpose" nil t)

;; gnus
;; bbdb, w3m installed for gnus, check the
;; ~/.gnus(~/.emacs.d/init-gnus.el) for more info
(require 'init-gnus)

;; rebox2 to replace comment-box
(require 'rebox2)
;; default style
;; (setq rebox-style-loop '(11 15 111))
(setq rebox-min-fill-column 40)
;; M-q(rebox-dwim) is to fill first
(bind-key* "M-r" 'rebox-cycle)
;; you can change the style in the box(no mark needed) to such as 126
;; using M-126 M-q, but only from the original to 126, not 126 to another again
(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(set (make-local-variable 'rebox-style-loop) '(21 25 111))
			(rebox-mode 1)))
(add-hook 'c-mode-hook
		  (lambda ()
			(set (make-local-variable 'rebox-style-loop) '(243 241 111))
			(rebox-mode 1)))
(add-hook 'c++-mode-hook
		  (lambda ()
			(set (make-local-variable 'rebox-style-loop) '(25 21 111))
			(rebox-mode 1)))
(unbind-key "<S-return>" rebox-mode-map)
(unbind-key "M-w" rebox-mode-map)

;; comment-dwim-2 to replace default comment-dwim
;; comment-dwim can also be repeated several times to switch between the different behaviors.
;; Called it with a prefix argument to reindent the comment
(bind-key* "M-;" 'comment-dwim-2)
(setq comment-dwim-2--inline-comment-behavior 'reindent-comment)

;; whole-line-or-region
(add-hook 'after-init-hook 'whole-line-or-region-mode)
;; ;; these basically do the C/M-w thing
;; (defadvice kill-region (before slick-cut activate compile)
;;   "When called interactively with no active region, kill a single line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))
;; (defadvice kill-ring-save (before slick-cut activate compile)
;;   "When called interactively with no active region, copy a single line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))
;; (global-set-key (kbd "M-w") 'kill-ring-save)

;; which-key to replace guide-key
(which-key-mode)
;; this will make C-h show next page if C-h in the first place instead of
;; help page, use ? for help page
(unbind-key "C-h" help-map)
;; using this instead of minibuffer prevent the confict of semantic and the
;; which-key window at the minibuffer
(which-key-setup-side-window-bottom)
;; C-h to cycle the which-key pages
(setq which-key-use-C-h-for-paging nil
	  which-key-special-keys nil
	  which-key-sort-order 'which-key-description-order
	  which-key-show-remaining-keys t
	  which-key-max-description-length 35)
(setq which-key-highlighted-command-list
	  '("helm\\|toggle\\|projectile\\|describe"		;; default link
		("\\(^cscope\\)\\|\\(^ggtags\\)" . warning)		; orange
		("register" . success)								; green
		("rectangle" . error)								; red
		("help\\|emacs\\|bookmarks" . highlight)			; gray and bg
		))

;; noflet, iedit, ace-window, hydra required by lispy
(bind-key* "C-x q" 'ace-window)

;; lispy -- amazing mode for Elisp, Clojure, Scheme and Common Lisp
;; http://oremacs.com/lispy/
(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
(eval-after-load "lispy"
  '(progn
	 (bind-keys :map lispy-mode-map
				("RET" . advanced-return)
				("M-RET" . Meta-return)
				("M-n" . highlight-symbol-next))))
(defadvice lispy-kill (around lispy-kill-advice activate)
  "In lispy code, disable lispy C-k in comments, in comments, C-k will be self defined`delete-line`"
  (if (lispy--in-comment-p)
	  (delete-line (prefix-numeric-value current-prefix-arg))
	(delete-line 1)))

;; minibuffer
(dolist (mode '(emacs-lisp-mode-hook ielm-mode-hook eval-expression-minibuffer-setup-hook))
  (add-hook mode
			'(lambda ()
			   (eldoc-mode)
			   (lispy-mode))))

;; browse-kill-ring required by bbyac

;; bbyac
(bbyac-global-mode 1)

;; omni-scratch
(bind-key* "C-x B" 'omni-scratch-new-scratch-major-buffer)

;; make someWord two words for M-f/b, some-word, some_word are two words already
;; subword-mode is already replaced by syntax-subword
;; (subword-mode)
;; syntax-subword
(global-syntax-subword-mode)
;; disable C-c C-w for subword-mode, this is defined in cc-mode.el
(unbind-key "C-c C-w" c-mode-base-map)

;; ;; ranger
;; (setq ranger-cleanup-on-disable nil)
;; (setq ranger-cleanup-eagerly t)
;; (setq ranger-width-parents 0.12)
;; ;; (setq ranger-max-parent-width 0.12)
(setq ranger-parent-depth 2)
(bind-keys*
 ("C-x C-r" . ranger)
 ("C-c h" . ranger-show-history))

;; go-mode, go-eldoc
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'before-save-hook #'gofmt-before-save)

;; racket
(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))

;; zeal-at-point
(bind-key* "C-c z" 'zeal-at-point)

;; smartparens
;; M-x customize-group smartparens
;; M-x sp-cheat-sheet
(require 'smartparens-config)
(smartparens-global-mode t)
(eval-after-load "smartparens"
  '(progn
	 (sp-use-smartparens-bindings)))
;; hit C-(
;; |foobar becomes (foobar)
(sp-pair "(" ")" :wrap "C-(")
;; ;; 1. use this one or 2, only can be enabled
;; (defun insert-c-block-parentheses (id action context)
;;   (when (eq action 'insert)
;;     (newline)
;;     (newline)
;;     (indent-according-to-mode)
;;     (previous-line)
;;     (indent-according-to-mode)))
;; (sp-local-pair '(c-mode c++-mode java-mode) "{" nil :post-handlers '(:add insert-c-block-parentheses))
;; 2. use this one to insert {} and then M-return to insert the effect of 1
(sp-local-pair '(c-mode c++-mode java-mode) "{" nil :post-handlers '((insert-c-block-parentheses-without-indent "M-RET")))
(defun insert-c-block-parentheses-without-indent (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))
(setq sp-override-key-bindings
	  '(
		("M-<backspace>" . delete-word-backward)))
(sp--update-override-key-bindings)

;; deft
(setq deft-directory "~/Org")
(setq deft-recursive t)
(setq deft-default-extension "org")
(setq deft-use-filename-as-title t)
(bind-key* "C-x C-d" 'deft)

;; electric-operator
;; check electric-operator--mode-rules-table
;; another system tool is GNU indent
(require 'electric-operator)
(add-hook 'c-mode-common-hook #'electric-operator-mode)
(electric-operator-add-rules-for-mode
 'c-mode
 (cons "<" " < ")
 (cons ">" " > "))
(electric-operator-add-rules-for-mode
 'c++-mode
 (cons "<" " < ")
 (cons ">" " > "))

;; multifiles
(require 'multifiles)
(eval-after-load "multifiles"
  '(progn
	 (multifiles-minor-mode 1)
	 (bind-key* "C-x n c" 'mf/mirror-region-in-multifile)))

;; LaTeX -- AucTex
;; C-c ? (or M-x TeX-doc) gives documentation for the symbol at point,
;; or for any package, command or document.
(load "auctex.el" nil t t)
(require 'tex-mik)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;; when you open a file, ask for the master file but not changing any file
;; this will make the LaTeX-save-and-compile deal with multi-files project
(setq-default TeX-master 'shared)
;; LaTeX-mode for tex file
;; (add-hook 'plain-TeX-mode-hook 'LaTeX-mode)
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))
;; company-auctex
(require 'company-auctex)
(require 'tex-buf)
;; (require 'auctex-latexmk)
;; (auctex-latexmk-setup)
;; 
;; remove fdb_latexmk file will solve the problem
;; of the reference number instead of question mark (?)
(setq LaTeX-clean-intermediate-suffixes
	  (append LaTeX-clean-intermediate-suffixes
			  (list "\\.fdb_latexmk")))
(defun LaTeX-save-and-compile ()
  "Save and compile the tex project using latexmk.

If compilation fails, split the current window and open error-buffer
then jump to the error line, if errors corrected, close the error-buffer
window and close the *TeX help* buffer."
  (interactive)
  (progn
	;; ;; turn off smartparens because LaTeX-electric-left-right-brace
	;; ;; offers more for specific LaTeX mode
	;; ;; Since SP is always triggered later by sth., so put these two lines here
	;; (turn-off-smartparens-mode)
	;; (setq LaTeX-electric-left-right-brace t)
	(let ((TeX-save-query nil)
		  (TeX-process-asynchronous nil)
		  (master-file (TeX-master-file)))
	  (TeX-save-document "")
	  ;; clean all generated files before compile
	  ;; DO NOT do it when up-to-date, remove this line in proper time
	  (TeX-clean t)
	  (TeX-run-TeX "latexmk"
				   (TeX-command-expand "latexmk -pdf %s" 'TeX-master-file)
				   master-file)
	  (if (plist-get TeX-error-report-switches (intern master-file))
		  ;; avoid creating multiple windows to show the *TeX Help* error buffer
		  (if (get-buffer-window (get-buffer "*TeX Help*"))
			  (TeX-next-error)
			(progn
			  (split-window-vertically -10)
			  (TeX-next-error)))
		;; if no errors, delete *TeX Help* window and buffer
		(if (get-buffer "*TeX Help*")
			(progn
			  (if (get-buffer-window (get-buffer "*TeX Help*"))
				  (delete-windows-on "*TeX Help*"))
			  (kill-buffer "*TeX Help*")))))))
(add-hook 'LaTeX-mode-hook
		  (lambda ()
			(setq LaTeX-item-indent 0)
			(visual-line-mode)
			(flyspell-mode)
			(setq-default TeX-newline-function 'advanced-return)
			;; make the code look like the pdf file, C-c C-o ... for commands
			;; If it should be activated in all AUCTEX modes, use TeX-mode-hook
			;; instead of LaTeX-mode-hook.
			(TeX-fold-mode 1)
			;; usepackage
			(setq tex-tree-roots t)
			(LaTeX-math-mode)
			;; this line have to be here to make company work
			(company-auctex-init)
			;; disable smartparens-mode completely and use
			;; LaTeX-electric-left-right-brace instead
			(push 'latex-mode sp-ignore-modes-list)
			(setq LaTeX-electric-left-right-brace t)
			;; the following line will inset braces after _ or ^
			;; unnecessarily most of time
			;; (setq TeX-electric-sub-and-superscript t)
			;; C-u C-c C-c latexmk (or others like View) so you can change the command line
			(add-to-list 'TeX-command-list
						 ;; '("latexmk" "(LaTeX-save-and-compile)"
						 '("latexmk" "latexmk -pdf %s"
						   TeX-run-command nil t :help "Run latexmk") t)
			(setq TeX-command-default "latexmk")
			(bind-keys :map LaTeX-mode-map
					   ;; default C-c C-e rebound and cannot be rebound
					   ("C-c C-x e" . LaTeX-environment)
					   ("C-c C-x s" . LaTeX-section)
					   ("C-c C-x m" . TeX-insert-macro)
					   ("C-x C-s" . LaTeX-save-and-compile)
					   ;; default C-c. not working and replaced by org-time-stamp
					   ("C-c m" . LaTeX-mark-environment)
					   ;; ("<tab>" . TeX-complete-symbol)
					   ("M-<return>" . LaTeX-insert-item)
					   )))
(setq LaTeX-command-section-level t)
;; C-c C-c without prompt, use Clean by default, to clean aux and log files
;; Use "Clean All" to clean files including generated pdf file
;; Or use M-x Tex-clean (Clean) and prefix(Clean All)
;; (setq TeX-command-force "Clean")
(setq TeX-clean-confirm nil)
;; Use C-c C-c to compile the tex file into pdf file automatically using LaTex,
;; and C-c C-v to view it using okular
;; NOTE: C-c C-a to combine C-c C-c and C-c C-v"
(setq TeX-view-program-selection
	  '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
	  '(("PDF Viewer" "okular -p %(outpage) %o")))
;; RefTex -- built-in
;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)
;; magic-latex-buffer
;; (require 'magic-latex-buffer)
;; (add-hook 'LaTeX-mode-hook 'magic-latex-buffer)
;; latex-preview-pane
;; (add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)
(setq
 ;; Function for reading \includegraphics files
 LaTeX-includegraphics-read-file 'LaTeX-includegraphics-read-file-relative
 ;; Strip known extensions from image file name
 LaTeX-includegraphics-strip-extension-flag nil)
;; (setq LaTeX-section-hook
;; 	  '(LaTeX-section-heading
;; 		LaTeX-section-title
;; 		LaTeX-section-toc
;; 		LaTeX-section-section
;; 		LaTeX-section-label))

;; outline, C-c @ prefix
(add-hook 'outline-minor-mode-hook
          (lambda ()
            (require 'outline-magic)
            (bind-keys :map outline-minor-mode-map ("<C-tab>" . outline-cycle))))
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

;; esup -- analyze the startup time of ~/.emacs
;; M-x esup

;; flx -- required by company-flx-mode

;; company-flx
(with-eval-after-load 'company
  (company-flx-mode +1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; Put the following lines at the end of this file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; make the lighter in mode line shorter or disappeared
;; C-h v minor-mode-alist to get the exact mode names
(defvar mode-line-cleaner-alist
  '(
	(helm-mode . "")
	(eldoc-mode . "")
	(undo-tree-mode . "")
	(yas-minor-mode . "")
	(company-mode . "")
	(highlight-symbol-mode . "")
	(highlight-parentheses-mode . "")
	(cwarn-mode . "")
	(flyspell-mode . "")
	(abbrev-mode . "")
	(drag-stuff-mode . "")
	(ggtags-mode . " Gg")
	(auto-fill-function . "") ;; not auto-fill-mode
	(rebox-mode . "")
	(indent-guide-mode . "")
	(guide-key-mode . "")
	(whole-line-or-region-mode . "")
	(whitespace-mode . "")
	(subword-mode . "")
	(smooth-scroll-mode . "")
	(org-indent-mode . "")
	(color-identifiers-mode . "")
	(bbyac-mode . "")
	(magit-auto-revert-mode . "")
	(highlight-changes-mode . "")
	(ggtags-mode . "")
	(rainbow-mode . "")
	(buffer-face-mode . "")
	(visual-line-mode . "")
	(reftex-mode . "")
	;; Major modes
	(lisp-interaction-mode . "λ")
	(emacs-lisp-mode . "El")
	(hi-lock-mode . "")
	(python-mode . "Py")
	(nxhtml-mode . ""))
  "Alist for `clean-mode-line'.
When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")
(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
		do (let* ((mode (car cleaner))
				  (mode-str (cdr cleaner))
				  (old-mode-str (cdr (assq mode minor-mode-alist))))
			 (when old-mode-str
			   (setcar old-mode-str mode-str))
			 ;; major mode
			 (when (eq mode major-mode)
			   (setq mode-name mode-str)))))
(add-hook 'after-change-major-mode-hook 'clean-mode-line)
