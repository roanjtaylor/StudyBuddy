;;;; L4 — Model. One function talks to the relay; a macro defines prompts as data;
;;;; structured answers come back as plists so the UI never sees free prose.
;;;;
;;;; Calls go through the ClaudeSubscription relay (projects/z_hf-space), which runs
;;;; the Claude Agent SDK on the owner's subscription rather than metered API
;;;; credit. POST /api/agent, SSE back; with `outputFormat` the validated object
;;;; arrives in a `structured` event.
;;;;
;;;;   (defprompt check-explanation :system "…" :schema (:object (:right (:array :string)) …))
;;;;   (ask-structured 'check-explanation "Idea: … Learner wrote: …")  → plist
;;;;   (ask 'some-prompt "…")                                          → string
;;;;   (ask-with-search 'hunt-sources "…")                             → plist
;;;;
;;;; The conversation is the one call that streams: the reply arrives as it is written,
;;;; and the model acts through TOOLS the app defines (deftool) — the relay sends each
;;;; call down the stream, the app runs it and posts the answer back, the run goes on.
;;;;
;;;;   (deftool add-nodes "Add ideas to the map" (:object (:nodes (:array …))) (input) …)
;;;;   (converse messages :system "…" :tools '(add-nodes …) :on-event (lambda (name data) …))

(in-package :studybuddy)

(defvar *server-url* "https://roanjtaylor-claudesubscription.hf.space"
  "The relay. STUDYBUDDY_SERVER_URL overrides at start.")
(defvar *app-secret* nil
  "Sent as x-app-secret. STUDYBUDDY_APP_SECRET; read at start, never from a file.")
(defvar *model* "claude-opus-4-8"
  "Any model the subscription can use; the relay's /api/models lists them live.")
(defparameter *models*
  '(("claude-opus-4-8" "Opus 4.8")
    ("claude-fable-5-1" "Fable 5.1")
    ("claude-opus-5-5" "Opus 5.5")
    ("claude-sonnet-5-5" "Sonnet 5.5")
    ("claude-haiku-5-5" "Haiku 5.5"))
  "(id label) for the model picker; the relay rejects any the subscription cannot use.")
(defparameter *efforts* '("low" "medium" "high"))
(defvar *effort* "medium"
  "Default reasoning effort, as Claude Code's: \"low\" \"medium\" \"high\" — passed to the relay.")

;; The model last used (kept in the settings store), else the built-in default.
(defun preferred-model ()
  (let ((saved (setting "model")))
    (if (and saved (assoc saved *models* :test #'equal)) saved *model*)))
(defun pick-model (id) (if (assoc id *models* :test #'equal) id (preferred-model)))
;; Call when a model is actually used: it becomes the default everywhere.
(defun remember-model! (id)
  (unless (equal id (setting "model")) (set-setting! "model" id))
  id)
(defun pick-effort (e) (if (member e *efforts* :test #'equal) e *effort*))
(defvar *llm-timeout* 1800 "Seconds to wait for one answer. Web-searched calls are slow.")
(defvar *prompts* (make-hash-table) "name → (:system … :schema …)")
(defvar *tools* (make-hash-table) "name → (:name \"add_nodes\" :description … :schema … :fn …)")
(defvar *last-response* nil "Raw SSE events of the last call, for debugging at the REPL.")

(defun configure-llm ()
  (let ((url (uiop:getenv "STUDYBUDDY_SERVER_URL"))
        (secret (uiop:getenv "STUDYBUDDY_APP_SECRET")))
    (when url (setf *server-url* (string-right-trim "/" url)))
    (when secret (setf *app-secret* secret))))

(define-condition llm-error (error)
  ((message :initarg :message :reader llm-error-message)
   (body :initarg :body :initform nil :reader llm-error-body))
  (:report (lambda (c s)
             (format s "LLM call failed: ~a~@[~%~a~]" (llm-error-message c) (llm-error-body c)))))

(defun llm-fail (message &optional body)
  (error 'llm-error :message message :body body))

;;; ---- Prompts as data ---------------------------------------------------

(defmacro defprompt (name &key system schema)
  `(progn (setf (gethash ',name *prompts*) (list :system ,system :schema ',schema))
          ',name))

(defun prompt (name)
  (or (gethash name *prompts*) (error "No prompt named ~s" name)))

;;; ---- Tools as data -----------------------------------------------------

;; A tool is a function the model may call mid-answer. The Lisp name add-nodes is shown
;; to the model as add_nodes; the body gets the call's input as a plist (keys are
;; keywords, see json->lisp) and returns the text the model reads back.
;;
;;   (deftool remove-nodes "Remove ideas from the map." (:object (:ids (:array :string)))
;;     (input)
;;     (format nil "Removed ~a" (getf input :ids)))
(defmacro deftool (name description schema (input) &body body)
  `(progn (setf (gethash ',name *tools*)
                (list :name ,(substitute #\_ #\- (lower name))
                      :description ,description
                      :schema ',schema
                      :fn (lambda (,input) (declare (ignorable ,input)) ,@body)))
          ',name))

(defun tool (name)
  (or (gethash name *tools*) (error "No tool named ~s" name)))

(defun tool-manifest (names)
  (coerce (mapcar (lambda (n) (let ((tl (tool n)))
                                (obj "name" (getf tl :name)
                                     "description" (getf tl :description)
                                     "inputSchema" (schema->json (getf tl :schema)))))
                  names)
          'vector))

;; (run-tool '(add-nodes …) "add_nodes" input) → the text to hand back, and whether it failed.
(defun run-tool (names wire-name input)
  (let ((tl (loop for n in names for tl = (tool n)
                  when (equal (getf tl :name) wire-name) return tl)))
    (if (null tl)
        (values (str "No tool named " wire-name) t)
        (handler-case (values (princ-to-string (funcall (getf tl :fn) input)) nil)
          (error (e) (values (str "The tool failed: " e) t))))))

;;; ---- JSON ↔ Lisp -------------------------------------------------------

;; (obj "a" 1 "b" 2) → equal hash-table, which jzon writes as a JSON object.
(defun obj (&rest kvs)
  (let ((h (make-hash-table :test #'equal)))
    (loop for (k v) on kvs by #'cddr do (setf (gethash k h) v))
    h))

;; Convert a parsed JSON value to Lisp data: objects → plists with keyword keys,
;; arrays → lists, null → nil.
(defun json->lisp (x)
  (cond ((hash-table-p x)
         (let ((plist '()))
           (maphash (lambda (k v) (push (json->lisp v) plist) (push (kw k) plist)) x)
           plist))
        ((vectorp x) (if (stringp x) x (map 'list #'json->lisp x)))
        ((eq x 'null) nil)
        (t x)))

;; The other way: plists (keyword keys) → objects, other lists → arrays, nil → null.
(defun lisp->json (x)
  (cond ((null x) 'null)
        ((eq x t) t)
        ((and (consp x) (keywordp (car x)))
         (let ((h (obj)))
           (loop for (k v) on x by #'cddr do (setf (gethash (lower k) h) (lisp->json v)))
           h))
        ((consp x) (map 'vector #'lisp->json x))
        (t x)))

;;; ---- Schema ------------------------------------------------------------

;; The small s-expression schema language:
;;   :string :integer :number :boolean
;;   (:array TYPE)
;;   (:object (KEY TYPE [DESCRIPTION]) …)   — every key required …
;;   (:maybe TYPE)                          — … unless its type is wrapped in :maybe
;;   (:enum "a" "b")
;; (schema->json '(:object (:n :integer))) → hash-table ready for jzon.
(defun schema->json (s)
  (cond ((member s '(:string :integer :number :boolean))
         (obj "type" (lower s)))
        ((and (consp s) (eq (car s) :maybe))
         (schema->json (second s)))
        ((and (consp s) (eq (car s) :array))
         (obj "type" "array" "items" (schema->json (second s))))
        ((and (consp s) (eq (car s) :enum))
         (obj "type" "string" "enum" (coerce (cdr s) 'vector)))
        ((and (consp s) (eq (car s) :object))
         (let ((props (obj)) (required '()))
           (dolist (p (cdr s))
             (destructuring-bind (key type &optional description) p
               (let ((json (schema->json type)) (name (lower key)))
                 (when description (setf (gethash "description" json) description))
                 (setf (gethash name props) json)
                 (unless (and (consp type) (eq (car type) :maybe))
                   (push name required)))))
           (obj "type" "object"
                "properties" props
                "required" (coerce (nreverse required) 'vector)
                "additionalProperties" nil)))
        (t (error "Bad schema form: ~s" s))))

;;; ---- SSE ---------------------------------------------------------------

;; (parse-sse "event: a\ndata: {}\n\n") → (("a" . "{}"))
(defun parse-sse (text)
  (let ((events '()) (event nil) (data '()))
    (flet ((flush ()
             (when (or event data)
               (push (cons event (join #\Newline (nreverse data))) events))
             (setf event nil data '())))
      (dolist (line (lines text))
        (cond ((string= line "") (flush))
              ((prefix-p "event:" line) (setf event (trim (subseq line 6))))
              ((prefix-p "data:" line) (push (trim (subseq line 5)) data))))
      (flush))
    (nreverse events)))

(defun sse-events (events name)
  (loop for (e . d) in events when (equal e name) collect (jzon:parse d)))

;; An SSE parser fed one line at a time: calls FN with (name data-string) per event.
(defun make-sse-parser (fn)
  (let ((event nil) (data '()))
    (lambda (line)
      (cond ((null line)                ; end of stream
             (when (or event data) (funcall fn (or event "message") (join #\Newline (nreverse data)))))
            ((string= line "")
             (when (or event data) (funcall fn (or event "message") (join #\Newline (nreverse data))))
             (setf event nil data '()))
            ((prefix-p "event:" line) (setf event (trim (subseq line 6))))
            ((prefix-p "data:" line) (push (trim (subseq line 5)) data))))))

;; Octets in, UTF-8 lines out: a function of (buffer count) that calls ON-LINE for every
;; complete line; called with (nil 0) at the end it flushes the last one and says so.
(defun make-line-feeder (on-line)
  (let ((pending (make-array 256 :element-type '(unsigned-byte 8) :adjustable t :fill-pointer 0)))
    (lambda (buf n)
      (if (null buf)
          (progn (when (> (fill-pointer pending) 0)
                   (funcall on-line (string-right-trim '(#\Return) (flex:octets-to-string pending :external-format :utf-8))))
                 (funcall on-line nil))
          (loop for i below n for b = (aref buf i)
                do (if (= b 10)
                       (progn (funcall on-line (string-right-trim '(#\Return) (flex:octets-to-string pending :external-format :utf-8)))
                              (setf (fill-pointer pending) 0))
                       (vector-push-extend b pending)))))))

;;; ---- A POST whose response is read as it arrives ------------------------
;;; Dexador's Windows backend (WinHTTP) reads a whole body before returning it, which
;;; would turn a stream into a wait, so on Windows the same WinHTTP calls are made here
;;; by hand and each piece goes straight to FN (buffer count). Elsewhere dexador's
;;; socket backend streams. Returns the HTTP status; a 4xx/5xx body is collected and
;;; signalled as an llm-error.

#+windows
(defun stream-post (url headers body fn)
  (let* ((uri (quri:uri url))
         (https (equalp (quri:uri-scheme uri) "https"))
         (octets (flex:string-to-octets body :external-format :utf-8)))
    (winhttp:with-http (session "studybuddy")
      (winhttp:with-connect (conn session (quri:uri-host uri) (or (quri:uri-port uri) (if https 443 80)))
        (winhttp:with-request (req conn :verb :post :url (or (quri:uri-path uri) "/") :https-p https)
          (dolist (h headers) (winhttp:add-request-headers req (format nil "~a: ~a" (car h) (cdr h))))
          (winhttp::set-timeouts req :connect 60000 :send 60000 :recv (* 1000 *llm-timeout*))
          (winhttp:send-request req octets)
          (winhttp:receive-response req)
          (let ((status (winhttp:query-status-code req))
                (buf (make-array 8192 :element-type '(unsigned-byte 8)))
                (failed '()))
            ;; WinHttpReadData waits to fill the whole buffer it is given, so ask what
            ;; has arrived and read exactly that: each piece then comes out as it lands.
            (loop for avail = (winhttp:query-data-available req)
                  until (zerop avail)
                  do (let ((n (winhttp:read-data req buf :end (min avail (length buf)))))
                       (when (zerop n) (return))
                       (if (< status 400)
                           (funcall fn buf n)
                           (push (flex:octets-to-string (subseq buf 0 n) :external-format :utf-8) failed))))
            (when (>= status 400)
              (llm-fail (format nil "HTTP ~a from ~a" status *server-url*) (join "" (nreverse failed))))
            (funcall fn nil 0)
            status))))))

#-windows
(defun stream-post (url headers body fn)
  (let ((in (handler-case
                (dex:post url :headers headers :content body
                          :connect-timeout 60 :read-timeout *llm-timeout*
                          :want-stream t :force-binary t :use-connection-pool nil)
              (dex:http-request-failed (e)
                (llm-fail (format nil "HTTP ~a from ~a" (dex:response-status e) *server-url*)
                          (dex:response-body e)))))
        (one (make-array 1 :element-type '(unsigned-byte 8))))
    (unwind-protect
         (loop for b = (read-byte in nil :eof)
               until (eq b :eof)
               do (setf (aref one 0) b) (funcall fn one 1)
               finally (funcall fn nil 0))
      (ignore-errors (close in)))
    200))

;;; ---- The one request ---------------------------------------------------

(defun relay-headers ()
  (append '(("content-type" . "application/json"))
          (when *app-secret* `(("x-app-secret" . ,*app-secret*)))))

;; One POST to the relay. Returns the parsed SSE events; signals llm-error with the
;; HTTP body attached on any failure.
(defun relay-request (user-text &key system schema search (max-turns 10))
  (let ((body (obj "messages" (vector (obj "role" "user" "content" user-text))
                   "model" *model*
                   "maxTurns" max-turns
                   "builtinTools" (if search (vector "WebSearch" "WebFetch") (vector))
                   "thinkingDisplay" "omitted")))
    (when system (setf (gethash "systemPrompt" body) system))
    (when *effort* (setf (gethash "effort" body) *effort*))
    (when schema
      (setf (gethash "outputFormat" body)
            (obj "type" "json_schema" "schema" (schema->json schema))))
    (let ((text (handler-case
                    (dex:post (str *server-url* "/api/agent")
                              :headers (relay-headers)
                              :content (jzon:stringify body)
                              :connect-timeout 60
                              :read-timeout *llm-timeout*)
                  (dex:http-request-failed (e)
                    (llm-fail (format nil "HTTP ~a from ~a" (dex:response-status e) *server-url*)
                              (dex:response-body e)))
                  (error (e) (llm-fail (princ-to-string e))))))
      (let ((events (parse-sse text)))
        (setf *last-response* events)
        (let ((err (first (sse-events events "error"))))
          (when err (llm-fail (gethash "error" err))))
        events))))

;;; ---- The streaming request: a conversation with tools ------------------

;; (converse messages …) — MESSAGES is a list of (:role "user"|"assistant" :content "…"),
;; newest last. Each relay event is passed to ON-EVENT as (name data) where data is the
;; parsed JSON (a hash-table); the app renders them as it likes. Tool calls are answered
;; from TOOLS (deftool names) before the model carries on. Returns the full reply text.
(defun converse (messages &key system tools on-event (model *model*) (effort *effort*) (max-turns 40))
  (let ((body (obj "messages" (coerce (mapcar (lambda (m) (obj "role" (getf m :role) "content" (getf m :content)))
                                              messages)
                                      'vector)
                   "model" model
                   "maxTurns" max-turns
                   "builtinTools" (vector "WebSearch" "WebFetch")
                   "toolTimeoutMs" 60000
                   "previewChars" 200
                   "thinkingDisplay" "summarized"))
        (run-id nil) (reply '()) (error-text nil) (after-tool nil))
    (when system (setf (gethash "systemPrompt" body) system))
    (when effort (setf (gethash "effort" body) effort))
    (when tools (setf (gethash "tools" body) (tool-manifest tools)))
    (flet ((handle (name data-text)
             (let ((data (handler-case (jzon:parse data-text) (error () (obj)))))
               ;; Words before a tool call and words after it are separate paragraphs, not one run-on.
               (when (and (equal name "delta") after-tool)
                 (setf after-tool nil)
                 (let ((s (gethash "text" data)))
                   (when (and reply (stringp s) (plusp (length s))
                              (not (member (char s 0) '(#\Newline #\Return))))
                     (setf (gethash "text" data) (str (format nil "~%~%") s)))))
               (when (member name '("tool_request" "tool_call") :test #'equal)
                 (setf after-tool t))
               (cond ((equal name "run") (setf run-id (gethash "runId" data)))
                     ((equal name "delta") (push (gethash "text" data) reply))
                     ((equal name "error") (setf error-text (gethash "error" data)))
                     ((equal name "tool_request")
                      (multiple-value-bind (text failed)
                          (run-tool tools (gethash "name" data) (json->lisp (gethash "input" data)))
                        (answer-tool-call run-id (gethash "callId" data) text failed))))
               (when on-event (funcall on-event name data)))))
      (handler-case
          (stream-post (str *server-url* "/api/agent") (relay-headers) (jzon:stringify body)
                       (make-line-feeder (make-sse-parser #'handle)))
        (llm-error (e) (error e))
        (error (e) (llm-fail (princ-to-string e))))
      (when error-text (llm-fail error-text))
      (join "" (nreverse reply)))))

(defun answer-tool-call (run-id call-id text failed)
  (handler-case
      (dex:post (str *server-url* "/api/agent/tool-result")
                :headers (relay-headers)
                :content (jzon:stringify (obj "runId" run-id "callId" call-id
                                              "text" text "isError" (and failed t)))
                :connect-timeout 30 :read-timeout 60)
    (error (e) (format *error-output* "~&tool answer failed: ~a~%" e))))

;;; ---- The three asks ----------------------------------------------------

;; Plain call, returns the model's text.
(defun ask (name user-text &key search)
  (let* ((p (prompt name))
         (events (relay-request user-text :system (getf p :system) :search search
                                          :max-turns (if search 30 10))))
    (join "" (mapcar (lambda (d) (gethash "text" d)) (sse-events events "delta")))))

;; Structured call: the prompt's schema is enforced by the engine and the validated
;; object comes back as a plist. No tool output → error, never prose parsing.
(defun ask-structured (name user-text &key search)
  (let* ((p (prompt name))
         (schema (or (getf p :schema) (error "Prompt ~s has no schema" name)))
         (events (relay-request user-text :system (getf p :system) :schema schema
                                          :search search
                                          :max-turns (if search 30 10)))
         (structured (first (sse-events events "structured"))))
    (unless structured
      (llm-fail "The model returned no structured output"
                (join "" (mapcar (lambda (d) (gethash "text" d)) (sse-events events "delta")))))
    (json->lisp (gethash "output" structured))))

;; Same, with web search on — for source hunting and map seeding.
(defun ask-with-search (name user-text)
  (ask-structured name user-text :search t))
