;;; init.el --- Emacs configuration of Cody Chan
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

;; (setq debug-on-error t)

;; proxy goagent
;; (setq url-proxy-services '(("http*" . "127.0.0.1:8087")))


;;add timestamps in *Messages*
(defun current-time-microseconds ()
  (let* ((nowtime (current-time))
		 (now-ms (nth 2 nowtime)))
	(concat (format-time-string "[%Y-%m-%dT%T" nowtime) (format ".%d] " now-ms))))
(defadvice message (before test-symbol activate)
  (if (not (string-equal (ad-get-arg 0) "%s%s"))
	  (let ((deactivate-mark nil)
			(inhibit-read-only t))
		(save-excursion
		  (set-buffer "*Messages*")
		  (goto-char (point-max))
		  (if (not (bolp))
			  (newline))
		  (insert (current-time-microseconds))))))

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
;; and M-x package-install under `emacs -q`(prevents it from loading my .emacs file, which includes many references to org-mode stuff.)
;; to prevent two versions of org-mode messed-up
(package-initialize)

;; add-subdirs-to-load-path, don't need to change add-to-list after
;; every update in elpa, theme is needed the path
(defun add-subdirs-to-load-path (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
	(add-to-list 'load-path dir)
	(normal-top-level-add-subdirs-to-load-path)))
(add-subdirs-to-load-path "/usr/share/emacs/")
(add-subdirs-to-load-path "~/.emacs.d/")

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
;; reload .emacs in new session == open a new session
(global-set-key (kbd "C-c C-r")
				'(lambda ()
				   (interactive)
				   (load-file "~/.emacs.d/init.elc")
				   ))
;; ;; combining the above two version:: WRONG
;; (defun byte-compile-and-reload-elisp ()
;;	 (interactive)
;;	 (when (and (eq major-mode 'emacs-lisp-mode)
;;				(when (file-exists-p (byte-compile-dest-file buffer-file-name))
;;				  (delete-file (concat buffer-file-name ".elc")))
;;				(emacs-lisp-byte-compile-and-load))))
;; (add-hook 'after-save-hook 'byte-compile-and-reload-elisp)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Emacs Face Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(setq bookmark-save-flag t)
;; Make Text mode the default mode for new buffers.
;;(setq-default major-mode 'org-mode)
;;(add-hook 'text-mode-hook 'auto-fill-mode)
(setq column-number-mode t)
;; Set the max columns one line, wrap a line
(setq-default fill-column 80)
;; C-x </> 'scroll-left/right if line is too long
;; fill-column is not working for magit buffer long commit messages
(put 'scroll-left 'disabled nil)
(setq comment-style 'extra-line)
;; file size in mode line
(setq size-indication-mode t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(global-set-key (kbd "C-S-m") 'menu-bar-mode)
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
(setq frame-title-format
	  '("%b@%f" "--" display-time-string))
;;
;; syntax highlight
(global-font-lock-mode t)
;; Turn on font lock mode in all the files
(setq font-lock-maximum-decoration t)
;;
;; font-lock and linum-mode will slow Emacs
;; To improve performance when editing large size of file
;; If not enough, using vlf(https://github.com/m00natic/vlfi)
(defun check-file-hook ()
  "If a file is over a given size, turn off minor modes.
If a file need root priority, open it as root."
  (progn
	;; file size check
	(when (> (buffer-size) (* 1024 100))	;; 100 KB
	  (when (> (buffer-size) (* 1024 1024))	;; 1 MB
		(require 'vlf)
		(vlf-mode)
		)
	  (linum-mode -1))
	;; sudo to edit, kill *tramp* buffer to exit the root mode
	(unless (and buffer-file-name
				 (file-writable-p buffer-file-name))
	  (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name)))
	))
(add-hook 'find-file-hook 'check-large-file-hook)

;; displays the argument list for current func, work for all languages
(turn-on-eldoc-mode)
(dolist (mode '(prog-mode-hook python-mode-hook ielm-mode-hook))
  (add-hook mode
			'(lambda ()
			   (turn-on-eldoc-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;   theme & font
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; M-:(print (font-family-list)) to list all available fonts
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
;; (setq default-frame-alist '((font . "Menlo-12")))
;; set italic font for italic face, since Emacs does not set italic face automatically
;; (set-face-attribute 'italic nil
;;					  :family "Menlo-Italic")
;;
;; set the default window size at startup according to the resolutions
;; (setq default-frame-alist '((height . 37) (width . 80)))
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
				  '((top . 0)(left . 0)
					(width . 85)(height . 48)
					(font . "PragmataPro-13")
					;; (:family "Menlo-Italic");; Monaco, Consolas
					))
		  (setq default-frame-alist
				'((top . 0)(left . 0)
				  (width . 85)(height . 35)
				  (font . "PragmataPro-13")
				  ;; (:family "Menlo-Italic")
				  )))
		))
  ;; the following two settings are specifically for afternoon-theme
  ;; the combination colors of highlighted line and comments
  ;; (custom-set-faces
  ;;  '(font-lock-comment-face
  ;;	((t (:foreground "gray60" :slant italic :weight normal :family "Menlo")))
  ;;	))
  ;; (set-face-background 'highlight "gray30")
  )
;;
(set-frame-size-according-to-resolution)

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
;; replace ??? to n/a
(setq which-func-unknown "n/a")
;; repalce the 8 with other number to change the position
(let ((which-func '(which-func-mode ("" which-func-format " "))))
  (setq-default mode-line-format
				(remove which-func mode-line-format))
  (setq-default mode-line-misc-info
				(remove which-func mode-line-misc-info))
  (setq cell (last mode-line-format 8)) ;; just next to buffer name
  (setcdr cell (cons which-func (cdr cell))))
;;
;; line/column/percent/size, just "(%l,%c)[%p/%I]" if not highlight
(setq-default mode-line-position
			  '(("(%l,"
				 (:eval (propertize "%c" 'face
									(if (>= (current-column) 80)
										'mode-line-80col-face
									  'mode-line-position-face)))
				 "_%p-%I) ")))
;; highlight when point is over 80th column
(make-face 'mode-line-80col-face)
(make-face 'mode-line-position-face)
(set-face-attribute 'mode-line-80col-face nil :background "red1")
(set-face-attribute 'mode-line-position-face nil)
;; mode-line color
(custom-set-faces
 ;; no special for which-func
 '(which-func ((t (:background nil :foreground nil))))
 '(mode-line ((t (:background "dim gray" :foreground "white"))))
 '(mode-line-inactive ((t (:background nil))))
 '(mode-line-buffer-id ((t (:foreground nil :background nil))))
 )
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


;; make someWord two words for M-f/b, some-word, some_word are two words already
(subword-mode)
;; make the point easy to see
(global-hl-line-mode 1)
(set-default 'cursor-type 'bar)

;; using a visible bell when error occurs
(setq visible-bell t)

;; Using F8 to make the face transparent
(global-set-key [(f8)] 'loop-alpha)
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
	 (car h)(car (cdr h)))
	(setq alpha-list (cdr (append alpha-list (list h))))
	)
  )

;; set the query-replace from top
(defun query-replace-from-top ()
  (interactive)
  (save-excursion
	(beginning-of-buffer)
	(call-interactively 'query-replace)))
(global-set-key (kbd "M-%") 'query-replace-from-top)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;	defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; flush blank lines
;;
(defun flush-blank-lines (start end)
  (interactive "r")
  (flush-lines "^\\s-*$" start end nil))

;; make `C-a/e` keep going to beginning/end of next line(previous with C-u)
;; These will as normal in comment block because of goddamn rebox2
(defun keep-beginning-of-line (arg)
  (interactive "P")
  (when (bolp) (forward-line (if arg -1 1)))
  (move-beginning-of-line nil))
(defun keep-end-of-line (arg)
  (interactive "P")
  (when (eolp) (forward-line (if arg -1 1)))
  (move-end-of-line nil))
(global-set-key [remap move-beginning-of-line] #'keep-beginning-of-line)
(global-set-key [remap move-end-of-line] #'keep-end-of-line)

;; make the default sentence ending with two spaces concept nil
;; Now it work for expand-region to expand sentence
(setq sentence-end-double-space nil)

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
  (endless/convert-punctuation "," ".")
  (if (use-region-p)
      (call-interactively 'capitalize-region)
    ;; A single space at the start of a line:
    (when (looking-at "^\\s-\\b")
      ;; get rid of it!
      (delete-char 1))
    (call-interactively 'subword-capitalize)))
(defun endless/downcase ()
  "Downcase region or word.
Also converts full stops to commas."
  (interactive)
  (endless/convert-punctuation "\\." ",")
  (if (use-region-p)
      (call-interactively 'downcase-region)
    (call-interactively 'subword-downcase)))
(defun endless/upcase ()
  "Upcase region or word."
  (interactive)
  (if (use-region-p)
      (call-interactively 'upcase-region)
    (call-interactively 'subword-upcase)))
(global-set-key "\M-c" 'endless/capitalize)
(global-set-key "\M-l" 'endless/downcase)
(global-set-key "\M-u" 'endless/upcase)

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
(define-key process-menu-mode-map (kbd "d") 'delete-process-at-point)

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

;; convert DOS to UNIX
(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'unix 't))

;; format whole buffer
(defun fb ()
  "format whole buffer using `indent-region`"
  (interactive)
  (indent-region (point-min) (point-max)))

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
(global-set-key "\C-ce" 'show-ws-toggle-show-trailing-whitespace)
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
--URL http://ergoemacs.org/emacs/emacs_shrink_whitespace.html version 2014-10-21"
  (interactive)
  (let ((pos (point))
		line-has-meat-p ; current line contains non-white space chars
		space-tab-neighbor-p
		whitespace-begin whitespace-end
		space-or-tab-begin space-or-tab-end)
	(save-excursion
	  (setq space-tab-neighbor-p (if (or (looking-at " \\|\t") (looking-back " \\|\t")) t nil))
	  (beginning-of-line)
	  (setq line-has-meat-p (search-forward-regexp "[[:graph:]]" (line-end-position) t))
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
	(if line-has-meat-p
		(let (deleted-text)
		  (when space-tab-neighbor-p
			;; remove all whitespaces in the range
			(setq deleted-text (delete-and-extract-region space-or-tab-begin space-or-tab-end))
			;; insert a whitespace only if we have removed something different than a simple whitespace
			(if (not (string= deleted-text " "))
				(insert " "))))
	  (progn (delete-blank-lines)))))
(global-set-key (kbd "C-<backspace>") 'shrink-whitespaces)
;;;
;; delete not kill it into kill-ring
;; http://ergoemacs.org/emacs/emacs_kill-ring.html
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-word (- arg)))
(defun delete-line (arg)
  "Delete text from current position to end of line char.
With argument, forward ARG lines."
  (interactive "p")
  (let (x1 x2)
	(setq x1 (point))
	(forward-line (- arg 1))
	(move-end-of-line 1)
	(setq x2 (point))
	(delete-region x1 x2))
  ;; (delete-region
  ;; (point)
  ;;  (save-excursion
  ;;     ;; (forward-line arg)
  ;;     (forward-line (if arg -1 1))
  ;;     (move-end-of-line 1)
  ;;     (point)))
  )
(defun delete-line-backward (arg)
  "Delete text between the beginning of the line to the cursor position.
With argument, backward ARG lines."
  (interactive "p")
  (let (x1 x2)
    (setq x1 (point))
	(previous-line (- arg 1))
    (move-beginning-of-line 1)
    (setq x2 (point))
    (delete-region x1 x2)))
(global-set-key (kbd "M-d") 'delete-word)
(global-set-key (kbd "<M-backspace>") 'backward-delete-word)
(global-set-key (kbd "C-k") 'delete-line)
(global-set-key (kbd "C-S-k") 'delete-line-backward)

;;
;; clean buffer/format using C-c n
;; (defun buffer-cleanup ()
;;	 "Clean up the buffer"
;;	 (interactive)
;;	 ;; the useless blanks lines at the end of the file
;;	 (delete-blank-lines)
;;	 (delete-trailing-whitespace)
;;	 (untabify (point-min) (point-max))
;;	 ;; will cause format problem
;;	 (indent-region (point-min) (point-max)))
;;(global-set-key (kbd "C-c n") 'buffer-cleanup)
;; do not use buffer-cleanup, it is too much
;; C-c e to 'show-ws-toggle-show-trailing-whitespace
(global-set-key (kbd "C-c d")
				'(lambda ()
				   (interactive)
				   (yafolding-show-all) ;; avoid data loss
				   (delete-trailing-whitespace)))
(add-hook 'before-save-hook
		  '(lambda ()
			 (yafolding-show-all) ;; avoid data loss
			 (delete-trailing-whitespace)))

;; indent marked files in dirs
;; C-u C-x d dir --> -lsR --> * / --> * t (then unmark the files no needed)
;; --> M-x indent-marked-files
(defun indent-marked-files ()
  (interactive)
  (dolist (file (dired-get-marked-files))
	(find-file file)
	(indent-region (point-min) (point-max))
	(save-buffer)
	(kill-buffer nil)))
;; C-x k to kill a buffer specified
(global-set-key (kbd "C-S-d") 'kill-this-buffer)

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
(global-set-key (kbd "<f7>") 'switch-to-minibuffer-window)
(global-set-key (kbd "C-c b") 'ibuffer)
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
(global-set-key [C-prior] 'prev-user-buffer)
(global-set-key [C-next] 'next-user-buffer)
;; switch to last visited buffer
(defun last-visited-buffer ()
  "Switch to last visited buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-x x") 'last-visited-buffer)

;; search-all-buffers-ignored-files, F9 to call this function
(defcustom search-all-buffers-ignored-files (list (rx-to-string '(and bos (or ".bash_history" "TAGS") eos)))
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
(global-set-key [f9] 'search-all-buffers)

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
(global-set-key [f11] 'stick-buffer)

;; Generate unique buffer names if you open many files with same basename
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
;; rename after killing uniquified
(setq uniquify-after-kill-buffer-p t)
;; don't muck with special buffers
(setq uniquify-ignore-buffers-re "^\\*")

;; highlight buffer modifications
;; you can also(before saving):
;; 1. M-x diff-buffer-with-file
;; 2. After C-x C-c, type d to differ
(global-set-key (kbd "C-h C-b") 'diff-buffer-with-file)
(global-set-key (kbd "C-h C-v") 'highlight-changes-visible-mode)
(global-highlight-changes-mode t)
;; initial invisible, use C-h C-v to toggle the highlight of changes
(setq highlight-changes-visibility-initial-state nil)
(global-set-key (kbd "C-c C-p") 'highlight-changes-previous-change)
(global-set-key (kbd "C-c C-n") 'highlight-changes-next-change)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; line issues
;;;;;;;;;;;;;;;;;;;;;;;;;
;; what should be done when you ask Emacs to take you to the next
;; line and you already are located at the last line of the buffer
;; t means inserting a new line(t is the default option)
;; nil means ringing the bell
(setq next-line-add-newlines nil)

(defun advanced-return (&optional arg)
  "Customized return, more powerful.

Default(without prefix), create a line, jump into it and indent(like C-e C-m)
With prefix argument(C-u), it will create a new line, jump into it but no indent(like C-e C-o C-n).
With negative prefix argument(C--), it will create a new line above the current
line and jump into it(like C-a C-o)

NOTE: Use C/M-j instead to split the line and indent/no-indent."
  (interactive "P")
  (if (equal arg '-)
	  (progn
		(beginning-of-line)
		(open-line 1))
	(if (equal arg '(4))
		(progn
		  (end-of-line)
		  (open-line 1)
		  (next-line))
	  (progn
		(end-of-line)
		(newline-and-indent)
	  ))))
(global-set-key (kbd "RET") 'advanced-return)

(setq byte-compile-warnings nil)
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
;; disable C-z(suspend-frame) , and you can use C-z for others
(define-key global-map [(control z)] nil)
;; color
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;
;; there are shell and eshell
(global-set-key (kbd "C-x s") 'shell)
;; shell will prompt if you try to kill the buffer, but eshell will not.  eshell
;; will not use the .bashrc/.fishrc, but shell will makes shell command always
;; start a new shell, use C-u M-x eshell to create a new eshell,
(defadvice shell (around always-new-shell)
  "Always start a new shell."
  (let ((buffer
		 (generate-new-buffer-name "*shell*")))
	ad-do-it))
;; make shell in emacs load .bashrc/.fishrc
(setq shell-command-switch "-lc")
(ad-activate 'shell)

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
(global-set-key (kbd "C-x C-j") 'dired-jump)
;; byte-comple and load *.el using "C-x c"
(define-key emacs-lisp-mode-map (kbd "C-x c") 'emacs-lisp-byte-compile-and-load)
(define-key emacs-lisp-mode-map (kbd "C-c c") 'eval-buffer)
(define-key lisp-mode-map (kbd "C-c c") 'eval-buffer)

(defalias 'bd 'byte-recompile-directory)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; Window
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; resize the opened windows
;; firstly disable some shortkeys in org-mode
;; the following shortkeys are in shift-selection, org-support-shift-select
(add-hook 'org-mode-hook
		  (lambda ()
			(define-key org-mode-map [(control shift left)] nil)
			(define-key org-mode-map [(control shift right)] nil)
			(define-key org-mode-map [(control shift up)] nil)
			(define-key org-mode-map [(control shift down)] nil)
			))
(global-set-key (kbd "S-C-<left>")	'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>")	'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")	'shrink-window)
(global-set-key (kbd "S-C-<up>")	'enlarge-window)
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
(global-set-key (kbd "C-x z") 'toggle-maximize-buffer)
(global-set-key (kbd "C-x C-z") 'toggle-maximize-other-buffer)

;; Try C-x 4 C-h for C-x 4 info
;; change the default action of C-x 2/3
;; switch to the new window immediately after creating
(defun my-split-window-below ()
  (interactive)
  (let ((win (split-window-below)))
	(set-frame-selected-window (selected-frame) win)))
(defun my-split-window-right ()
  (interactive)
  (let ((win (split-window-right)))
	(set-frame-selected-window (selected-frame) win)))
(global-set-key (kbd "C-x 2") 'my-split-window-below)
(global-set-key (kbd "C-x 3") 'my-split-window-right)
;; new window to vertically by default
;; (setq split-height-threshold nil)
;; (setq split-width-threshold 0)
;; Automatically split window vertically if current window is wide enough
(defun display-new-buffer (buffer force-other-window)
  "If BUFFER is visible, select it.
If it's not visible and there's only one window, split the
current window and select BUFFER in the new window. If the
current window (before the split) is more than 100 columns wide,
split horizontally(left/right), else split vertically(up/down).
If the current buffer contains more than one window, select
BUFFER in the least recently used window.
This function returns the window which holds BUFFER.
FORCE-OTHER-WINDOW is ignored."
  (or (get-buffer-window buffer)
	  (if (one-window-p)
		  (let ((new-win
				 (if (> (window-width) 100)
					 (split-window-horizontally)
				   (split-window-vertically))))
			(set-window-buffer new-win buffer)
			new-win)
		(let ((new-win (get-lru-window)))
		  (set-window-buffer new-win buffer)
		  new-win))))
;; use display-buffer-alist instead of display-buffer-function if you cannot
;; create a new buffer such as using just M-x
(setq display-buffer-function 'display-new-buffer)
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
(define-key ctl-x-4-map "t" 'toggle-window-split)

;; ediff split horizontal, default is vertically
(eval-after-load "ediff"
  '(progn
	 (setq ediff-split-window-function
		   'split-window-horizontally)
	 (setq ediff-window-setup-function
		   'ediff-setup-windows-plain)
	 ;; delete these buffers (if they are not modified) after q
	 (setq ediff-keep-variants nil)
	 ))

;; You can use C-x o 'other-window, but the following is better
;; move your point to another window in the specific direction
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)

;;
;; revert buffer without confirmation
(global-auto-revert-mode 1)
(defun rev()
  (interactive)
  (revert-buffer nil t))
(global-set-key (kbd "C-c r") 'rev)
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
(defun reopen-killed-buffer ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (when killed-buffers-list
    (find-file (pop killed-buffers-list))))
(global-set-key (kbd "C-S-t") 'reopen-killed-buffer)

;;
;; set M-x align-regexp to C-c a
(global-set-key (kbd "C-c a") 'align-regexp)

;; put cursor at the #include line, C-c o open the header file
;; c-mode-common-hook equals to c-mode-hook + c++-mode-hook
(add-hook 'c-mode-common-hook
		  (lambda()
			(local-set-key	(kbd "C-c o") 'ff-find-other-file)))

;; alias
(defalias 'man 'woman)
(defalias 'eit 'emacs-init-time)

;; Saveplace & desktop
(setq-default save-place t)
(require 'saveplace)
(setq save-place-file "~/.emacs.d/saved-places")
;;
(setq desktop-save 'ask)
;;desktop-save ask means always ask
(desktop-save-mode nil)

;; show the possible errors in C/C++ source codes(cwarn mode)
(global-cwarn-mode 1)

;; spell check
(require 'ispell)
(defalias 'ib 'ispell-buffer)
;; spell check engine
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))
(add-hook 'org-mode-hook 'flyspell-mode)
;; if you don't know how to spell the rest of a word
(global-set-key (kbd "C-?") 'ispell-complete-word)
;; flyspell-prog-mode is to spell check in the comments and string constants
(dolist (mode '(prog-mode-hook
				;; emacs-lisp-mode-hook
				;; python-mode-hook
				;; ielm-mode-hook
				))
  (add-hook mode
			'(lambda ()
			   (flyspell-prog-mode))))
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
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)
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
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; nil-->use spaces instead of tabs, t -- don't replace
(require 'cc-vars)
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
;; (setq indent-line-function 'insert-tab)
(add-hook 'text-mode-hook
		  (lambda ()
			(setq indent-tabs-mode t)
			(setq tab-width 4)))
(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(setq tab-width 4)))
(add-hook 'python-mode-hook
		  (lambda ()
			(setq indent-tabs-mode nil)
			(setq tab-width 4)
			))
;;
(add-hook 'c-mode-common-hook
		  (lambda ()
			(c-set-style "linux")
			(setq tab-width 8)
			(setq indent-tabs-mode t) ;;default in linux kernel
			(setq c-basic-offset 8)))

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
;;
;; auto insert the other half of parentheses
(defun my-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist '(
							  (?\" _ "\"")
							  (?\( _ ")")
							  (?\[ _ "]")
							  (?\{ _ "}")
							  (?` _ "'")))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  )
(dolist (hook '(prog-mode-hook python-mode-hook ielm-mode-hook org-mode-hook))
  (add-hook hook 'my-mode-auto-pair))

;;
;; automatically insert new line with } and indent when typing {
(define-minor-mode c-helpers-minor-mode
  "This mode contains little helpers for C developement" nil ""
  '(((kbd "{") . insert-c-block-parentheses)))
(defun insert-c-block-parentheses ()
  (interactive)
  (insert "{")
  (newline)
  (newline)
  (insert "}")
  (indent-for-tab-command)
  (call-interactively 'previous-line)
  (indent-for-tab-command))
(dolist (mode '(c-mode-common-hook jave-mode-hook cperl-mode-hook))
  (add-hook mode
			'(lambda ()
			   (c-helpers-minor-mode))))

;;
;; automatically insert } after typing {, not indent
;; When you need this, type C-{, in some modes
(defun insert-c-block-parentheses-without-indent ()
  (interactive)
  (insert "{")
  (insert "}")
  (call-interactively 'left-char))
(define-key c-mode-map (kbd "C-{") 'insert-c-block-parentheses-without-indent)
(define-key c++-mode-map (kbd "C-{") 'insert-c-block-parentheses-without-indent)
(define-key java-mode-map (kbd "C-{") 'insert-c-block-parentheses-without-indent)
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
  '(define-key cperl-mode-map (kbd "C-{") 'insert-c-block-parentheses-without-indent)
	 )

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
	(compilation-minor-mode)
	))
(global-set-key (kbd "C-c v") 'va)

;; cedet -- built-in
;; more detail: http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
;; and: http://www.logilab.org/blogentry/173886
;; the following add-to-list should be put before (semantic-mode 1)
(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
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
(define-key prog-mode-map "." 'semantic-complete-self-insert)
;;
(add-hook 'org-mode-hook
		  (lambda() (set
					 (make-local-variable 'semantic-mode) nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;    plugin in .emacs.d/plugin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages from  elpa, marmelade and melpa.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'package "package" t)
;; Package repositories
(setq package-archives
	  '(
		("gnu" . "http://elpa.gnu.org/packages/")
		("ELPA" . "http://tromey.com/elpa/")
		("melpa" . "http://melpa.org/packages/")
		("marmalade" . "http://marmalade-repo.org/packages/")
		("melpa-stable1" . "http://stable.melpa.org/packages/")
		("melpa-stable2" . "http://hiddencameras.milkbox.net/packages/")
		))
;;
(defun eval-url (url)
  (let ((buffer (url-retrieve-synchronously url)))
	(save-excursion
	  (set-buffer buffer)
	  (goto-char (point-min))
	  (re-search-forward "^$" nil 'move)
	  (eval-region (point) (point-max))
	  (kill-buffer (current-buffer)))))
(defalias 'pi 'package-install)
(defalias 'pmm 'package-menu-mode)
(defalias 'plp 'package-list-packages)
;; Update the packages automatically
;;(when (not package-archive-contents) (package-refresh-contents))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; plugin installed by M-x package-install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; dropdown-list required by yasnippet (optional)
;; yasnippet
;; C-c & C-v('yas-visit-snippet-file) to edit a snippet in current mode
;; C-c C-c('yas-load-snippet-buffer) to reload it
;; C-c & C-n('yas-new-snippet) to create a new one for current mode
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
(global-set-key (kbd "C-c y") 'yas-reload-all)

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
(global-set-key (kbd "C-@") 'hippie-expand-dabbrev-limited-chars)
;; (global-set-key (kbd "M-/") 'hippie-expand-file-name) ;; from hippie-exp-ext
(global-set-key (kbd "M-/") 'hippie-expand)
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
		try-complete-lisp-symbol))

;; multiple-cursors
;; How to add string at the beginning of multiple lines
;; 1. mark M-x replace-regexp ^ RET string RET
;; 2. mark C-x r t string
;; watch the emacs-rocks-13-multiple-cursors.mov video
(autoload 'multiple-cursors "multiple-cursors" t)
;; When you have an active region that spans multiple lines, the following will
;; add a cursor to each line
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; When you want to add multiple cursors not based on continuous lines, but
;; based on keywords in the buffer, first mark the word, then add more cursors:
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(define-key global-map (kbd "C-c j") 'ace-jump-mode)
(define-key global-map (kbd "C-c J") 'ace-jump-char-mode)
(define-key global-map (kbd "C-c l") 'ace-jump-line-mode)

;;
;; dash required by ace-jump-buffer
(autoload 'dash "dash" t)
;; ace-jump-buffer, requires dash and ace-jump-mode
(autoload 'ace-jump-buffer "ace-jump-buffer" t)
;; C-x C-b default to 'list-buffers
(define-key global-map (kbd "C-x C-b") nil)
(global-set-key (kbd "C-x C-b") 'ace-jump-buffer)

;; sml-mode requird by expand-region
(autoload 'sml-mode "sml-mode" t)
;;
;; expand-region
(autoload 'expand-region "expand-region" t)
(global-set-key (kbd "C-=") 'er/expand-region)
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
;; `change-inner {` would kill the return-statement
;; `change-outer {` would kill the entire block（including {）
;; Giving these commands a prefix argument `C-u` means copy instead of kill.
(autoload 'change-inner "change-inner" t)
(global-set-key (kbd "M-i") 'change-inner)
(global-set-key (kbd "M-o") 'change-outer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;	 company-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'company "company" t)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-global-modes t)
(setq company-tooltip-limit 30)
(setq company-minimum-prefix-length 3)
(setq company-show-numbers t)
(setq company-dabbrev-other-buffers t)
(setq company-transformers '(company-sort-by-occurrence))
(setq company-auto-complete t)
;; use F1 or C-h in the drop list to show the doc, Use C-s/C-M-s to search the candidates,
;; M-NUM to select specific one, C-w to view its source file
(global-set-key (kbd "C-c <tab>") 'company-files)
;; this will show a lot of garbage, use it only necessary
;; (add-to-list 'company-backends 'company-ispell)
(defalias 'ci 'company-ispell)
(add-hook 'org-mode-hook
		  (lambda ()
			(company-mode)
			(set (make-local-variable 'company-backends)
				 '((
					company-dabbrev
					company-dabbrev-code
					company-ispell
					company-files
					company-yasnippet
					))
				 )))
(add-hook 'c-mode-common-hook
		  (lambda()
			(company-mode)
			(set (make-local-variable 'company-backends)
				 '((
					company-c-headers
					company-clang
					company-dabbrev
					company-dabbrev-code
					company-gtags
					company-semantic
					company-yasnippet
					company-keywords
					))
				 )))
(add-hook 'emacs-lisp-mode-hook
		  (lambda()
			(company-mode)
			(set (make-local-variable 'company-backends)
				 '((
					company-elisp
					company-dabbrev
					company-dabbrev-code
					company-semantic
					company-yasnippet
					))
				 )))
;; grouped back-ends
;; (add-to-list 'company-backends
;;				'(
;;				  (
;;				  company-clang
;;				  company-gtags
;;				  company-elisp
;;				  company-semantic
;;				  company-dabbrev
;;				  company-dabbrev-code
;;				  company-c-headers
;;				  company-keywords)
;;				  ;; company-yasnippet
;;				  company-bbdb
;;				  company-nxml
;;				  company-css
;;				  company-eclim
;;				  company-xcode
;;				  company-ropemacs
;;				  company-cmake
;;				  company-capf
;;				  company-etags
;;				  company-oddmuse
;;				  company-files))


;; undo-tree, C-_-> undo, M-+ -> redo, C-x u -> undo-tree-visualize
;; more infomation please check the doc
;; C-S-/(C-?) is used in undo-tree plugin by default
;; But the author set two different keys for 'undo-tree-redo/undo
;; I only use M-_, comment out the two lines of file undo-tree.el
;; (define-key map (kbd "C-/") 'undo-tree-undo)
;; (define-key map (kbd "C-?") 'undo-tree-redo)
;;(require 'undo-tree)
;; replace the standard undo system
(global-undo-tree-mode)
(defadvice undo-tree-visualizer-mode (after undo-tree-face activate)
  (buffer-face-mode)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-diff t))

;; findr
(autoload 'findr "findr" "Find file name." t)
(define-key global-map [(meta control S)] 'findr)
(autoload 'findr-search "findr" "Find text in files." t)
(define-key global-map [(meta control s)] 'findr-search)
(autoload 'findr-query-replace "findr" "Replace text in files." t)
(define-key global-map [(meta control r)] 'findr-query-replace)

;; iy-go-to-char better work with multiple-cursors
(autoload 'iy-go-to-char "iy-go-to-char" t)
(global-set-key (kbd "C-c f") 'iy-go-to-char)
(global-set-key (kbd "C-c F") 'iy-go-to-char-backward)
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
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; markdown-mode+
(autoload 'markdown-mode+ "markdown-mode+" t)

;; xcscope -- requird by ascope

;; ascope
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
			(cscope-minor-mode)
			))

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
;; ;; The following two set-key has the side affect that
;; ;; you can not use the semantic-mode prefix
;; ;; and ede-minor-mode prefix in C/C++ mode
;; ;; or you can use C-c , to set the TODO priority
;; (define-key semantic-mode-map "\C-c," 'org-priority)
;; ;; or you have to M-x org-mode to use (C-u)C-c . org-time-stamp
(define-key ede-minor-mode-map "\C-c." 'org-time-stamp)
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
(setq org-completion-use-ido t)
(define-key org-mode-map (kbd "C-c a") 'org-agenda)
(define-key org-mode-map (kbd "C-c c") 'org-capture)
;; show/unshow the descriptive and literal links
(define-key org-mode-map (kbd "C-c C-x l") 'org-toggle-link-display)
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
(add-to-list 'auto-mode-alist '("README$" . org-mode))
;; TODO
;; different sequential states in the process of working on an item
;; C-c C-t SPC for nothing
(setq org-todo-keywords
	  '((sequence "TODO(t)" "READ(r)" "|" "DONE(d)")
		;; multiple sets for one file
		;; (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)""|" "FIXED(f)")
		;; (sequence "|" "CANCELED(c)")
		))
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
  (let (org-log-done org-log-states)   ; turn off logging
	(org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
;; syntax highlight in the source code snippet
(setq org-src-fontify-natively t)
;; TAB to indent the _whole_(not lines) code snippet block comparing with "#+BEGIN_SRC" part
(setq org-src-tab-acts-natively t)
(add-hook 'org-mode-hook
		  (lambda ()
			;; in code snippet block, `C-c '` and then TAB to format code snippet lines
			;; display one lone line in one window, get rid of straight right arrow
			(setq truncate-lines nil)
			;; DO NOT end a org file with a newline, default is t(with newline)
			(setq require-final-newline nil)
			))
;; disable '_' to subscript or '^' to superscript export
(setq org-export-with-sub-superscripts nil)
;;;;;;;;;;;;;;;
;; org-plus-contrib

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
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(helm-mode 1)
;; view the content of the both the local and global mark rings in a friendly interface,
;; use C-h SPC to jump back to where you were, like the 'ggtags-view-tag-history
(global-set-key (kbd "C-h C-SPC") 'helm-all-mark-rings)
;; helm-apropos describes commands, functions, variables and faces - all in one command!
(global-set-key (kbd "C-h o") 'helm-apropos)
(global-set-key (kbd "<f1>-o") 'helm-apropos)
;; in dired(you have to go to the dir first), helm-find is like find in terminal,
;; helm-locate is like locate in terminal, to use local database with prefix argument C-u
;;
;; helm-for-files
;; list buffers, recentf, bookmarks, files in current dir and even in *locate* after typing
;; but it won't create a new file/buffer/bookmark if it doesn't exist in emacs/disk
(global-set-key (kbd "C-x C-p") 'helm-for-files)
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
(global-set-key (kbd "C-x b") 'helm-mini)
;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
;; (recentf-mode t)
(setq
 ;; recentf-save-file
 ;; (concat user-emacs-directory "recentf")
 recentf-max-saved-items 100
 ;; recentf-max-menu-items 15
 )
;;
;; C-s(helm-ff-run-grep) after C-x C-f to search a file/directory on highlighted...,
;; With prefix argument, recursively grep a selected directory. )
;; In sessions such as helm-find-files or helm-mini, you can use C-SPC to
;; select more than one candidates and execute actions on them, such as grep or open.
;; helm-find-files will prompt y/n if the file doesn't exist, find-file won't
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-occur)
;; Use C-S-s to search other-window, when this is used in more than 3 windows,
;; it would be confused by 'other-window
(defun helm-other-occur ()
  (interactive)
  (save-selected-window
	(other-window 1)
	(helm-occur)))
(global-set-key (kbd "C-S-s") 'helm-other-occur)
(global-set-key (kbd "M-x") 'helm-M-x)
;; M-y cycles the kill ring
(global-set-key (kbd "C-x y") 'helm-show-kill-ring)
(global-set-key (kbd "C-/") 'helm-semantic-or-imenu)
(global-set-key (kbd "C-c x") 'helm-resume)
(setq
 ;; helm-quick-update t  ; do not display invisible candidates
 helm-split-window-default-side 'other ; open helm buffer in another window
 helm-split-window-in-side-p t ; open helm buffer inside current window, not occupy whole other window
 helm-buffers-favorite-modes
 (append helm-buffers-favorite-modes
		 '(picture-mode artist-mode)) ; do not show these files in helm buffer
 helm-boring-file-regexp-list
 '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "\\.i$")
 ;; move to end or beginning of source when reaching top or bottom of source.
 ;; helm-move-to-line-cycle-in-source t
 ;; fuzzy matching buffer names when non--nil, useful in helm-mini that lists buffers
 helm-buffers-fuzzy-matching t
 )
;; Save current position to mark ring when jumping to a different place
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)
(defalias 'hg 'helm-do-grep)
;;
;; helm-descbinds, describe-bindings using helm, F1-b or C-h b
(add-hook 'after-init-hook 'helm-descbinds-mode)

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
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

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
(global-set-key (kbd "C-x g") 'magit-status)
(eval-after-load "magit"
  '(mapc (apply-partially 'add-to-list 'magit-repo-dirs)
		 '(
		   "~/.emacs.d"
		   "~/.vim"
		   )))
;; open a link not prompt yes/no
(setq vc-follow-symlinks 'nil)
;; make vc* and magit work for link
(setq find-file-visit-truename t)
(set-default 'magit-stage-all-confirm nil)
(set-default 'magit-unstage-all-confirm nil)
;; make git faster??
(eval-after-load "magit" '(setq magit-git-executable "/usr/bin/git"))
;; make `truncate-lines` nil in magit and `auto-fill-mode` off in commit buffers
(add-hook 'magit-status-mode-hook
		  (lambda ()
			(setq truncate-lines nil)))
(add-hook 'git-commit-mode-hook
		  (lambda ()
			(turn-off-auto-fill)
			(flyspell-mode)))
;; make the item in magit buffer easy to see after TAB
(defadvice magit-toggle-section (after magit-toggle-top activate)
  "TAB a item to scroll the of the repeat."
  (recenter-top-bottom 0))

;; ;; evil, use C-z to switch between vim/Emacs
;; (setq evil-search-module 'evil-search
;;		 evil-want-C-u-scroll t
;;		 evil-want-C-w-in-emacs-state t)
;; (require 'evil)
;; (evil-mode t)

;; sublimity--smooth-scrolling, minimap and distraction-free mode
;; the configuration for touchpad in this file is still in use
(require 'sublimity)
(require 'sublimity-scroll)
;; the speed of smooth-scroll
(setq sublimity-scroll-weight 5
	  sublimity-scroll-drift-length 10)
(sublimity-mode 1)
;; scroll smoothly using touchpad better along with sublimity-mode
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; emmet for web development
(autoload 'emmet-mode "emmet for web development" t)
(dolist (mode '(sgml-mode-hook html-mode-hook css-mode-hook))
  (add-hook mode
			'(lambda ()
			   (emmet-mode))))

;; lua-mode, default 3 spaces indent, lua-indent-level in lua-mode.el
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
(setq lua-indent-level 4)

;; hide-comments
(autoload 'hide-comnt "hide comments" t)
(defalias 'hc 'hide/show-comments-toggle)

;; discover -- required by yafolding
(require 'discover)
(global-discover-mode 1)

;; yafolding
;; C-M-return 'yafolding-toggle-all
;; C-return 'yafolding-toggle-element
(autoload 'yafolding "yafolding" t)
(add-hook 'python-mode-hook 'yafolding-mode)
(add-hook 'prog-mode-hook 'yafolding-mode)

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
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)
(global-set-key (kbd "M-'") 'highlight-symbol-query-replace)
;;
;; highlight-parentheses-mode, highlight nested parens, brackets, braces at each
;; depth, use hl-sexp-mode to replace if you like
(add-hook 'prog-mode-hook 'highlight-parentheses-mode)
;;
;; rainbow-delimiters
;; rainbow nested parens, brackets, braces a different color at each depth
;;  like highlight-parentheses-mode but static
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; make the outermost delimiters not red but white, not bold but normal
(custom-set-faces
 '(rainbow-delimiters-depth-1-face
   ((t (:foreground "white" :weight normal)))))
;;
;; rainbow-identifiers
;; rainbow identifiers according to their names
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

;; makey required by discover-my-major and discover

;; discover-my-major
;; Discover key bindings and meaning for the current Emacs major mode
;; C-h C-m or C-h RET 'discover-my-major
(global-set-key (kbd "C-h C-m") 'discover-my-major)

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
		  (lambda() (set
					 (make-local-variable 'drag-stuff-mode) nil)))
;; gnus
;; bbdb, w3m installed for gnus, check the
;; ~/.gnus(~/.emacs.d/init-gnus.el) for more info
(require 'init-gnus)

;; rebox2 to replace comment-box
(require 'rebox2)
;; default style
;; (setq rebox-style-loop '(11 15 111))
(setq rebox-min-fill-column 40)
;; no need to format, directly to comment
(global-set-key (kbd "M-r") 'rebox-cycle)
;; rebox-dwim to fill first
(global-set-key (kbd "M-S-r") 'rebox-dwim)
;; you can change the style in the box(no mark needed) to such as 126
;; using M-126 M-q, but only from the original to 126, not 126 to another again
(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(set (make-local-variable 'rebox-style-loop) '(21 25 111))
			(rebox-mode 1)
			))
(add-hook 'c-mode-hook
		  (lambda ()
			(set (make-local-variable 'rebox-style-loop) '(243 241 111))
			(rebox-mode 1)
			))
(add-hook 'c++-mode-hook
		  (lambda ()
			(set (make-local-variable 'rebox-style-loop) '(25 21 111))
			(rebox-mode 1)
			))
(add-hook 'text-mode-hook
		  (lambda ()
			(set (make-local-variable 'rebox-style-loop) '(113 123 111))
			;; (rebox-mode 1)
			))
(define-key rebox-mode-map [(control y)] nil)
(define-key rebox-mode-map [(shift return )] nil)
(define-key rebox-mode-map (kbd "M-w") nil)

;; comment-dwim-2 to replace default comment-dwim
;; comment-dwim can also be repeated several times to switch between the
;; different behaviors.
;; repeating comment-dwim-2 will by default reindent the comment instead of
;; killing it, and that calling with a prefix argument will kill the comment
;; instead of reindenting it.
(global-set-key (kbd "M-;") 'comment-dwim-2)
(setq comment-dwim-2--inline-comment-behavior 'reindent-comment)

;; projectile required by helm-projectile

;; helm-projectile
;; http://tuhdo.github.io/helm-projectile.html
;; all projectile & helm-projectile commands has prefix C-c p
(require 'helm-projectile)
(projectile-global-mode)
;;(helm-projectile-on)
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
(setq projectile-switch-project-action
	  'helm-projectile-find-file)
;;(setq projectile-switch-project-action
;;    'helm-projectile)
;; modify the indicator in mode line
(setq projectile-mode-line
	  '(:eval (format " Pt[%s]" (projectile-project-name))))

;; whole-line-or-region
(add-hook 'after-init-hook 'whole-line-or-region-mode)

;; popwin is required by guide-key

;; guide-key
;;(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-h" "<f1>" "C-s"))
(setq guide-key/recursive-key-sequence-flag t)
;; highlights and color of highlights
(setq guide-key/highlight-command-regexp
      '(("^helm-" . warning)
        ("^projectile-" . error)
		("^cscope-" . success)
		("^ggtags-" . success)
		("emacs" . highlight)
		("help" . highlight)
		("toggle" . link)
		("rectangle" . link)
		("register" . link)
		))
;; font size of guide buffer
(setq guide-key/text-scale-amount -0.5)
(setq guide-key/popup-window-position 'bottom)
(guide-key-mode 1)

;; noflet, iedit required by lispy

;; lispy -- amazing mode for Elisp, Clojure, Scheme and Common Lisp
;; http://abo-abo.github.io/lispy/
(add-hook 'prog-mode-hook (lambda () (lispy-mode 1)))
(eval-after-load "lispy"
  '(progn
	 (define-key lispy-mode-map (kbd "RET") nil)
	 (define-key lispy-mode-map (kbd "C-e") nil)
	 ))
(defadvice lispy-kill (around lispy-kill-advice activate)
  "Disable lispy C-k in comments"
  (if (lispy--in-comment-p)
      (delete-line (prefix-numeric-value current-prefix-arg))
    ad-do-it))

;; esup -- analyze the startup time of ~/.emacs
;; M-x esup
;;
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
	(auto-complete-mode . "")
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
;;; alias the new `flymake-report-status-slim' to
;;; `flymake-report-status'
(defalias 'flymake-report-status 'flymake-report-status-slim)
;; (defun flymake-report-status-slim (e-w &optional status)
;; "Show \"slim\" flymake status in mode line."
;; (when e-w
;; (setq flymake-mode-line-e-w e-w))
;; (when status
;; (setq flymake-mode-line-status status))
;; (let* ((mode-line " Φ"))
;; (when (> (length flymake-mode-line-e-w) 0)
;; (setq mode-line (concat mode-line ":" flymake-mode-line-e-w)))
;; (setq mode-line (concat mode-line flymake-mode-line-status))
;; (setq flymake-mode-line mode-line)
;; (force-mode-line-update)))
