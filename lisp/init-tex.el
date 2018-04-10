;; NOTE: once you move this whole Emacs configuration into a new machine
;; you have to install auctex package in package-list-packages manually, or
;; it will print "error: Unable to activate package ‘company-auctex’.
;; Required package ‘auctex-11.87’ is unavailable " error message
;;
;; LaTeX -- AucTex
;; C-c ? (or M-x TeX-doc) gives documentation for the symbol at point,
;; or for any package, command or document.
(load "auctex.el" nil t t)
(require 'tex-mik)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;; when you open a file, ask for the master file but not changing any file
;; this will make the LaTeX-save-and-compile deal with multi-files project
(setq-default TeX-master 'shared)
;; LaTeX-mode for tex file
;; (add-hook 'plain-TeX-mode-hook 'LaTeX-mode)
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))
;; company-auctex
(require 'company-auctex)
(require 'tex-buf)
(require 'auctex-latexmk)
(auctex-latexmk-setup)
;;
;; remove fdb_latexmk file will solve the problem
;; of the reference number instead of question mark (?)
(setq LaTeX-clean-intermediate-suffixes
	  (append LaTeX-clean-intermediate-suffixes
			  (list "\\.fdb_latexmk")))
(defun LaTeX-save-and-compile ()
  "Save and compile the tex project using latexmk.

If compilation fails, split the current window and open error-buffer
then jump to the error line, if errors corrected, close the error-buffer
window and close the *TeX help* buffer."
  (interactive)
  (progn
	;; ;; turn off smartparens because LaTeX-electric-left-right-brace
	;; ;; offers more for specific LaTeX mode
	;; ;; Since SP is always triggered later by sth., so put these two lines here
	;; (turn-off-smartparens-mode)
	;; (setq LaTeX-electric-left-right-brace t)
	(let ((TeX-save-query nil)
		  (TeX-process-asynchronous nil)
		  (master-file (TeX-master-file)))
	  (TeX-save-document "")
	  ;; clean all generated files before compile
	  ;; DO NOT do it when up-to-date, remove this line in proper time
	  (TeX-clean t)
	  (TeX-run-TeX "latexmk"
				   (TeX-command-expand "latexmk -pdflatex='pdflatex -file-line-error -synctex=1' -pdf %s"
									   'TeX-master-file)
				   master-file)
	  (if (plist-get TeX-error-report-switches (intern master-file))
		  ;; avoid creating multiple windows to show the *TeX Help* error buffer
		  (if (get-buffer-window (get-buffer "*TeX Help*"))
			  (TeX-next-error)
			(progn
			  (split-window-vertically -10)
			  (TeX-next-error)))
		;; if no errors, delete *TeX Help* window and buffer
		(if (get-buffer "*TeX Help*")
			(progn
			  (if (get-buffer-window (get-buffer "*TeX Help*"))
				  (delete-windows-on "*TeX Help*"))
			  (kill-buffer "*TeX Help*")))))))
(add-hook 'LaTeX-mode-hook
		  (lambda ()
			(setq LaTeX-item-indent 0)
			(visual-line-mode)
			(flyspell-mode)
			(setq-default TeX-newline-function 'advanced-return)
			;; make the code look like the pdf file, C-c C-o ... for commands
			;; If it should be activated in all AUCTEX modes, use TeX-mode-hook
			;; instead of LaTeX-mode-hook.
			(TeX-fold-mode 1)
			;; usepackage
			(setq tex-tree-roots t)
			(LaTeX-math-mode)
			;; this line have to be here to make company work
			(company-auctex-init)
			;; disable smartparens-mode completely and use
			;; LaTeX-electric-left-right-brace instead
			(push 'latex-mode sp-ignore-modes-list)
			(setq LaTeX-electric-left-right-brace t)
			;; the following line will inset braces after _ or ^
			;; unnecessarily most of time
			;; (setq TeX-electric-sub-and-superscript t)
			;; NOTE: C-c C-a to combine C-c C-c and C-c C-v
			;; C-u C-c C-c latexmk (or others like View) so you can change the command line
			;; jump: the following makes viewing the pdf right at the line of the tex file
			(add-to-list 'TeX-command-list
						 '("latexmk" "latexmk -pdflatex='pdflatex -file-line-error -synctex=1' -pdf %s"
						   TeX-run-command nil t :help "Run latexmk") t)
			;; for tex file contains Chinese font
			(add-to-list 'TeX-command-list
						 '("XeLaTeX" "latexmk -pdflatex='xelatex -interaction nonstopmode -shell-escape' -pdf %s"
						   TeX-run-command nil t :help "Run xelatex") t)
			;; (setq TeX-command-default "XeLaTeX")
			(setq TeX-command-default "latexmk")
			(push '("%(masterdir)" (lambda nil (file-truename (TeX-master-directory))))
				  TeX-expand-list)
			;; Enable only one from all the 3 options to view pdf
			;; Options1: Okular, the jumping to page may not work in old Okular
			(push '("Okular" "okular --unique %o#src:%n%(masterdir)%b") TeX-view-program-list)
			(push '(output-pdf "Okular") TeX-view-program-selection)
			;; Options2: Evince
			;; NOTE: it seems this options is builtin by default by AUCTEX
			;; if you want to use this one, disable all of the three
			;; (setq TeX-view-program-list '(("Evince" "evince --page-label=%(outpage) %o")))
			;; (setq TeX-view-program-selection '((output-pdf "Evince")))
			;; Options3: builtin pdf viewer, TODO: bug
			;; (setq TeX-view-program-list '(("Emacs" "emacsclient %o")))
			;; (setq TeX-view-program-selection '((output-pdf "Emacs")))
			;;
			(TeX-source-correlate-mode)
			(server-force-delete)  ;; WARNING: Kills any existing edit server
			(setq TeX-source-correlate-method 'synctex
				  TeX-source-correlate-start-server t)
			;;
			(bind-keys :map LaTeX-mode-map
					   ;; default C-c C-e rebound and cannot be rebound
					   ("C-c C-x e" . LaTeX-environment)
					   ("C-c C-x s" . LaTeX-section)
					   ("C-c C-x m" . TeX-insert-macro)
					   ("C-x C-s" . LaTeX-save-and-compile)
					   ;; default C-c. not working and replaced by org-time-stamp
					   ("C-c m" . LaTeX-mark-environment)
					   ;; ("<tab>" . TeX-complete-symbol)
					   ("M-<return>" . LaTeX-insert-item)
					   )))
(setq LaTeX-command-section-level t)
;; C-c C-c without prompt, use Clean by default, to clean aux and log files
;; Use "Clean All" to clean files including generated pdf file
;; Or use M-x Tex-clean (Clean) and prefix(Clean All)
;; (setq TeX-command-force "Clean")
(setq TeX-clean-confirm nil)
;; RefTex -- built-in
;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)
;; magic-latex-buffer
;; (require 'magic-latex-buffer)
;; (add-hook 'LaTeX-mode-hook 'magic-latex-buffer)
(setq
 ;; Function for reading \includegraphics files
 LaTeX-includegraphics-read-file 'LaTeX-includegraphics-read-file-relative
 ;; Strip known extensions from image file name
 LaTeX-includegraphics-strip-extension-flag nil)
;; (setq LaTeX-section-hook
;;		  '(LaTeX-section-heading
;;			LaTeX-section-title
;;			LaTeX-section-toc
;;			LaTeX-section-section
;;			LaTeX-section-label))


(provide 'init-tex)
