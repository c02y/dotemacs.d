;; .emacs

;; byte compile emacs lisp files of current dir
;; emacs -batch -f batch-byte-compile *.el
;; I just found that you can just use the MENU
;; (the one between the Right-Alt and Right-Ctrl key) key
;; to replace M-x
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
;; (kbd "C-x C-b")
;; (kbd "RET")
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
;; C-v to next page
;; C-x C-x remakr the region
;; M-v to previous page
;; M-g g to 'goto-line
;; C-S-m for 'menu-bar-mode
;; Enter or C-j to 'newline-and-indent
;; C-c e to 'show-ws-toggle-show-trailing-whitespace
;; F5 or C-S-Backsapce to 'cut-line-or-region
;; F6 to 'copy-line-or-region
;; F7 to 'switch-to-minibuffer-window
;; F8 to make the frame transparent
;; F9 to 'search-all-buffers
;; C-c r to 'rev('revert-buffer)
;; C-x s to 'sh('shell)
;; C-x C-r to 'recentf-open-files
;; C-return to C-e C-m(open and jump to a blank line above the current line)
;; M-return to C-a C-m C-p(open and jump to a blank beneath the current line)
;; C-k to 'kill-line to the end of the line
;; M-k to 'kill-line to the beginning of the line
;; C-x <up> to 'previous-multiframe-window
;; C-x <down> to 'next-multiframe-window
;; C-x C-b to 'ibuffer-other-window
;; C-x b to switch buffers in minibuffer
;; S-C-<left> to 'shrink-window-horizontally
;; S-C-<right> to 'enlarge-window-horizontally
;; S-C-<down> to 'shrink-window
;; S-C-<up> to 'enlarge-window
;; C-x c to 'emacs-lisp-byte-compile-and-load
;; C-c d to 'delete-trailing-whitespace
;; C-M-; to 'comment-or-uncomment-region-or-line
;; C-x C-j to 'dired-jump
;; C-c y to 'yas-reload-all
;; C-c a to 'align-regexp, set it not working
;; C-M-S to 'findr
;; C-M-s to 'findr-search
;; C-M-r to 'findr-query-replace
;; C-x C-<left> 'previous-buffer
;; C-x C-<right> 'next-buffer
;; C-M-n/p Move forward/backward over a parenthetical group
;; C-M-u/d Move up/down in parenthesis structure
;; M-$ -> i -> y to insert the string into personal dictionary
;; 		 the personal dictionary asides in ~/.hunspell_en_US
;; 		 file has already been linked to .emacs.d/
;; in the comment, if you want to insert another comment line, use M-j
;; M-m 'back-to-indentation move point to first non-whitespace character
;; M-x find-library will lead you to the right .el file

;; Windows style line endings (DOS support)
;; C-x RET f undecided-dos RET     --> \r\n (windows)
;; C-x RET f undecided-unix RET    --> \n  (unix/Linux)
;; M-x tabify/untabify convert from spaces to tabs and vice versa

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
(add-hook 'emacs-lisp-mode-hook '(lambda ()
                                   (add-hook 'after-save-hook 'emacs-lisp-byte-compile t t)))
;; Delete the existed/no-existed .emacs.elc and recompile and reload
(defun byte-compile-init-file ()
  (when (equal user-init-file buffer-file-name)
    (when (file-exists-p (concat user-init-file ".elc"))
      (delete-file (concat user-init-file ".elc")))
    (emacs-lisp-byte-compile-and-load)))
