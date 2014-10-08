;;; yafolding-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (yafolding-mode) "yafolding" "yafolding.el" (21557
;;;;;;  20654 244416 203000))
;;; Generated autoloads from yafolding.el

(defvar yafolding-mode-map (let ((map (make-sparse-keymap))) (define-key map (kbd "<C-S-return>") #'yafolding-toggle-all) (define-key map (kbd "<C-return>") #'yafolding-toggle-element) map))

(autoload 'yafolding-mode "yafolding" "\
Toggle yafolding mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("yafolding-pkg.el") (21557 20654 325514
;;;;;;  65000))

;;;***

(provide 'yafolding-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; yafolding-autoloads.el ends here
