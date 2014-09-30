;;; workgroups2-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (wg-help workgroups-mode) "workgroups2" "workgroups2.el"
;;;;;;  (21546 44276 765228 987000))
;;; Generated autoloads from workgroups2.el

(autoload 'workgroups-mode "workgroups2" "\
Turn `workgroups-mode' on and off.
ARG is nil - toggle
ARG >= 1   - turn on
ARG == 0   - turn off
ARG is anything else, turn on `workgroups-mode'.

\(fn &optional ARG)" t nil)

(autoload 'wg-help "workgroups2" "\
Just call `apropos-command' on \"^wg-\".
There used to be a bunch of help-buffer construction stuff here,
including a `wg-help' variable that basically duplicated every
command's docstring;  But why, when there's `apropos-command'?

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("workgroups2-pkg.el") (21546 44276 868127
;;;;;;  279000))

;;;***

(provide 'workgroups2-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; workgroups2-autoloads.el ends here
