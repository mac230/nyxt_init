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
    (object-string (url (current-buffer))))
   :buffer (current-buffer)))

(define-command mac-quick-url-new-buffer-jump ()
  "Open frequently-used urls using single letters in the minibuffer."
  (let ((entry (prompt-minibuffer
                 :input-prompt "which entry: "
                 :default-modes '(set-url-mode minibuffer-mode)
                 :must-match-p nil)))
	       (cond
		((string= entry "d")
                 (make-buffer-focus :url "https://www.duckduckgo.com"))
		((string= entry "g")
                 (make-buffer-focus :url "https://www.google.com"))
		((string= entry "p")
                 (make-buffer-focus :url "https://pubmed.ncbi.nlm.nih.gov/"))
		((string= entry "w")
                 (make-buffer-focus :url "https://www.wikipedia.org/"))
		((string= entry "v")
                 (make-buffer-focus :url "https://www.biorxiv.org/"))
		((string= entry "s")
                 (make-buffer-focus :url "https://thealbertlab.slack.com"))
		((string= entry "r")
                 (make-buffer-focus :url "https://dmrinnovations.slack.com"))
		((string= entry "n")
                 (make-buffer-focus :url "https://projectreporter.nih.gov/reporter.cfm"))
		((string= entry "y")
                 (make-buffer-focus :url "https://yeastgenome.org/"))
		((string= entry "h")
                 (make-buffer-focus :url "https://github.com/"))
                ((string= entry "m")
                 (make-buffer-focus :url "https://maps.google.com/"))
                ((string= entry "q")
                 (make-buffer-focus :url "https://app.quartzy.com"))
		(t
		 (set-url-new-buffer)))
	       ))

(define-command mac-quick-url-jump ()
  "Open frequently-used urls using single letters in the minibuffer."
  (let ((entry (prompt-minibuffer
                 :input-prompt "which entry: "
                 :default-modes '(set-url-mode minibuffer-mode)
                 :must-match-p nil)))
	       (cond
		((string= entry "d")
		 (buffer-load "https://www.duckduckgo.com" :buffer (current-buffer)))
		((string= entry "g")
		 (buffer-load "https://www.google.com" :buffer (current-buffer)))
		((string= entry "p")
		 (buffer-load "https://pubmed.ncbi.nlm.nih.gov/" :buffer (current-buffer)))
		((string= entry "w")
		 (buffer-load "https://www.wikipedia.org/" :buffer (current-buffer)))
		((string= entry "v")
		 (buffer-load "https://www.biorxiv.org/" :buffer (current-buffer)))
		((string= entry "s")
		 (buffer-load "https://thealbertlab.slack.com" :buffer (current-buffer)))
		((string= entry "r")
		 (buffer-load "https://dmrinnovations.slack.com" :buffer (current-buffer)))
                ((string= entry "m")
		 (buffer-load "https://maps.google.com" :buffer (current-buffer)))
		((string= entry "n")
		 (buffer-load "https://projectreporter.nih.gov/reporter.cfm" :buffer (current-buffer)))
		((string= entry "y")
		 (buffer-load "https://yeastgenome.org/" :buffer (current-buffer)))
		((string= entry "h")
		 (buffer-load "https://github.com/" :buffer (current-buffer)))
                ((string= entry "q")
		 (buffer-load "https://app.quartzy.com" :buffer (current-buffer)))
		(t
		 (set-url :new-buffer-p nil :prefill-current-url-p nil))
	       )))

(define-command engine-mode-emulator ()
  "Function for emulating emacs engine-mode in nyxt."
  (let ((entry (prompt-minibuffer
              :input-prompt "which entry: "
              :default-modes '(set-url-mode minibuffer-mode)
              :must-match-p nil))
        (search (prompt-minibuffer
              :input-prompt "search term: "
              :default-modes '(set-url-mode minibuffer-mode)
              :must-match-p nil)))
		(cond 
		 ((string= entry "d")
                  (make-buffer-focus :url
		   (str:concat
		    "https://duckduckgo.com/?q="
		    search)))
		 ((string= entry "p")
		  (make-buffer-focus :url
		   (str:concat
		    "https://pubmed.ncbi.nlm.nih.gov/?term="
		    search
		    "&size=200")))
		 ((string= entry "g")
		  (make-buffer-focus :url
		   (str:concat
		    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
		    search)))
		 ((string= entry "m")
		  (make-buffer-focus :url
		   (str:concat
		    "http://maps.google.com/maps?q="
		    search)))
		 ((string= entry "w")
		  (make-buffer-focus :url
		   (str:concat
		    "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search="
		    search)))
		 ((string= entry "y")
		  (make-buffer-focus :url
		   (str:concat
		    "https://www.yeastgenome.org/search?q="
		    search
		    "&is_quick=true")))
		 ((string= entry "h")
		  (make-buffer-focus :url
		   (str:concat
		    "https://github.com/search?ref=simplesearch&q="
		    search)))
		 (t
		  (make-buffer-focus :url
		   (str:concat
		    "https://duckduckgo.com/?q="
		    search))))
		))

(define-command same-buffer-engine-mode-emulator ()
  "Function for emulating emacs engine-mode in nyxt that loads queries in the
current buffer."
(let ((entry (prompt-minibuffer
              :input-prompt "which entry: "
              :default-modes '(set-url-mode minibuffer-mode)
              :must-match-p nil))
      (search (prompt-minibuffer
              :input-prompt "search term: "
              :default-modes '(set-url-mode minibuffer-mode)
              :must-match-p nil)))
		(cond 
		 ((string= entry "d")
		  (buffer-load
		   (str:concat
		    "https://duckduckgo.com/?q="
		    search)
                 :buffer (current-buffer)))
		 ((string= entry "p")
		  (buffer-load
		   (str:concat
		    "https://pubmed.ncbi.nlm.nih.gov/?term="
		    search
		    "&size=200")
                  :buffer (current-buffer)))
		 ((string= entry "g")
		  (buffer-load
		   (str:concat
		    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
		    search)
                   :buffer (current-buffer)))
		 ((string= entry "m")
		  (buffer-load
		   (str:concat
		    "http://maps.google.com/maps?q="
		    search)
                   :buffer (current-buffer)))
		 ((string= entry "w")
		  (buffer-load
		   (str:concat
		    "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search="
		    search)
                   :buffer (current-buffer)))
		 ((string= entry "y")
		  (buffer-load
		   (str:concat
		    "https://www.yeastgenome.org/search?q="
		    search
		    "&is_quick=true")
                   :buffer (current-buffer)))
		 ((string= entry "h")
		  (buffer-load
		   (str:concat
		    "https://github.com/search?ref=simplesearch&q="
		    search)
                   :buffer (current-buffer)))
		 (t
		  (buffer-load
		   (str:concat
		    "https://duckduckgo.com/?q="
		    search)
                   :buffer (current-buffer))))
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
  "C-i"   'mac-quick-url-new-buffer-jump
  "C-w"   'nyxt/web-mode:copy
  "M-w"   'copy-url
  "M-z"   'mac-scroll-up
  "M-v"   'mac-scroll-down
  "C-l"   'mac-quick-url-jump
  "C-c ." 'same-buffer-engine-mode-emulator
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
