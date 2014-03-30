;;; manage-minor-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (manage-minor-mode-bals manage-minor-mode manage-minor-mode-set)
;;;;;;  "manage-minor-mode" "manage-minor-mode.el" (21278 51801 487189
;;;;;;  881000))
;;; Generated autoloads from manage-minor-mode.el

(autoload 'manage-minor-mode-set "manage-minor-mode" "\


\(fn)" nil nil)

(autoload 'manage-minor-mode "manage-minor-mode" "\


\(fn &optional $LAST-TOGGLED-ITEM)" t nil)

(autoload 'manage-minor-mode-bals "manage-minor-mode" "\

Eradicate all minor-modes in the current buffer.
This command may cause unexpected effect even to other buffers.
However, don't worry, restore command exists:
 `manage-minor-mode-restore-from-bals'.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("manage-minor-mode-pkg.el") (21278 51801
;;;;;;  592356 483000))

;;;***

(provide 'manage-minor-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; manage-minor-mode-autoloads.el ends here
