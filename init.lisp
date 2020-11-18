;; my init.lisp for nyxt 2.0 - 2020.09.24

(define-command mac-previous-buffer ()
  "My command for switching to a previous buffer."
  (set-current-buffer (car (cdr (buffer-list :sort-by-time t))))
  )

(define-command umn-proxy-bookmarklet-jump ()
  "Open a command using the umn libraries system."
  (buffer-load 
   (str:concat
    "http://login.ezproxy.lib.umn.edu/login?url=" 
    (object-string (url (current-buffer))))))

(define-command mac-new-buffer-jump (url)
"Open a frequently-used url in a new buffer."
(let ((new-buffer (make-buffer)))
  (set-current-buffer new-buffer)
  (buffer-load url)
  ))

(define-command mac-quick-url-new-buffer-jump ()
  "Open frequently-used urls using single letters in the minibuffer."
  (with-result (entry (read-from-minibuffer
                         (make-minibuffer
                          :input-prompt "Input entry"
                          :default-modes '(minibuffer-tag-mode minibuffer-mode)
                          :multi-selection-p nil)))
	       (cond
		((string= entry "d")
		 (mac-new-buffer-jump "https://www.duckduckgo.com"))
		((string= entry "g")
		 (mac-new-buffer-jump "https://www.google.com"))
		((string= entry "p")
		 (mac-new-buffer-jump "https://pubmed.ncbi.nlm.nih.gov/"))
		((string= entry "w")
		 (mac-new-buffer-jump "https://www.wikipedia.org/"))
		((string= entry "v")
		 (mac-new-buffer-jump "https://www.biorxiv.org/"))
		((string= entry "s")
		 (mac-new-buffer-jump "https://thealbertlab.slack.com"))
		((string= entry "r")
		 (mac-new-buffer-jump "https://dmrinnovations.slack.com"))
		((string= entry "n")
		 (mac-new-buffer-jump "https://projectreporter.nih.gov/reporter.cfm"))
		((string= entry "y")
		 (mac-new-buffer-jump "https://yeastgenome.org/"))
		((string= entry "h")
		 (mac-new-buffer-jump "https://github.com/"))
		(t
		 (set-url-new-buffer)))
	       ))

(define-command mac-quick-url-jump ()
  "Open frequently-used urls using single letters in the minibuffer."
  (with-result (entry (read-from-minibuffer
                         (make-minibuffer
                          :input-prompt "Input entry"
                          :default-modes '(minibuffer-tag-mode minibuffer-mode)
                          :multi-selection-p nil)))
	       (cond
		((string= entry "d")
		 (buffer-load "https://www.duckduckgo.com"))
		((string= entry "g")
		 (buffer-load "https://www.google.com"))
		((string= entry "p")
		 (buffer-load "https://pubmed.ncbi.nlm.nih.gov/"))
		((string= entry "w")
		 (buffer-load "https://www.wikipedia.org/"))
		((string= entry "v")
		 (buffer-load "https://www.biorxiv.org/"))
		((string= entry "s")
		 (buffer-load "https://thealbertlab.slack.com"))
		((string= entry "r")
		 (buffer-load "https://dmrinnovations.slack.com"))
		((string= entry "n")
		 (buffer-load "https://projectreporter.nih.gov/reporter.cfm"))
		((string= entry "y")
		 (buffer-load "https://yeastgenome.org/"))
		((string= entry "h")
		 (buffer-load "https://github.com/"))
		(t
		 (set-url)))
	       ))

(define-command engine-mode-emulator ()
  "Function for emulating emacs engine-mode in nyxt."
  (with-result* ((entry (read-from-minibuffer
                         (make-minibuffer
                          :input-prompt "Input entry"
                          :default-modes '(minibuffer-tag-mode minibuffer-mode)
                          :multi-selection-p nil)))
		 (search (read-from-minibuffer
			(make-minibuffer
			 :input-prompt "Search term"
			 :default-modes '(minibuffer-tag-mode minibuffer-mode)
			 :multi-selection-p nil))))
		(cond 
		 ((string= entry "d")
		  (mac-new-buffer-jump
		   (str:concat
		    "https://duckduckgo.com/?q="
		    search)))
		 ((string= entry "p")
		  (mac-new-buffer-jump
		   (str:concat
		    "https://pubmed.ncbi.nlm.nih.gov/?term="
		    search)))
		 ((string= entry "g")
		  (mac-new-buffer-jump
		   (str:concat
		    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
		    search)))
		 ((string= entry "m")
		  (mac-new-buffer-jump
		   (str:concat
		    "http://maps.google.com/maps?q="
		    search)))
		 ((string= entry "w")
		  (mac-new-buffer-jump
		   (str:concat
"http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search="
		    search)))
		 ((string= entry "y")
		  (mac-new-buffer-jump
		   (str:concat
		    "https://www.yeastgenome.org/search?q="
		    search
		    "&is_quick=true")))
		 ((string= entry "h")
		  (mac-new-buffer-jump
		   (str:concat
		    "https://github.com/search?ref=simplesearch&q="
		    search)))
		 (t
		  (mac-new-buffer-jump
		   (str:concat
		    "https://duckduckgo.com/?q="
		    search))))
		))

(define-command mac-scroll-down ()
  "Scroll down as I prefer."
  (nyxt/web-mode:scroll-down)
  (nyxt/web-mode:scroll-down)
  (nyxt/web-mode:scroll-down)
  (nyxt/web-mode:scroll-down)
  (nyxt/web-mode:scroll-down)
  (nyxt/web-mode:scroll-down)
  (nyxt/web-mode:scroll-down)
  )

(define-command mac-scroll-up ()
  "Scroll up as I prefer."
  (nyxt/web-mode:scroll-up)
  (nyxt/web-mode:scroll-up)
  (nyxt/web-mode:scroll-up)
  (nyxt/web-mode:scroll-up)
  (nyxt/web-mode:scroll-up)
  (nyxt/web-mode:scroll-up)
  (nyxt/web-mode:scroll-up)
  )

(defvar *mac-keymap* (make-keymap "mac-map"))
(define-key *mac-keymap*
  "C-f"   'nyxt/web-mode:history-forwards
  "C-b"   'nyxt/web-mode:history-backwards
  "C-tab" 'switch-buffer
  "M-j"   'nyxt/web-mode:follow-hint-new-buffer-focus
  "C-j"   'nyxt/web-mode:follow-hint
  "C-;"   'nyxt/web-mode:delete-backwards
  "C-i"   'mac-quick-url-new-buffer-jump
  "C-w"   'nyxt/web-mode:copy
  "M-w"   'copy-url
  "M-z"   'mac-scroll-up
  "M-v"   'mac-scroll-down
  "C-l"   'mac-quick-url-jump
  "C-x ." 'engine-mode-emulator
  "C-z"   'store-session-by-name
  "C-."   'mac-previous-buffer
  "C-,"   'nyxt/web-mode:jump-to-heading
  "C-c h" 'nyxt/web-mode:history-all-query
  "C-h l" 'list-buffers)


(define-mode mac-mode ()
  "Dummac mode for the custom key bindings in `*mac-keymap*'."
  ((keymap-scheme :initform (keymap:make-scheme
                             scheme:cua *mac-keymap*
                             scheme:emacs *mac-keymap*
                             scheme:vi-normal *mac-keymap*))))

(define-configuration buffer
  ((default-modes (append '(mac-mode emacs-mode) %slot-default))))
