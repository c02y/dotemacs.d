;;; stickyfunc-enhance-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "stickyfunc-enhance" "stickyfunc-enhance.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from stickyfunc-enhance.el

(autoload 'semantic-stickyfunc-fetch-stickyline "stickyfunc-enhance" "\
Make the function at the top of the current window sticky.
Capture its function declaration, and place it in the header line.
If there is no function, disable the header line.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "stickyfunc-enhance" '("stickyfunc-enhance--")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; stickyfunc-enhance-autoloads.el ends here
