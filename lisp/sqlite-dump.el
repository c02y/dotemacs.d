;;; sqlite-dump.el --- view dump of sqlite database file

;; Copyright 2009, 2010, 2011, 2013, 2014 Kevin Ryde

;; Author: Kevin Ryde <user42_kevin@yahoo.com.au>
;; Version: 9
;; Keywords: data, sqlite
;; EmacsWiki: SQLite
;; URL: http://user42.tuxfamily.org/sqlite-dump/index.html

;; sqlite-dump.el is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by the
;; Free Software Foundation; either version 3, or (at your option) any later
;; version.
;;
;; sqlite-dump.el is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU General
;; Public License for more details.
;;
;; You can get a copy of the GNU General Public License online at
;; <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This spot of code runs the sqlite or sqlite3 program to ".dump" a
;; database file as SQL text for viewing and editing.  Put `sqlite-dump' in
;; `auto-mode-alist' to automatically visit desired files this way.
;;
;; The `buffer-file-format' mechanism is used so the SQL is re-run to save
;; changes.	 See the `sqlite-dump' docstring for details.

;;; Install:

;; To make M-x sqlite-dump available, put sqlite-dump.el in one of your
;; `load-path' directories and the following in your .emacs
;;
;;	   (autoload 'sqlite-dump "sqlite-dump" nil t)
;;
;; To have it automatically on for instance .sqlite files (per various
;; mozilla family browsers) then add
;;
;;	   (modify-coding-system-alist 'file "\\.sqlite\\'" 'raw-text-unix)
;;	   (add-to-list 'auto-mode-alist '("\\.sqlite\\'" . sqlite-dump))
;;
;; There's autoload tags below for the function if you use
;; `update-file-autoloads' and friends (or use `M-x package-install').	The
;; coding and auto-mode-alist are not autoloaded set yet as it's not clear
;; what extension is usual, or whether a dump to visit is always what's
;; wanted.

;;; History:

;; Version 1 - the first version
;; Version 2 - add sqlite 2.x
;; Version 3 - undo defadvice on unload-feature
;; Version 4 - better write-region-post-annotation-function
;; Version 5 - express dependency on 'advice
;; Version 6 - emacs21 fix for defadvice after unload-feature
;;			 - compatibility setups for emacs20
;; Version 7 - don't delete bytes if no sqlite program
;; Version 8 - remove stray tempdir diagnostic message
;; Version 9 - fix for byte compiled eval-after-load

;;; Emacsen:

;; Designed for Emacs 21 up, works in XEmacs 21.
;;
;; Works in Emacs 20 if you have either Gnus mm-util.el or APEL poe.el for
;; `make-temp-file'.

;;; Code:

;; Explicit dependency on advice.el since `sqlite-dump-unload-function'
;; needs `ad-find-advice' macro when running not byte compiled and that
;; macro is not autoloaded.
(require 'advice)

(eval-when-compile
  (unless (and (fboundp 'mapc)
			   (fboundp 'declare))
	(require 'cl))) ;; for `mapc' in emacs20, and `declare' in emacs21

;;-----------------------------------------------------------------------------
;; compatibility

