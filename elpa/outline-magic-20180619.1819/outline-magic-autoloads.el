;;; outline-magic-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "outline-magic" "outline-magic.el" (0 0 0 0))
;;; Generated autoloads from outline-magic.el

(autoload 'outline-cycle "outline-magic" "\
Visibility cycling for outline(-minor)-mode.

- When point is at the beginning of the buffer, or when called with a
  C-u prefix argument, rotate the entire buffer through 3 states:
  1. OVERVIEW: Show only top-level headlines.
  2. CONTENTS: Show all headlines of all levels, but no body text.
  3. SHOW ALL: Show everything.

- When point is at the beginning of a headline, rotate the subtree started
  by this line through 3 different states:
  1. FOLDED:   Only the main headline is shown.
  2. CHILDREN: The main headline and the direct children are shown.  From
               this state, you can move to one of the children and
               zoom in further.
  3. SUBTREE:  Show the entire subtree, including body text.

- When point is not at the beginning of a headline, execute
  `indent-relative', like TAB normally does.

\(fn &optional ARG)" t nil)

(autoload 'outline-next-line "outline-magic" "\
Forward line, but mover over invisible line ends.
Essentially a much simplified version of `next-line'.

\(fn)" t nil)

(autoload 'outline-move-subtree-up "outline-magic" "\
Move the currrent subtree up past ARG headlines of the same level.

\(fn &optional ARG)" t nil)

(autoload 'outline-move-subtree-down "outline-magic" "\
Move the currrent subtree down past ARG headlines of the same level.

\(fn &optional ARG)" t nil)

(autoload 'outline-promote "outline-magic" "\
Decrease the level of an outline-structure by ARG levels.
When the region is active in transient-mark-mode, all headlines in the
region are changed.  Otherwise the current subtree is targeted. Note that
after each application of the command the scope of \"current subtree\"
may have changed.

\(fn &optional ARG)" t nil)

(autoload 'outline-demote "outline-magic" "\
Increase the level of an outline-structure by ARG levels.
When the region is active in transient-mark-mode, all headlines in the
region are changed.  Otherwise the current subtree is targeted. Note that
after each application of the command the scope of \"current subtree\"
may have changed.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "outline-magic" '("outline-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; outline-magic-autoloads.el ends here