(add-hook 'after-save-hook 'byte-compile-init-file)
;; ;; combining the above two version:: WRONG
;; (defun byte-compile-and-reload-elisp ()
;;   (interactive)
;;   (when (and (eq major-mode 'emacs-lisp-mode)
;;              (when (file-exists-p (byte-compile-dest-file buffer-file-name))
;;                (delete-file (concat buffer-file-name ".elc")))
;;              (emacs-lisp-byte-compile-and-load))))
;; (add-hook 'after-save-hook 'byte-compile-and-reload-elisp)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Emacs Face Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(setq bookmark-save-flag t)
(add-hook 'text-mode-hook 'auto-fill-mode)
(global-linum-mode 1)
(setq column-number-mode t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(global-set-key (kbd "C-S-m") 'menu-bar-mode)
;; line space between lines, default to 0
;; (setq line-spacing 2)
;;
;; display time in modeline
(display-time-mode 1)
(defvar display-time-24hr-format)
(setq display-time-day-and-date t)
(display-time)
;; display buffer name or absolute file path name in the frame tittle
;; NOTE: you should comment the last line of
;; /usr/share/emacs/site-lisp/default.el, or this setting won't work
(setq frame-title-format "%b@%f")
;;
;; syntax highlight
(global-font-lock-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;   theme & font
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; theme
;;
;; Enabling a light theme temporarily, use M-x load-theme <TAB> flatui
;; if you want to enable it after start up, add the two lines like below
;;
;; the following will get rid of prompt when M-x load-theme, treat all
;; themes as safe
(setq custom-safe-themes t)
;; afternoon
(require 'afternoon-theme)
;; ;; molokai
;; (load-theme 'molokai t)
;; (require 'molokai-theme)
;;
;; font and size of startup
;;
;; set the default window size at startup according to the resolutions
;; (setq default-frame-alist '((height . 37) (width . 80)))
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
        ;; use 120 char wide window for largeish displays
        ;; and smaller 80 column windows for smaller displays
        ;; pick whatever numbers make sense for you
        (if (> (x-display-pixel-width) 1500)
            ;; (add-to-list 'default-frame-alist (cons 'width 85))
            ;; (add-to-list 'default-frame-alist (cons 'width 85)))
            (setq default-frame-alist
                  '((top . 0)(left . 0)
                    (width . 85)(height . 48)
                    (font . "Menlo-13")));; Monaco, Consolas

          (setq default-frame-alist
                '((top . 0)(left . 0)
                  (width . 85)(height . 38)
                  (font . "Menlo-12")
                  )))
        )))
;; (if (> (x-display-pixel-height) 1000)
;;        (add-to-list 'default-frame-alist (cons 'height 48))
;;        (add-to-list 'default-frame-alist (cons 'height 37)))
;; )))
;; for the height, subtract a couple hundred pixels
;; from the screen height (for panels, menubars and
;; whatnot), then divide by the height of a char to
;; get the height we want
;; (add-to-list 'default-frame-alist
;;      (cons 'height (/ (- (x-display-pixel-height) 200)
;;                          (frame-char-height)))))))
(set-frame-size-according-to-resolution)

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

