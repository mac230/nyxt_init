;; my init.lisp for nyxt 2.0 - 2020.09.24

(in-package #:nyxt)

;; ;; no session restore (for now)
(define-configuration browser
  ((session-restore-prompt :never-restore)))

;; ;; QWERTY home row hints only
(define-configuration nyxt/web-mode:web-mode
  ((nyxt/web-mode:hints-alphabet "DSJKHLFAGNMXCWEIO")
   (glyph "ω")))

;; ;; turn off the preview of buffers during switch buffer
(define-configuration buffer-source
  ((prompter:follow-p nil)))

;; drop my custom keybindings into a mode
(defvar *my-keymap* (make-keymap "my-map")
  "Keymap for `my-mode'.")

(define-mode my-mode ()
  "Dummy mode for the custom key bindings in `*my-keymap*'."
  ((keymap-scheme (keymap:make-scheme
                   scheme:emacs *my-keymap*
                   scheme:vi-normal *my-keymap*))))

;; my commands for scrolling in smaller increments than the default
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

;; 2021.06.06 update to new nyxt version
(define-command mac-previous-buffer ()
  "My command for switching to a previous buffer."
  (set-current-buffer (second (sort-by-time (buffer-list))))
  )

;; access resources from the umn library 
(define-command umn-proxy-bookmarklet-jump ()
  "Open a command using the umn libraries system."
  (buffer-load 
   (str:concat
    "http://login.ezproxy.lib.umn.edu/login?url=" 
    (render-url (url (current-buffer))))))

(define-command engine-mode-emulator ()
  "Function for emulating emacs engine-mode in nyxt."
  (let ((entry (first (prompt
                       :prompt "Which input: "
                       :sources (make-instance 'prompter:raw-source))))
        (search (first (prompt
                        :prompt "Search term: "
                        :sources (make-instance 'prompter:raw-source)))))
		(cond 
		 ((string= entry "d")
                  (make-buffer-focus :url
                   (url (str:concat "https://duckduckgo.com/?q=" search))))

		 ((string= entry "p")
                  (make-buffer-focus :url
                   (url 
		   (str:concat
		    "https://pubmed.ncbi.nlm.nih.gov/?term="
		    search
		    "&sort=pubdate&size=200"))))
                 
		 ((string= entry "g")
                  (make-buffer-focus :url
                   (url (str:concat 
                         "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
                                    search))))
                  
		 ((string= entry "m")
                  (make-buffer-focus :url
                   (url (str:concat "http://maps.google.com/maps?q="
                                    search))))
                 
		 ((string= entry "w")
		  (make-buffer-focus :url
		   (url (str:concat
		    "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search="
		    search))))
                 
		 ((string= entry "y")
		  (make-buffer-focus :url
		   (url (str:concat
		    "https://www.yeastgenome.org/search?q="
		    search
		    "&is_quick=true"))))
                 
		 ((string= entry "h")
		  (make-buffer-focus :url
		   (url (str:concat
		    "https://github.com/search?ref=simplesearch&q="
		    search))))

		 (t
		  (make-buffer-focus :url
		   (url (str:concat
		    "https://duckduckgo.com/?q="
		    search)))))
		))

(define-command engine-mode-emulator-same-buffer ()
  "Function for emulating emacs engine-mode in nyxt."
  (let ((entry (first (prompt
                       :prompt "Which input: "
                       :sources (make-instance 'prompter:raw-source))))
        (search (first (prompt
                        :prompt "Search term: "
                        :sources (make-instance 'prompter:raw-source)))))
		(cond 
		 ((string= entry "d")
                  (buffer-load 
                   (url (str:concat "https://duckduckgo.com/?q=" search))))

		 ((string= entry "p")
                  (buffer-load 
                   (url 
		   (str:concat
		    "https://pubmed.ncbi.nlm.nih.gov/?term="
		    search
		    "&sort=pubdate&size=200"))))
                 
		 ((string= entry "g")
                  (buffer-load 
                   (url (str:concat 
                         "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
                                    search))))
                  
		 ((string= entry "m")
                  (buffer-load 
                   (url (str:concat "http://maps.google.com/maps?q="
                                    search))))
                 
		 ((string= entry "w")
		  (buffer-load 
		   (url (str:concat
		    "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search="
		    search))))
                 
		 ((string= entry "y")
		  (buffer-load 
		   (url (str:concat
		    "https://www.yeastgenome.org/search?q="
		    search
		    "&is_quick=true"))))
                 
		 ((string= entry "h")
		  (buffer-load 
		   (url (str:concat
		    "https://github.com/search?ref=simplesearch&q="
		    search))))

		 (t
		  (buffer-load 
		   (url (str:concat
		    "https://duckduckgo.com/?q="
		    search)))))
		))

(define-key *my-keymap* "C-tab"   'switch-buffer)
(define-key *my-keymap* "M-x"     'execute-command)
(define-key *my-keymap* "M-j"     'nyxt/web-mode:follow-hint-new-buffer-focus)
(define-key *my-keymap* "C-c t"   'nyxt/web-mode:scroll-to-bottom)
(define-key *my-keymap* "C-c M-t" 'nyxt/web-mode:scroll-to-top)
(define-key *my-keymap* "C-,"     'nyxt/web-mode:jump-to-heading)
(define-key *my-keymap* "C-i"     'set-url-new-buffer)
(define-key *my-keymap* "C-w"     'nyxt/web-mode:copy)
(define-key *my-keymap* "M-w"     'copy-url)
(define-key *my-keymap* "C-l"     'set-url)
(define-key *my-keymap* "M-z"     'mac-scroll-up)
(define-key *my-keymap* "M-v"     'mac-scroll-down)
(define-key *my-keymap* "C-h l"   'nyxt/buffer-listing-mode::list-buffers)
(define-key *my-keymap* "C-."     'mac-previous-buffer)
(define-key *my-keymap* "C-x ."   'engine-mode-emulator)
(define-key *my-keymap* "C-c ."   'engine-mode-emulator-same-buffer)
(define-key *my-keymap* "C-c h"   'nyxt/web-mode:history-all-query)
(define-key *my-keymap* "C-z"     'store-history-by-name)

(define-command mac-quick-url-new-buffer-jump ()
  "Jump to websites I use frequently via simple key press."
(let ((entry (first (prompt
                     :prompt "Which input: "
                     :sources (make-instance 'prompter:raw-source)))))
    (cond
     ((string= entry "d")
      (make-buffer-focus :url (url "https://www.duckduckgo.com")))
     ((string= entry "g")
      (make-buffer-focus :url (url "https://www.google.com")))
     ((string= entry "w")
      (make-buffer-focus :url (url "https://www.wikipedia.org/")))
     ((string= entry "w")
      (make-buffer-focus :url (url "https://www.wikipedia.org/")))
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

(define-command mac-quick-url-same-buffer-jump ()
  "Jump to websites I use frequently via simple key press."
  (let ((entry (first (prompt
                       :prompt "Which input: "
                       :sources (make-instance 'prompter:raw-source)))))
    (cond
     ((string= entry "d")
      (buffer-load (url "https://www.duckduckgo.com")))
     ((string= entry "g")
      (buffer-load (url "https://www.google.com")))
     ((string= entry "w")
      (buffer-load (url "https://www.wikipedia.org/")))
     ((string= entry "w")
      (buffer-load (url "https://www.wikipedia.org/")))
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
     ((string= entry "m")
      (buffer-load "https://maps.google.com/"))
     ((string= entry "q")
      (buffer-load "https://app.quartzy.com"))
     (t
      (set-url-new-buffer)))
    ))

(define-configuration (buffer web-buffer nosave-buffer)
  ((default-modes (append '(my-mode
                            emacs-mode)
                          %slot-default%))))
