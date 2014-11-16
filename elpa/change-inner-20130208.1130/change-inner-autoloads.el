;;; change-inner-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (copy-outer change-outer copy-inner change-inner)
;;;;;;  "change-inner" "change-inner.el" (21608 25828 754624 574000))
;;; Generated autoloads from change-inner.el

(autoload 'change-inner "change-inner" "\
Works like vim's ci command. Takes a char, like ( or \" and
kills the innards of the first ancestor semantic unit starting with that char.

\(fn ARG)" t nil)

(autoload 'copy-inner "change-inner" "\


\(fn)" t nil)

(autoload 'change-outer "change-inner" "\
Works like vim's ci command. Takes a char, like ( or \" and
kills the first ancestor semantic unit starting with that char.

\(fn ARG)" t nil)

(autoload 'copy-outer "change-inner" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("change-inner-pkg.el") (21608 25828 875542
;;;;;;  563000))

;;;***

(provide 'change-inner-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; change-inner-autoloads.el ends here