(cond ((or (eval-when-compile (fboundp 'make-temp-file))
		   (fboundp 'make-temp-file))
	   ;; emacs21 up, noticed at compile time or run time
	   (eval-and-compile
		 (defalias 'sqlite-dump--make-temp-file 'make-temp-file)))

	  ((locate-library "mm-util") ;; from gnus
	   ;; xemacs21
	   (autoload 'mm-make-temp-file "mm-util")
	   (defalias 'sqlite-dump--make-temp-file 'mm-make-temp-file))

	  ((locate-library "poe") ;; from APEL
	   ;; emacs20 with poe.el add-on
	   (require 'poe)
	   (defalias 'sqlite-dump--make-temp-file 'make-temp-file))

	  (t
	   ;; umm, dunno, hope the user can define it
	   (message "sqlite-dump-.el: don't know where to get `make-temp-file'")
	   (defalias 'sqlite-dump--make-temp-file 'make-temp-file)))

(eval-and-compile
  (defalias 'sqlite-dump--set-buffer-multibyte
	(if (eval-when-compile (fboundp 'set-buffer-multibyte))
		'set-buffer-multibyte  ;; emacs
	  'identity)))			   ;; not applicable in xemacs21


;;-----------------------------------------------------------------------------
;; mainly generic

(defmacro sqlite-dump--with-tempfile (&rest body)
  "An internal part of sqlite-dump.el.
Create a temporary file, with name in a `tempfile' variable, for
use by the BODY forms.	An `unwind-protect' ensures the file is
removed no matter what BODY does."
  (declare (debug t))
  `(let ((tempfile (sqlite-dump--make-temp-file "sqlite-dump-el-" nil)))
	 (unwind-protect
		 (progn ,@body)
	   (delete-file tempfile))))

(defmacro sqlite-dump--with-tempdbfile (&rest body)
  "An internal part of sqlite-dump.el.
Create a temporary subdirectory to hold an sqlite database.
Variable `tempdbfile' is bound to the name of the sqlite database
forsvariable for use by the BODY forms.	 An `unwind-protect'
ensures it and any associated \"-journal\" file is removed no
matter what BODY does."
  (declare (debug t))  ;; emacs22,xemacs21, or 'cl
  `(let* ((tempdir	  (sqlite-dump--make-temp-file "sqlite-dump-el-" t))
		  (tempdbfile (expand-file-name "tempdb" tempdir)))
	 ;; (message "tempdir %S" tempdir)
	 (unwind-protect
		 (progn ,@body)
	   (let ((default-directory tempdir))
		 (mapc 'delete-file
			   (delete "." (delete ".." (directory-files tempdir)))))
	   (delete-directory tempdir))))

;; quieten byte compiler pre emacs23
(defvar write-region-post-annotation-function)

(defmacro sqlite-dump--without-post-kill (&rest body)
  "An internal part of sqlite-dump.el.
Evaluate BODY without post-annotation kill-buffer.
If `write-region-post-annotation-function' is set buffer-local to
`kill-buffer' then set it to nil for BODY, and restore by an
`unwind-protect' afterwards.

This is a workaround for a bug in Emacs 23.1 where
`write-region-post-annotation-function' is set to `kill-buffer',
meaning any writes done by an encode function kill the buffer
that the encode is supposed to be operating on, usually making it
go on to mangle the contents of an unrelated buffer."

  (declare (debug t))  ;; emacs22,xemacs21, or 'cl
  `(let* ((sqlite-dump--without-post-kill--bad
		   (and (local-variable-p 'write-region-post-annotation-function
								  (current-buffer))
				(eq write-region-post-annotation-function
					'kill-buffer)))
		  (sqlite-dump--without-post-kill--buffer (current-buffer)))
	 (unwind-protect
		 (progn
		   (if sqlite-dump--without-post-kill--bad
			   (setq write-region-post-annotation-function nil))
		   ;; (message "buf	 %S" sqlite-dump--without-post-kill--buffer)
		   ;; (message " bad  %S" sqlite-dump--without-post-kill--bad)
		   ;; (message " now  %S" write-region-post-annotation-function)
		   ,@body)
	   (and sqlite-dump--without-post-kill--bad
			(buffer-live-p sqlite-dump--without-post-kill--buffer)
			(with-current-buffer sqlite-dump--without-post-kill--buffer
			  (set (make-local-variable 'write-region-post-annotation-function)
				   'kill-buffer))))))

(defun sqlite-dump-display-buffer-other-window (buffer)
  "An internal part of sqlite-dump.el.
Display BUFFER in another window.
For a new window `shrink-window-if-larger-than-buffer' is used to
set its size.  If BUFFER is already in another window then its
size is left alone."
  (save-current-buffer
	(save-selected-window
	  (let ((existing-window (get-buffer-window buffer)))
		(condition-case nil
			;; emacs two args
			(switch-to-buffer-other-window buffer t) ;; no-record
		  (error
		   ;; xemacs one arg
		   (switch-to-buffer-other-window buffer)))
		(if (not existing-window)
			(shrink-window-if-larger-than-buffer
			 (get-buffer-window buffer)))))))


;;-----------------------------------------------------------------------------

;; Error messages from sqlite3, eg.
;;	   Error: near line 1: near "fjsdk": syntax error
;;
;; There's no filename in the messages, even when ".read foo.sql" from a
;; file.  A couple of hacks below get the right buffer for
;; `sqlite-dump-encode'.
;;
(eval-after-load "compile"
  '(let ((error-elem '(sqlite-dump--sqlite3
					   "^Error: near line \\([0-9]+\\): " nil 1))
		 (file-elem	 '(sqlite-dump--filename
					   "^\\(### sqlite-dump-encode input:\\)$" 1)))
	 (eval-when-compile (require 'compile))
	 (cond
	  ((eval-when-compile (boundp 'compilation-error-regexp-systems-list))
	   ;; xemacs21
	   (add-to-list 'compilation-error-regexp-alist-alist
					(list (car error-elem)
						  '("^\\(Error: near line \\)\\([0-9]+\\): " 1 2)))
	   (compilation-build-compilation-error-regexp-alist))

	  ((eval-when-compile (boundp 'compilation-error-regexp-alist-alist))
	   ;; emacs22 up
	   (add-to-list 'compilation-error-regexp-alist-alist file-elem)
	   (add-to-list 'compilation-error-regexp-alist		  (car file-elem))
	   (add-to-list 'compilation-error-regexp-alist-alist error-elem)
	   (add-to-list 'compilation-error-regexp-alist		  (car error-elem)))

	  (t
	   ;; emacs21
	   (add-to-list 'compilation-error-regexp-alist (cdr error-elem))
	   (add-to-list 'compilation-file-regexp-alist (cdr file-elem))))))

(defvar sqlite-dump-originating-buffer nil
  "An internal part of sqlite-dump.el.
Originating SQL text buffer for *sqlite-dump-errors*.
This has a buffer-local value in the *sqlite-dump-errors* buffer.")
(make-variable-buffer-local 'sqlite-dump-originating-buffer)

(defadvice compilation-find-file (around sqlite-dump activate)
  "Use `sqlite-dump-originating-buffer' for sqlite errors."
  ;; args: (compilation-find-file MARKER FILENAME DIRECTORY &rest FORMATS)

  ;; emacs21 `unload-feature' doesn't run `sqlite-dump-unload-function' so
  ;; this defadvice remains.  `unload-feature' makes
  ;; `sqlite-dump-originating-buffer' unbound in the buffer the unload was
  ;; run from, hence check boundp to defang this code when everything else
  ;; unloaded.	(`make-variable-buffer-local' means it's still locally bound
  ;; in other buffers, and in new buffers, but probably shouldn't depend on
  ;; that after unload.)
  ;;
  (if (and (boundp 'sqlite-dump-originating-buffer) ;; in case unloaded
		   sqlite-dump-originating-buffer
		   (member (ad-get-arg 1) ;; FILENAME
				   '("### sqlite-dump-encode input:"
					 "*unknown*" ;; emacs23
					 "Error: near line "))) ;; xemacs21 hack
	  (setq ad-return-value sqlite-dump-originating-buffer)
	ad-do-it))

(defun sqlite-dump-unload-function ()
  "An internal part of sqlite-dump.el.
Remove defadvice from `compilation-find-file'.
This is called by `unload-feature'."
  (when (ad-find-advice 'compilation-find-file 'around 'sqlite-dump)
	(ad-remove-advice	'compilation-find-file 'around 'sqlite-dump)
	(ad-activate		'compilation-find-file))
  nil) ;; and do normal unload-feature actions too


;;-----------------------------------------------------------------------------

(add-to-list 'format-alist '(sqlite3-dump
							 "SQLite3 database file dump."
							 nil ;; no automatic decode
							 sqlite3-dump-decode
							 sqlite3-dump-encode
							 t	   ;; encode modifies the region
							 nil)) ;; write removes from buffer-file-formats

(add-to-list 'format-alist '(sqlite2-dump
							 "SQLite2 database file dump."
							 nil ;; no automatic decode
							 sqlite2-dump-decode
							 sqlite2-dump-encode
							 t	   ;; encode modifies the region
							 nil)) ;; write removes from buffer-file-formats

(defun sqlite2-dump-decode (beg end)
  ;; checkdoc-params: (beg end)
  "Run sqlite .dump on raw database bytes in the buffer.
This function is for use from `format-alist'."
  (sqlite-dump-decode "sqlite" 'iso-8859-1 beg end))
(defun sqlite3-dump-decode (beg end)
  ;; checkdoc-params: (beg end)
  "Run sqlite3 .dump on raw database bytes in the buffer.
This function is for use from `format-alist'."
  (sqlite-dump-decode "sqlite3" 'utf-8 beg end))

(defun sqlite2-dump-encode (beg end buffer)
  ;; checkdoc-params: (beg end buffer)
  "Run sqlite on SQL statements in the current buffer.
This function is for use from `format-alist'."
  (sqlite-dump-encode "sqlite" 'iso-8859-1 beg end buffer))
(defun sqlite3-dump-encode (beg end buffer)
  ;; checkdoc-params: (beg end buffer)
  "Run sqlite3 on SQL statements in the current buffer.
This function is for use from `format-alist'."
  (sqlite-dump-encode "sqlite3" 'utf-8 beg end buffer))

(defun sqlite-dump-decode (program coding beg end)
  ;; checkdoc-params: (program coding beg end)
  "Run PROGRAM .dump on raw database bytes in the buffer.
This is an internal part of sqlite-dump.el.

The buffer should normally be unibyte as per a `raw-text-unix'
read, but anything which writes out unchanged is acceptable.  The
bytes are put through \"sqlite3 .dump\" to get SQL text and the
buffer is then switched to multibyte.  Error messages are shown
if sqlite3 can't be run or the database contents are invalid."

  ;; if no `utf-8' coding in old Emacs then go `undecided'
  (unless (memq coding (coding-system-list))
	(setq coding 'undecided))

  (save-excursion
	(save-restriction
	  (narrow-to-region beg end)

	  (let ((buffer (current-buffer))
			status)
		(sqlite-dump--with-tempfile
		 (write-region (point-min) (point-max) tempfile nil 'quietly)

		 (with-temp-buffer
		   (let ((coding-system-for-read  coding)
				 (default-directory		  "/")
				 (process-connection-type nil)) ;; pipe
			 (setq status (call-process
						   program
						   nil	   ;; stdin /dev/null
						   t	   ;; stdout+stderr this buffer
						   nil	   ;; no redisplay
						   tempfile ".dump")))

		   ;; delete old buffer bytes, replace with SQL dump
		   (with-current-buffer buffer
			 (delete-region (point-min) (point-max))
			 (sqlite-dump--set-buffer-multibyte t))
		   (copy-to-buffer buffer (point-min) (point-max))))

		(unless (eq 0 status)
		  (if (numberp status)
			  (insert (format "\n\nexit %s" status))
			(insert "\n\n" status)))

		(point-max)))))

(defun sqlite-dump-encode (program coding beg end buffer)
  ;; checkdoc-params: (program coding beg end buffer)
  "Run sqlite3 on SQL statements in the current buffer.
This is an internal part of sqlite-dump.el.

The buffer text is put through PROGRAM to create a new database
file and its bytes replace the text, switched to unibyte."

  (sqlite-dump--without-post-kill
   (save-excursion
	 (save-restriction
	   (narrow-to-region beg end)
	   (let ((error-buffer (get-buffer-create "*sqlite-dump-errors*"))
			 status)
		 (with-current-buffer error-buffer
		   (setq buffer-read-only nil)
		   (fundamental-mode)
		   (erase-buffer))
		 (sqlite-dump--with-tempdbfile
		  (let ((default-directory "/")
				(process-connection-type nil)) ;; pipe
			(setq status (call-process-region
						  (point-min) (point-max)
						  program
						  nil			;; keep text
						  error-buffer	;; stdout+stderr to errors
						  nil			;; no redisplay
						  tempdbfile))) ;; new database

		  (if (eq 0 status)
			  (progn
				;; successful, get new database bytes
				(sqlite-dump--set-buffer-multibyte nil)
				(let ((coding-system-for-read 'raw-text-unix))
				  (insert-file-contents-literally tempdbfile
												  nil	  ;; no visit
												  nil nil ;; whole file
												  t))	  ;; replace
				(delete-windows-on error-buffer)
				(kill-buffer error-buffer)
				(point-max))

			;; error, display messages
			(with-current-buffer error-buffer
			  ;; emacs21 ignores the first two lines of a compilation-mode
			  ;; buffer, so add in dummies
			  (goto-char (point-min))
			  (if (numberp status)
				  (insert (format "exit %s\n\n" status))
				(insert (format "%s\n\n" status)))

			  ;; matched by `sqlite-dump--filename' compile pattern above
			  (insert "### sqlite-dump-encode input:\n")

			  (goto-char (point-min))
			  (sqlite-dump-display-buffer-other-window (current-buffer))
			  (compilation-mode)
			  (setq sqlite-dump-originating-buffer buffer)

			  (error "Sqlite encode error, see *sqlite-dump-errors* buffer")))))))))


;;-----------------------------------------------------------------------------

(defconst sqlite2-dump-regexp
  "\\*\\* This file contains an SQLite 2\\.1 database \\*\\*\000"
  "An internal part of sqlite-dump.el.
Regexp for the start of an SQLite 2.x format database file.
\(Actually it matches version number 2.1.  Was there a 2.0 too?)")
(defconst sqlite3-dump-regexp
  "SQLite format 3\000"
  "Regexp for the start of an SQLite 3.x format database file.")

;;;###autoload
(defun sqlite-dump ()
  "Decode an SQLite database file to SQL text.
The buffer should be raw bytes (`raw-text-unix' unibyte).

The SQL is formed by either

	sqlite .dump	  -- SQLite 2 database
	sqlite3 .dump	  -- SQLite 3 database

The transform uses the `buffer-file-format' mechanism so you can
edit the SQL and save to re-write the database.	 A save replaces
the entire file.  This is not safe if another program is
accessing it simultaneously.

\".dump\" tends to be quite forgiving of truncated or corrupt
database files.	 This is good for viewing, but doesn't tell you
if some data loss might be occurring on a re-write.

--------
For SQLite 3, the dump is utf-8 and is encoded/decoded
accordingly \(except in old Emacs without utf-8).  It's possible
to have invalid encodings in a database, for instance a binary
BLOB without blob type on the field, so check that before blaming
the dump for a bad display.

The dump includes

	PRAGMA foreign_keys=OFF

which disables foreign key constraint checking.	 This means the
order of insert statements for re-writing doesn't matter, but
also means any edits you make are not checked, so be careful.  Of
course the database might already have constraint violations,
since their enforcement is only ever optional.	Having key
constraints off allows such a database to be re-written.

As of SQLite 3.7.4 the dump doesn't include a pragma to preserve
the utf-16 flag in the database and you end up with a utf-8
database on saving.	 This makes no difference to actual
operation, but may be undesirable if it was utf-16 because that
avoided runtime conversions in a particular program.

--------
For SQLite 2, any non-ascii is assumed to be latin-1.  SQLite 2
is mostly agnostic to any single-byte superset of ascii, so the
actual characters in the database could be something else.

SQLite 2 has a compile-time SQLITE_UTF8 option affecting string
lengths etc, but it's not communicated in the dump, and a given
database may or may not have been created under that option.
Treating the dump as latin-1 will at least give something to look
at.

--------
The SQLite home page is
  URL `http://www.sqlite.org'
The sqlite-dump.el home page is
  URL `http://user42.tuxfamily.org/sqlite-dump/index.html'"

  (interactive)
  (unless (or (memq 'sqlite2-dump buffer-file-format)  ;; already decoded
			  (memq 'sqlite3-dump buffer-file-format))
	(let* ((case-fold-search nil)
		   (format (save-excursion
					 (goto-char (point-min))
					 (cond ((looking-at sqlite2-dump-regexp) 'sqlite2-dump)
						   ((looking-at sqlite3-dump-regexp) 'sqlite3-dump)
						   (t (error "Not an SQLite 2 or 3 database file"))))))
	  (let ((inhibit-read-only t))
		(format-decode-buffer format))
	  (sql-mode))))

;;------------------------------------------------------------------------------

;; LocalWords: SQLite sqlite docstring unibyte latin pragma utf encodings
;; LocalWords: runtime ascii superset el

(provide 'sqlite-dump)

;;; sqlite-dump.el ends here
