;;; rebox2-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rebox2" "rebox2.el" (0 0 0 0))
;;; Generated autoloads from rebox2.el

(autoload 'rebox-mode "rebox2" "\
Toggle rebox mode for managing text and comment boxes.

1. Auto-filling is enabled, and comment boxes are auto-filled.



With no argument, this command toggles the mode.
  Non-null prefix argument turns on the mode.
  Null prefix argument turns off the mode.

You don't need to enable the minor mode to use rebox2, see rebox2
header.

\(fn &optional ARG)" t nil)

(autoload 'rebox-beginning-of-line "rebox2" "\


\(fn ARG)" t nil)

(autoload 'rebox-end-of-line "rebox2" "\


\(fn ARG)" t nil)

(autoload 'rebox-kill-line "rebox2" "\


\(fn ARG)" t nil)

(autoload 'rebox-indent-new-line "rebox2" "\
Create newline.

Prefix arg greater than zero inserts arg lines.  Other prefix arg
causes refilling without actually inserting a newline.

If point is within a box, insert line in box.  As usual any
comment is a box.


If point is outside a box call function from
`rebox-newline-indent-function-alist'.

\(fn ARG)" t nil)

(autoload 'rebox-dwim "rebox2" "\
On first invocation, fill region or comment.

Subsequent invocations cycle though styles defined in
`rebox-style-loop', **REFILLING EACH TIME**.

Style may be specified through prefix arg.

If refilling is not desired, use `rebox-cycle'

\(fn ARG)" t nil)

(autoload 'rebox-fill "rebox2" "\
refill the current box or fill current region as a box

\(fn)" t nil)

(autoload 'rebox-cycle "rebox2" "\
Cycle current region or comment to the next style in loop.

When called interactively, never refill.

With universal arg (C-u), use previous style in loop.

With numeric arg, use explicit style.

\(fn ARG &optional REFILL)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rebox2" '("rebox-" "turn-o")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rebox2-autoloads.el ends here
