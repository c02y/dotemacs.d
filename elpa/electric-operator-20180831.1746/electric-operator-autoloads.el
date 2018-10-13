;;; electric-operator-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "electric-operator" "electric-operator.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from electric-operator.el

(autoload 'electric-operator-mode "electric-operator" "\
Toggle automatic insertion of spaces around operators (Electric Spacing mode).

With a prefix argument ARG, enable Electric Spacing mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil.

This is a local minor mode.  When enabled, typing an operator automatically
inserts surrounding spaces, e.g., `=' becomes ` = ',`+=' becomes ` += '.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "electric-operator" '("electric-operator-")))

;;;***

;;;### (autoloads nil "electric-operator-benchmark" "electric-operator-benchmark.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from electric-operator-benchmark.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "electric-operator-benchmark" '("elp-benchmark" "other-benchmark")))

;;;***

;;;### (autoloads nil nil ("electric-operator-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; electric-operator-autoloads.el ends here
