; Path: utkcs2!emory!swrinde!cs.utexas.edu!yale!cs.yale.edu!newsbase!choo
; >From: choo@cs.yale.edu (young-il choo)
; Newsgroups: comp.emacs
; Subject: Re: Editing multiple buffers and rotating between them
; Date: 7 Aug 90 23:39:19 GMT
; References: <236@jabberwock.shs.ohio-state.edu>
; Organization: Computer Science Yale University New Haven CT 06520-2158
; Nntp-Posting-Host: aqua.systemsx.cs.yale.edu
; 
; 
; > If I call emacs with, say, 5 file names:
; 
; > 	%emacs f1 f2 f3 f4 f5
; 
; > ...
; 
; > Rather, I'd like it to switch circularly through the whole list:
; > f5->f4->f3->f2->f1->f5->...
; > I wonder if this feature is not built in. 
; > Does someone know how to program it as key binding, e.g.
; > via key board macro definition?
; 
; > Thanks in advance for any hints
; 
; >  - Reiner
; 
; Note:
; 
; 'bury-buffer is the primitive that cycles through the buffers in one
;    direction (while ignoring insignificant buffers)
; 
; 'yic-next-buffer is a simple function to cycle through the other way.  It
;    even displays buffers that are usually ignored, since I don't bother to
;    check them.
; 
; 'yic-other-buffer changes to the default other buffer, without waiting for a
;    RET
; 
; 'yic-kill-current-buffer kills current buffer.
; 
; I use these all the time to move back and forth between buffers, and also the
; ability to kill buffers easily is great when I am in dired-mode.
; 
; Hope this helps.
; 
; --  Young-il Choo
; 
;     Yale Computer Science  New Haven  CT 06520-2158
;     choo-young-il@yale.edu
; 
; 
; Put the following in your .emacs:
; 
(global-set-key "\C-x\C-p" 'bury-buffer)
(global-set-key "\C-x\C-n" 'yic-next-buffer)
;;(global-set-key "\C-x\C-o" 'yic-other-buffer)
(global-set-key "\C-x\C-k" 'yic-kill-current-buffer)

(defun yic-next-buffer ()
  "Switch to previous buffer in current window."
  (interactive)
  (switch-to-buffer (car (reverse (buffer-list)))))

(defun yic-other-buffer ()
  "Switch to the other buffer (2nd in list-buffer) in current window."
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun yic-kill-current-buffer ()
  "Kill current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

;; end