;; sroll smoothly using touchpad
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; set the query-replace from top
(defun query-replace-from-top ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (call-interactively 'query-replace)))
(global-set-key (kbd "M-%") 'query-replace-from-top)

;; sudo to edit
;; kill *tramp* buffer to exit the root mode
(defun sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))
(global-set-key (kbd "C-c C-f") 'sudo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;  defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; flush blank lines
;;
(defun flush-blank-lines (start end)
  (interactive "r")
  (flush-lines "^\\s-*$" start end nil))

;; move line up
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (previous-line 2))
;; move line down
(defun move-line-down ()
  (interactive)
  (next-line 1)
  (transpose-lines 1)
  (previous-line 1))
(global-set-key [(meta up)] 'move-line-up)
(global-set-key [(meta down)] 'move-line-down)

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

;; Display trailing whitespace at en of lines
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
(setq-default show-trailing-whitespace nil)
(global-set-key "\C-ce" 'show-ws-toggle-show-trailing-whitespace)
;; delete-trailing-whitespace using C-c d
(global-set-key (kbd "C-c d") 'delete-trailing-whitespace)
;; M-^ delete Up to Non-Whitespace Character, 'delete-indentation
;; C-Backspace delete to the previous non-whitespace char
;; M-Backspace delete to the previous word 'backword-kill-word
(global-set-key (kbd "C-<backspace>") 'fixup-whitespace)

(global-set-key (kbd "C-S-k") 'kill-this-buffer)

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
;;
;; move cursor between minibuffer and buffers using F7
(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-window (active-minibuffer-window))))
(global-set-key (kbd "<f7>") 'switch-to-minibuffer-window)
;; 'ibuffer-list-buffers's shortkey is replace by 'ace-jump-buffer
;; use M-x il to operate the buffers
(defalias 'il 'ibuffer-list-buffers)
;; improve the profermance of the minibuffer
(setq echo-keystrokes 0.001)
;; use minibuffer recursively, don't know what does it mean
(setq enable-recursive-minibuffers t)
;;
;; dired-x.el built-in
;; You use F to open all the marked files now
(add-hook 'dired-load-hook
          (lambda () (load "dired-x")))
;; 'find-name-dired find all the files in the dir recursively
;; default to 'set-fill-column
(global-set-key (kbd "C-x f") 'find-name-dired)

;; search-all-buffers-ignored-files, F9 to call this function
(defcustom search-all-buffers-ignored-files (list (rx-to-string '(and bos (or ".bash_history" "TAGS") eos)))
  "Files to ignore when searching buffers via \\[search-all-buffers]."
  :type 'editable-list)
(require 'grep)
(defun search-all-buffers (regexp prefix)
  "Searches file-visiting buffers for occurence of REGEXP.  With
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

;; lock the buffer
(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " locked" nil
  (set-window-dedicated-p (selected-window) sticky-buffer-mode))
(global-set-key [f11] 'sticky-buffer-mode)

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
;; using <enter> to the next line and indent it automatically
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "<f6>") 'copy-line)
(global-set-key (kbd "<f5>") 'kill-whole-line) ;;'kill-line -> C-k
;;
;; open a new line under/above the current line and jump to it using M/C-return
(global-set-key (kbd "<M-return>") "\C-e\C-m")
(global-set-key (kbd "<C-return>") "\C-a\C-m\C-p")
;; M-k kills to the left, C-k kill to the right
;; the default M-k is 'kill-sentence delete to the end of the sentence
;; C-x Backspace delete to the beginning of the sentence
(global-set-key "\M-k" '(lambda () (interactive) (kill-line 0)) )
;; C-k kill the whole single line including \n
(setq-default kill-whole-line t)

;; Actually, you can just use built-in M-;(add a comment), but you have to
;; mark the region first if you want to un/comment the current line
;; comment and uncomment and the jump to next line, use C-M-;
;; if you like, you can rm the last line "(next-line)"
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-logical-line) ;; next-line will cause warning
    ))
(global-set-key (kbd "C-M-;") 'comment-or-uncomment-region-or-line)
;; comment-box
(defalias 'cb 'comment-box)
(setq comment-style 'extra-line)
(setq byte-compile-warnings nil)
;; comment in C code,`M-;` means /* */, use // in C++ code
(add-hook 'c++-mode-hook (lambda () (setq comment-start "//"
                                          comment-end   "")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Default configuration change
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; to cause the *compilation* buffer to automatically scroll to the end of new output
(setq compilation-scroll-output t)
;; overwrite selected region when typing, yanking
(delete-selection-mode t)
;; When C-x n n/s to narrwow the marked region, don't ask whether for future session or not
;; C-x n w to go back to normal
(put 'narrow-to-region 'disabled nil)
;; make C-z(suspend-frame) to go away, and you can use C-z for others
(define-key global-map [(control z)] nil)
;; color
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;
;; there are shell and eshell
(defalias 'sh 'shell)
;; make shell in emacs load ~/.bashrc
(setq shell-command-switch "-lc")
(global-set-key (kbd "C-x s") 'shell)
;; makes shell command always start a new shell
;; eshell doesn't work for the next
(defadvice shell (around always-new-shell)
  "Always start a new shell."
  (let ((buffer
         (generate-new-buffer-name "*shell*")))
    ad-do-it))
(ad-activate 'shell)
;; support copy&paste through different apps
(setq x-select-enable-clipboard t)
;; yes/no --> y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; shortkeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; when you edit a file, use C-x C-j to go to the dir which the current file lies
(global-set-key (kbd "C-x C-j") 'dired-jump)
;; byte-comple and load *.el using "C-x c"
(define-key emacs-lisp-mode-map (kbd "C-x c") 'emacs-lisp-byte-compile-and-load)
(define-key emacs-lisp-mode-map (kbd "C-c c") 'eval-buffer)
(define-key lisp-mode-map (kbd "C-c c") 'eval-buffer)
(defalias 'brd 'byte-recompile-directory)

;; resize the opened windows
;; firstly disable some shortkeys in org-mode
;; the following shortkeys are in shift-selection, org-support-shift-select
(add-hook 'org-mode-hook
          '(lambda ()
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
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))
(global-set-key (kbd "C-x z") 'toggle-maximize-buffer)

;;
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

;; You can use C-x o 'other-window, but the following is better
;; move your point to another window in the specific direction
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)

(setq recentf-max-saved-items 100)
;;
;; revert buffer without confirmation
;; (global-auto-revert-mode 1)
(defun rev()
  (interactive)
  (revert-buffer nil t))
(global-set-key (kbd "C-c r") 'rev)
(defalias 'rtf 'recover-this-file)
;;
;; set M-x align-regexp to C-c a
(global-set-key (kbd "C-c a") 'align-regexp)

;; put cursor at the #include line, C-c o open the header file
;; c-mode-common-hook equals to c-mode-hook + c++-mode-hook
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; alias
;; define alias toe increase productivity
(defalias 'man 'woman)
;; ;; to check the whole buffer for wrong typo
;; ;; Not better than flyspell-mode
;; (defalias 'ib 'ispell-buffer)
;; (defalias 'eit 'emacs-init-time)

;; C-$ 'spell-word
;; C-S-/(C-?) is used in undo-tree plugin by default
;; But the author set two different keys for 'undo-tree-redo/undo
;; I only use M-_, comment out the two lines of file undo-tree.el
;; (define-key map (kbd "C-/") 'undo-tree-undo)
;; (define-key map (kbd "C-?") 'undo-tree-redo)
(global-set-key (kbd "C-?") 'ispell-complete-word)
;; autoload flyspell-mode/flyspell-buffer
(add-hook 'prog-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode 'flyspell-mode)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;
;; ;; spell check set up for programmers, more:
;; ;;
;; ;; http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
;; ;; http://blog.binchen.org/posts/effective-spell-check-in-emacs.html
;; ;;
;; ;; if (aspell installed) { use aspell}
;; ;; else if (hunspell installed) { use hunspell }
;; ;; whatever spell checker I use, I always use English dictionary
;; ;; I prefer use aspell because:
;; ;; 1. aspell is older
;; ;; 2. looks Kevin Atkinson still get some road map for aspell:
;; ;; @see http://lists.gnu.org/archive/html/aspell-announce/2011-09/msg00000.html
;; (defun flyspell-detect-ispell-args (&optional RUN-TOGETHER)
;;   "if RUN-TOGETHER is true, spell check the CamelCase words"
;;   (let (args)
;;     (cond
;;      ((string-match  "aspell$" ispell-program-name)
;;       ;; force the English dictionary, support Camel Case spelling check (tested with aspell 0.6)
;;       (setq args (list "--sug-mode=ultra" "--lang=en_US"))
;;       (if RUN-TOGETHER
;;           (setq args (append args '("--run-together" "--run-together-limit=5" "--run-together-min=2")))))
;;      ((string-match "hunspell$" ispell-program-name)
;;       (setq args nil)))
;;     args
;;     ))

;; (cond
;;  ((executable-find "aspell")
;;   (setq ispell-program-name "aspell"))
;;  ((executable-find "hunspell")
;;   (setq ispell-program-name "hunspell")
;;   ;; just reset dictionary to the safe one "en_US" for hunspell.
;;   ;; if we need use different dictionary, we specify it in command line arguments
;;   (setq ispell-local-dictionary "en_US")
;;   (setq ispell-local-dictionary-alist
;;         '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8))))
;;  (t (setq ispell-program-name nil)))

;; ;; ispell-cmd-args is useless, it's the list of *extra* arguments we will append to the ispell process when "ispell-word" is called.
;; ;; ispell-extra-args is the command arguments which will *always* be used when start ispell process
;; (setq ispell-extra-args (flyspell-detect-ispell-args t))
;; ;; (setq ispell-cmd-args (flyspell-detect-ispell-args))
;; (defadvice ispell-word (around my-ispell-word activate)
;;   (let ((old-ispell-extra-args ispell-extra-args))
;;     (ispell-kill-ispell t)
;;     (setq ispell-extra-args (flyspell-detect-ispell-args))
;;     ad-do-it
;;     (setq ispell-extra-args old-ispell-extra-args)
;;     (ispell-kill-ispell t)
;;     ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; Tab & indent
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (setq python-indent 4)))
;; use spaces instead of tabs, nit->t -- don't replace
(setq-default indent-tabs-mode nil)
;;
(add-hook 'text-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 4)))
;; ;;
;; (add-hook 'c-mode-common-hook
;;           '(lambda ()
;;              (c-set-style "linux")
;;              (setq tab-width 8)
;;              (setq indent-tabs-mode t)  ;;default in linux kernel
;;              (setq c-basic-offset 8)))

;;;;;;;Documentation/CodingStyle
;;Using spaces for alignment, but tabs for indentation
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))
(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))
(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              (setq indent-tabs-mode t)
              (c-set-style "linux-tabs-only"))))
;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; Parentheses
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; show the double paren
(show-paren-mode t)
(setq show-paren-style 'parenthesis)
;; show the open parentheses when typeing the closing one
(setq blink-matching-paren t)
;;
;; auto insert the other half of parentheses
(defun my-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
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
(add-hook 'prog-mode-hook 'my-mode-auto-pair)
(add-hook 'org-mode-hook 'my-mode-auto-pair)
;;
;; automatically insert new line with } and indent when typing {
(define-minor-mode c-helpers-minor-mode
  "This mode contains little helpers for C developement" nil ""
  '(
    ((kbd "{") . insert-c-block-parentheses)))
(defun insert-c-block-parentheses ()
  (interactive)
  (insert "{")
  (newline)
  (newline)
  (insert "}")
  (indent-for-tab-command)
  (call-interactively 'previous-line)
  (indent-for-tab-command))
(add-hook 'c-mode-common-hook 'c-helpers-minor-mode)
(add-hook 'java-mode-hook 'c-helpers-minor-mode)
(add-hook 'cperl-mode-hook 'c-helpers-minor-mode)
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
;; Emacs will know cperl-mode-map only if the cperl-mode will be loaded
(require 'cperl-mode)
(define-key cperl-mode-map (kbd "C-{") 'insert-c-block-parentheses-without-indent)

;; Code folding using built-in hs-minor-mode
;; F1-b to see the key binding
(mapc (lambda (mode-hook) (add-hook mode-hook 'hs-minor-mode))
      '(c-mode-common-hook
        java-mode-hook
        python-mode-hook
        emacs-lisp-mode-hook
        lisp-mode-hook))
;; ediff split horizontal, default is vertically
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; built-in projects
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; built-in cedet
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
;; activates displaying of possible name completions in the idle time.
;; Requires that global-semantic-idle-scheduler-mode was enabled;
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
          '(lambda() (set
                      (make-local-variable 'semantic-mode) nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;    plugin in .emacs.d/plugin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load plugin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages from  elpa, marmelade and melpa.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'package "package" t)
;; Package repositories
(setq package-archives '(
                         ("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("melpa-stable" . "http://hiddencameras.milkbox.net/packages/")
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

;; ecb, use M-x ecb-minor-mode, or Tools->Start Code Browser
;; you'll be suprised
;; If you want to load the ECB first after starting it by ecb-activate
;; (Advantage: Fast loading. Disadvantage: ECB- and semantic-options first available after starting ECB):
(require 'ecb-autoloads)
(defalias 'emm 'ecb-minor-mode)
;; If you want to load the complete ECB at (X)Emacs-loadtime
;; (Advantage: All ECB-options available after loading ECB. Disadvantage: Increasing loadtime):
;; (require 'ecb)

;; hippie-expand-etx
(require 'hippie-exp-ext)
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
;; watch the emacs-rocks-13-multiple-cursors.mov video
(autoload 'multiple-cursors "multiple-cursors" t)
;; When you have an active region that spans multiple lines, the following will add a cursor to each line
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; When you want to add multiple cursors not based on continuous lines,
;; but based on keywords in the buffer, first mark the word, then add more cursors:
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; ace-jump-mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode" t)
;; case insensitive-->nil
;; (setq ace-jump-mode-case-fold nil)
;; Show the message before jumping
(add-hook 'ace-jump-mode-before-jump-hook (lambda () (message "I am jumping")))
;; enable a more powerful jump back function from ace jump mode
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
;; Use C-x SPC jump back
(define-key global-map (kbd "C-c C-j") 'ace-jump-mode-pop-mark)
;; C-x SPC for the first char, C-u C-c SPC for non-first character,
;; C-u C-u C-c SPC jump to the ?line
(define-key global-map (kbd "C-c j") 'ace-jump-mode)
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
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
;; Want to work in text-mode
(defun er/add-text-mode-expansions ()
  (make-variable-buffer-local 'er/try-expand-list)
  (setq er/try-expand-list (append
                            er/try-expand-list
                            '(mark-paragraph
                              mark-page))))
(er/enable-mode-expansions 'text-mode 'er/add-text-mode-expansions)

;; tag for include/*
(setq tags-file-name "~/.emacs.d/TAGS")
;; use 'complete-tag to complete symbol in include/*
(global-set-key [f2] 'complete-tag)

;;;; popup required by ac
;; (require 'popup)

;;;; fuzzy required for ac-fuzzy-complete
;; (require 'fuzzy)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;   auto-complete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete)
(require 'auto-complete-config)
;; since the dropdown menu shows up too slow, so use trigger key TAB
;; (ac-set-trigger-key "TAB")
;; (define-key ac-mode-map (kbd "<tab>") 'auto-complete)
;; Generally, trigger key is used with auto-auto-start being nil.
;; (setq ac-auto-start nil)
;;
(add-to-list 'ac-dictionary-directories
             "~/.emacs.d/elpa/auto-complete-20140322.321/dict")
(setq ac-comphist-file (expand-file-name
                        "~/.emacs.d/ac-comphist.dat"))
(setq ac-use-quick-help t)
(setq ac-quick-help-delay 1)
;; The following line uses auto-complete-mode-maybe, which turn AC on
;; only those listed in ac-modes
(global-auto-complete-mode t)
;; ;; Enable AC only for few modes
;; ;; (setq ac-modes '(c++-mode sql-mode))
;; or enable it everywhere(not in minibuffer)
(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))
;;
;; t could be time
(setq ac-auto-show-menu t)
(setq ac-menu-height 15)
;; the next line will make ac popup instantly
(ac-flyspell-workaround)
;;
;; (setq ac-show-menu-immediately-on-auto-complete t)
;;
;; (set-face-background 'ac-candidate-face "lightgray")
;; (set-face-underline-p 'ac-candidate-face "darkgray")
;; (set-face-background 'ac-selection-face "royalblue")
(define-key ac-completing-map "\M-n" 'ac-next)
(define-key ac-completing-map "\M-p" 'ac-previous)
;; the menu and RET issue
;; (define-key ac-complete-mode-map "<return>" 'nil)
;; completion starts more than a length of the completion target string.
;;`t` means always starting completion automatically,
;; t could be an integer, which is the num of characters you type
(setq ac-auto-start 3)
;; t means:
;;    After selecting candidates, TAB will behave as RET
;;    TAB will behave as RET only on candidate remains
(setq ac-dwim t)
;; Distinguish case, if ignore case, nil -> t
;; Ignore case if completion target string doesn't include upper characters, nil -> smart
(setq ac-ignore-case nil)
(defalias 'ac 'auto-complete)
(setq ac-fuzzy-complete t)
;;
;; ac-c-headers,  auto-complete source for C headers
(require 'ac-c-headers)
(add-hook 'c-mode-common-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-c-headers)
            (add-to-list 'ac-sources 'ac-source-c-header-symbols t)
            ;; the following two lines are from cebet, names completion with auto-complete package
            (add-to-list 'ac-sources 'ac-source-gtags)
            (add-to-list 'ac-sources 'ac-source-semantic)))
(ac-config-default)
(set-default 'ac-sources
             '(ac-source-semantic
               ac-source-yasnippet
               ac-source-abbrev
               ac-source-words-in-buffer
               ac-source-words-in-all-buffer
               ac-source-imenu
               ac-source-files-in-current-dir
               ac-source-filename))
;; auto-complete-c-headers
(require 'auto-complete-c-headers)
(add-to-list 'ac-sources 'ac-source-c-headers)
;; c-eldoc
;; (setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../")
(add-hook 'c-mode-common-hook 'c-turn-on-eldoc-mode)
;; eldoc for elisp
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)


;; ;; tabbar for tabs
;; (require 'tabbar)
;; (setq tabbar-buffer-groups-function
;;       (lambda ()
;;         (list "All")))
;; ;; uncomment the next line to default showing the tabbar
;; ;;(tabbar-mode)
;; ;; when tabbar-mode is enabled, use the following shortkeys
;; ;; You can also use C-c C-<left>/<right> do the tricks
;; (define-key tabbar-mode-map  (kbd "C-S-<iso-lefttab>") 'tabbar-backward)
;; (define-key tabbar-mode-map (kbd "C-<tab>") 'tabbar-forward)

;; undo-tree, C-_-> undo, M-+ -> redo, C-x u -> undo-tree-visualize
;; more infomation please check the doc
;; comment out the lines of undo-tree.el because of two sets for them
;; (define-key map (kbd "C-/") 'undo-tree-undo)
;; (define-key map (kbd "C-?") 'undo-tree-redo)
;; change the (defcustom undo-tree-mode-lighter " Undo-Tree"
;; the " Undo-Tree" into " ut", shorter
(require 'undo-tree)
;; replace the standard undo system
(global-undo-tree-mode)
(defadvice undo-tree-visualizer-mode(after undo-tree-face activate)
  (buffer-face-mode))

;;
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
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; markdown-mode+
(autoload 'markdown-mode+ "markdown-mode+" t)

;; ascope
(require 'ascope)
;; in the *Result* buffer, n/p 'ascope-next/prev-symbol
;; " "(blank) 'ascope-show-entry-other-window
;; RET 'ascope-select-entry-other-window-delete-window
;; C-c s u 'cscope-pop-mark to go back
;; n/p in popup window
(add-hook 'c-mode-common-hook
          (lambda()
            (cscope-minor-mode t)
            (local-set-key  (kbd "C-c s g") 'ascope-find-global-definition)
            (local-set-key  (kbd "C-c s c") 'ascope-find-functions-calling-this-function)
            (local-set-key  (kbd "C-c s h") 'ascope-find-files-including-file)
            (local-set-key  (kbd "C-c s s") 'ascope-find-this-symbol)
            (local-set-key  (kbd "C-c s t") 'ascope-find-this-text-string)
            (local-set-key  (kbd "C-c s a") 'ascope-all-symbol-assignments)
            ;; (local-set-key  (kbd "C-c s o") 'ascope-show-entry-other-window)
            ;; (local-set-key  (kbd "C-c s p") 'ascope-show-prev-entry-other-window)
            ;; (local-set-key  (kbd "C-c s n") 'ascope-show-next-entry-other-window)
            ))

;; ;; gtags, doesn't work  but ggtags works, weird
;; (autoload 'gtags-mode "gtags" "" t)
;; (add-hook 'c-mode-hook
;;           '(lambda ()
;;              (gtags-mode 1)
;;              ))
;; ;; Setting to make 'Gtags select mode' easy to see
;; (add-hook 'gtags-select-mode-hook
;;           '(lambda ()
;;              (setq hl-line-face 'underline)
;;              (hl-line-mode 1)
;;              ))
;; (setq gtags-mode-hook
;; '(lambda ()
;; (setq gtags-path-style 'relative)
;; )) ;; relative can be root, relative and absolute
;; (add-hook 'c-mode-common-hook
;;           (lambda()
;;             (local-set-key (kbd "C-c s g") 'gtags-find-tag-other-window)
;;             (local-set-key (kbd "C-c s G") 'gtags-find-tag-from-here)
;;             (local-set-key (kbd "C-c s s") 'gtags-find-symbol)
;;             (local-set-key (kbd "C-c s S") 'gtags-find-with-grep)
;;             (local-set-key (kbd "C-c s r") 'gtags-find-rtag)
;;             (local-set-key (kbd "C-c s p") 'gtags-find-pattern)
;;             (local-set-key (kbd "C-c s f") 'gtags-find-file)
;;             (local-set-key (kbd "C-c s b") 'gtags-pop-stack)
;;             (local-set-key (kbd "C-c s m") 'gtags-make-complete-list)
;;             ))
(which-function-mode 1)
;; repalce the 8 with other number to change the position
(let ((which-func '(which-func-mode ("" which-func-format " "))))
  (setq-default mode-line-format (remove which-func mode-line-format))
  (setq-default mode-line-misc-info (remove which-func mode-line-misc-info))
  (setq cell (last mode-line-format 8))
  (setcdr cell
          (cons which-func
                (cdr cell))))

;; ggtags: https://github.com/leoliu/ggtags
;; M-n/p, M-* to go back, RET to exit ggtags status'
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))


;; org-mode
(autoload 'package "package" t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; then install both org and org-plus-contrib, they are all in contrib/ from org git repo.
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
(require 'org-habit)
(require 'ob-tangle)
(setq org-completion-use-ido t)
(define-key org-mode-map (kbd "C-c a") 'org-agenda)
(define-key org-mode-map (kbd "C-c c") 'org-capture)
;; show/unshow the descriptive and literal links, disable 'org*task
;; because it takes the C-c C-x t key after updates after a while
;; (setq org-inlinetask-insert-task nil)
(define-key org-mode-map (kbd "C-c C-x t") 'org-toggle-link-display)
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
(setq org-agenda-include-all-todo nil)
;; 4. Make sure that your org files are byte-compiled.
(add-to-list 'auto-mode-alist '("\\.\\(\\|README\\|txt\\)$" . org-mode))
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
;;   "Switch entry to DONE when all subentries are done, to TODO otherwise."
;;   (let (org-log-done org-log-states)   ; turn off logging
;;     (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
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
(setq org-src-fontify-natively t)
;;;;;;;;;;;;;;;
;; org-plus-contrib


;; helm
;; https://github.com/emacs-helm/helm/wiki
;; Find Files or url: ~/
;; 	That show all ~/ directory.
;; Find Files or url: ~/des
;; 	will show all what begin with "des"
;; Find Files or url: ~/ esk
;; 	(Notice the space after ~/) will show all what contain esk.
;; Find Files or url: ~/ el$
;; 	Will show all what finish with el
;; use C-{/} to narrow/enlarge the candidates buffer
(require 'helm-config)
(helm-mode 1)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "M-x") 'helm-M-x)
;; The default M-y was 'yank-pop
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-/") 'helm-imenu)
(global-set-key (kbd "C-c x") 'helm-resume)

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
;; 	There are no errors in the current buffer.
;; FlyC*
;; 	A syntax check is being performed currently.
;; FlyC:3/4
;; 	There are three errors and four warnings in the current buffer.
;; FlyC-
;; 	Automatic syntax checker selection did not find a suitable syntax checker.
;; 	See Syntax checker selection for more information.
;; FlyC!
;; 	The syntax check failed. Inspect the *Messages* buffer for details.
;; FlyC?
;; 	The syntax check had a dubious result. The definition of the syntax checker
;; 	may be flawed. Inspect the *Messages* buffer for details. This indicator should
;; 	never be displayed for built-in syntax checkers. If it is, please report an
;; 	issue to the Flycheck developers, as by Reporting issues.
;; C-c ! l 'flycheck-list-errors
;; C-c ! n 'flycheck-next-error
;; C-c ! p 'flycheck-previous-error
;; C-c ! c 'flycheck-buffer
;; install clang cppcheck first for c/c++ checker
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; smartscan
;; M-n and M-p move between symbols and type M-' to replace all symbols in the buffer
;; matching the one under point, and C-u M-' to replace symbols in your current defun
;; only (as used by narrow-to-defun.)
(require 'smartscan)
(global-smartscan-mode 1)

;; magit
;;
;; git-commit-mode required by magit
;; git-rebase-mode required by magit
;; magit
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list "~/.emacs.d/elpa/magit-*/")))
(require 'magit)
(global-set-key (kbd "C-c m") 'magit-status)
;; point to your favorite repos, Now use C-u M-x magit-status and have
;; magit prompt you to choose from one of your favorite repos.
(eval-after-load "magit"
  '(mapc (apply-partially 'add-to-list 'magit-repo-dirs)
         '("~/.emacs.d"
           ;; "~/dev/repo_b"
           )))
;; open link file such as .emacs to open just the link not the original file
(setq vc-follow-symlinks 'nil)

;; manage-minor-mode
(setq manage-minor-mode-default
      '((global
         (on   rainbow-mode)
         (off  line-number-mode))
        (emacs-lisp-mode
         (on   rainbow-delimiters-mode eldoc-mode show-paren-mode))
        (js2-mode
         (on   color-identifiers-mode)
         (off  flycheck-mode))))

;; highlight-blocks
(add-hook 'prog-mode-hook 'highlight-blocks-mode)

;; ;; evil, use C-z to switch between vim/Emacs
;; (setq evil-search-module 'evil-search
;;       evil-want-C-u-scroll t
;;       evil-want-C-w-in-emacs-state t)
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

;; emmet for web development
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;   el-get      ;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  el-get self setup
;; ;;
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (let (el-get-master-branch)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp))))
;; (el-get 'sync)
;; ;; solve the "Could not update git submodules" error
;; (setq el-get-github-default-url-type "https")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	the plugin installed by el-get
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
