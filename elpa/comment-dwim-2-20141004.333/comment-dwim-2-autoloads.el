;;; comment-dwim-2-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (comment-dwim-2) "comment-dwim-2" "comment-dwim-2.el"
;;;;;;  (21573 7417 678918 724000))
;;; Generated autoloads from comment-dwim-2.el

(autoload 'comment-dwim-2 "comment-dwim-2" "\
Call a comment command according to the context.

If the region is active, call `comment-or-uncomment-region' to
toggle comments.
Else, the function applies to the current line and calls a
different function at each successive call. The behavior is:
* First  call : Toggle line commenting
* Second call : - Kill inline comment if one is present (1)
                - Insert inline comment otherwise
Given an argument, it reindents the inline comment instead (2).

Please note that the behavior of `comment-dwim-2' when
encountering an inline comment can be customized. Setting
`comment-dwim-2--inline-comment-behavior' to 'reindent-comment
will swap (1) and (2).

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("comment-dwim-2-pkg.el") (21573 7417 778017
;;;;;;  546000))

;;;***

(provide 'comment-dwim-2-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; comment-dwim-2-autoloads.el ends here
