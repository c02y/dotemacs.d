;;; modeline-posn-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "modeline-posn" "modeline-posn.el" (22665 30526
;;;;;;  605548 375000))
;;; Generated autoloads from modeline-posn.el

(defface modelinepos-column-warning '((t (:foreground "Red"))) "\
*Face used to highlight the modeline column number.
This is used when the current column number is greater than
`modelinepos-column-limit'." :group (quote Modeline) :group (quote Convenience) :group (quote Help) :group (quote faces))

(defface modelinepos-region '((t :inherit region)) "\
*Face used to highlight the modeline position and size when
the region is active." :group (quote Modeline) :group (quote Convenience) :group (quote Help) :group (quote faces))

(defface modelinepos-region-acting-on '((t (:inherit region :box (:line-width 3 :color "Red")))) "\
*Face for modeline position & size when a command acts on active region.
\(Not used for Emacs 22)." :group (quote Modeline) :group (quote Convenience) :group (quote Help) :group (quote faces))

(defvar modelinepos-column-limit 70 "\
*Current column greater than this means highlight column in mode-line.")

(custom-autoload 'modelinepos-column-limit "modeline-posn" t)

(defvar modelinepos-empty-region-flag t "\
*Non-nil means indicate an active region even when empty.")

(custom-autoload 'modelinepos-empty-region-flag "modeline-posn" t)

(defvar modelinepos-style '((if modelinepos-rect-p " %d rows, %d cols" " %d ch, %d l") (if modelinepos-rect-p (count-lines (region-beginning) (region-end)) (abs (- (mark t) (point)))) (if modelinepos-rect-p (if (fboundp 'rectangle--pos-cols) (let ((rpc (rectangle--pos-cols (region-beginning) (region-end)))) (abs (- (car rpc) (cdr rpc)))) (let ((start (region-beginning)) (end (region-end)) startcol endcol) (save-excursion (goto-char start) (setq startcol (current-column)) (beginning-of-line) (goto-char end) (setq endcol (current-column)) (when (< endcol startcol) (let ((col startcol)) (setq startcol endcol endcol col))) (abs (- startcol endcol))))) (count-lines (mark t) (point)))) "\
*What info to include about the region size, in mode-line.
Value `chars+lines' means print the number of characters and lines or,
if a rectangle command is invoked, the number of rows and columns.

In general, the value is a format string followed by however many
sexps the string expects as arguments.")

(custom-autoload 'modelinepos-style "modeline-posn" t)

(defvar size-indication-mode nil "\
Non-nil if Size-Indication mode is enabled.
See the `size-indication-mode' command
for a description of this minor mode.")

(custom-autoload 'size-indication-mode "modeline-posn" nil)

(autoload 'size-indication-mode "modeline-posn" "\
Toggle Size Indication mode.
With arg, turn Size Indication mode on iff arg is positive.
When Size Indication mode is enabled, the buffer or region size
appears in the mode line.  If Transient Mark mode is enabled, the
region size is shown; otherwise, the size of the accessible part
of the buffer is shown.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; modeline-posn-autoloads.el ends here
