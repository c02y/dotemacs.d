;;; omni-scratch-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "omni-scratch" "omni-scratch.el" (0 0 0 0))
;;; Generated autoloads from omni-scratch.el

(autoload 'omni-scratch "omni-scratch" "\
Create a new scratch buffer and switch to. Unless if in scratch buffer already

\(fn UNIVERSAL-ARG &optional POINT MARK)" t nil)

(autoload 'omni-scratch-major "omni-scratch" "\
Create a new scratch buffer and switch to with current major mode.

\(fn UNIVERSAL-ARG &optional POINT MARK)" t nil)

(autoload 'omni-scratch-buffer "omni-scratch" "\
Create a new scratch buffer associated with current buffer.

\(fn UNIVERSAL-ARG &optional POINT MARK)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omni-scratch" '("omni-scratch-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; omni-scratch-autoloads.el ends here
