;;;; L5c — Actions. One AI channel (ask) that answers and reshapes the map, one AI
;;;; check of a written explanation, one AI seed of a new field, and the plain
;;;; hand edits.

(in-package :studybuddy)

(defparameter *rules*
  "Rules you must obey:
1. Core ideas, not examples. A node is one idea with a one-sentence compression and why it matters. Favour the few ideas that generate the rest; never pad with remixes, tools or trivia.
2. Theory is learned from the originator, products by using them. When you cite, cite primary sources.
3. Nothing is understood until it has been written out and checked.")

;; Read-time available (#.) so the prompt schemas below can splice it in.
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *node-schema*
    '(:object (:id :string "lowercase slug, hyphens only")
              (:title :string "a short name for the idea, five words or fewer")
              (:compression :string "one sentence that compresses the idea")
              (:why :string "one or two sentences on why it matters")
              (:notes :string "deeper notes in markdown, grown over time; empty string when there are none")
              (:group :string "group id this node belongs to")
              (:prereqs (:array :string) "ids of ideas that must be understood first")
              (:era :integer "year the idea was first had; negative for BC; 0 if unknown"))))

;;; ---- URLs ----------------------------------------------------------------

;;; One page per field: /computers, with ?idea=ram opening an idea below it.

(defun field-url (&optional (map (map-id))) (str "/" map))
(defun group-url (group &optional (map (map-id))) (declare (ignore group)) (field-url map))
;; An idea opens below the field's timeline and outline, on the field's own page.
(defun node-url (id &optional (map (map-id))) (str "/" map "?idea=" id "#idea"))
;; Where a focus (group id, idea id, or empty) lives.
(defun focus-url (focus)
  (cond ((blankp focus) (field-url))
        ((find-group focus) (group-url focus))
        ((find-node focus) (node-url focus))
        (t (field-url))))

;;; ---- Context builders --------------------------------------------------

(defun node-context (id)
  (let* ((n (find-node id)) (g (find-group (getf n :group))))
    (str "Idea in focus: " (getf n :title) " (id " id ")" #\Newline
         "Group: " (getf n :group) " — " (getf g :compression) #\Newline
         "Compression: " (getf n :compression) #\Newline
         "Why it matters: " (getf n :why) #\Newline
         (unless (blankp (getf n :notes)) (str "Notes so far:" #\Newline (getf n :notes) #\Newline))
         (when (getf n :prereqs)
           (str "Builds on:" #\Newline
                (join #\Newline
                      (mapcar (lambda (p) (let ((pn (find-node p)))
                                            (str "  - " (if pn (getf pn :title) p) ": "
                                                 (if pn (getf pn :compression) "(not in map)"))))
                              (getf n :prereqs)))
                #\Newline))
         (let ((d (dependents id)))
           (when d
             (str "Leads to:" #\Newline
                  (join #\Newline (mapcar (lambda (m) (str "  - " (getf m :title) ": " (getf m :compression))) d))
                  #\Newline))))))

(defun attempts-context (id &optional (limit 3))
  (let ((as (subseq (node-attempts id) 0 (min limit (length (node-attempts id))))))
    (if as
        (str "Learner's written attempts at this idea, newest first:" #\Newline
             (join #\Newline
                   (mapcar (lambda (a)
                             (str "--- " (getf a :at) #\Newline (getf a :text) #\Newline
                                  "Verdict then: " (getf (getf a :feedback) :verdict)))
                           as)))
        "The learner has not written about this idea yet.")))

(defun map-context ()
  (str "Field: " (map-title) " — " (getf *map* :compression) #\Newline
       "Groups (id: compression):" #\Newline
       (join #\Newline (mapcar (lambda (g) (str "  " (getf g :id) ": " (getf g :compression))) (map-groups)))
       #\Newline "Ideas (id | title | group | prereqs | era | compression | latest verdict):" #\Newline
       (join #\Newline
             (mapcar (lambda (n)
                       (let ((id (getf n :id)))
                         (str "  " id " | " (getf n :title) " | " (getf n :group) " | "
                              (join "," (getf n :prereqs)) " | " (or (getf n :era) "?") " | "
                              (getf n :compression) " | "
                              (or (getf (getf (latest-attempt id) :feedback) :verdict) "no attempt"))))
                     (map-nodes)))))

(defun artifacts-context ()
  (let ((as (map-artifacts)))
    (if as
        (str "Artifacts already made in this field (id | type | title | about):" #\Newline
             (join #\Newline (mapcar (lambda (a) (str "  " (getf a :id) " | " (getf a :type) " | " (getf a :title)
                                                     " | " (or (getf a :node) "the field")))
                                     as)))
        "No artifacts made in this field yet.")))

;; One chat so far as proper turns for the model, newest last. A buddy turn
;; carries, after its text, what it did (map changes, artifacts) so later turns can
;; refer to them by id.
(defun conversation-messages (chat &optional (limit 20))
  (let ((ms (last (remove "error" (chat-messages chat) :key (lambda (m) (getf m :role)) :test #'equal) limit)))
    (mapcar (lambda (m)
              (list :role (if (equal (getf m :role) "you") "user" "assistant")
                    :content (str (when (and (getf m :node) (equal (getf m :role) "you"))
                                    (str "(looking at " (getf m :node) ") "))
                                  (getf m :text)
                                  (when (getf m :changes) (str #\Newline "[map changed: " (getf m :changes) "]"))
                                  (when (getf m :artifacts)
                                    (str #\Newline "[artifacts: " (join ", " (getf m :artifacts)) "]")))))
            ms)))

;;; ---- Ask: the one channel --------------------------------------------------
;;; The learner's words go to the model with the map and the focus; the reply streams
;;; back; and the model acts on the map and makes artifacts through the tools below,
;;; the way claude.ai does. *run* holds what one ask did so the reply can say so.

(defvar *run* nil "Per-ask state: (:node :changes :artifacts :sources :emit).")

;; Send one event to the browser (nil emit = a plain post, nothing to send to).
(defun emit-event (name &rest kvs)
  (let ((f (getf *run* :emit)))
    (when f (funcall f name (apply #'obj kvs)))))

(defun note-change! (text) (push text (getf *run* :changes)))

(defun run-changes () (when (getf *run* :changes) (join ", " (reverse (getf *run* :changes)))))

;;; -- Map tools --

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *node-patch-schema*
    '(:object (:id :string "id of the idea to change")
              (:title (:maybe :string))
              (:compression (:maybe :string) "one sentence")
              (:why (:maybe :string))
              (:notes (:maybe :string) "deeper notes in markdown; replaces the old notes wholesale")
              (:group (:maybe :string))
              (:prereqs (:maybe (:array :string)))
              (:era (:maybe :integer) "year; 0 if unknown"))))

(deftool add-nodes
  "Add new ideas to the map. Ids are lowercase slugs; group ids must exist or be added with add_groups first; prereqs are ids that exist or that you are adding in this call."
  (:object (:nodes (:array #.*node-schema*)))
  (input)
  (let ((added '()) (skipped '()))
    (dolist (n (getf input :nodes))
      (if (add-node! n) (push (getf n :title) added) (push (getf* n :id "?") skipped)))
    (dolist (title (reverse added)) (note-change! (str "+ " title)))
    (emit-event "status" "text" (str "Added " (length added) " idea" (if (= 1 (length added)) "" "s")))
    (str "Added " (length added) " ideas: " (join ", " (reverse added)) "."
         (when skipped (str " Skipped (id blank or already in the map): " (join ", " skipped) "."))
         " The map now has " (length (map-nodes)) " ideas.")))

(deftool update-nodes
  "Change existing ideas. Give the id and only the fields you are changing; the rest keep their current values. Use notes for depth the learner has earned: a longer explanation in markdown, the distinctions that matter, what to remember."
  (:object (:nodes (:array #.*node-patch-schema*)))
  (input)
  (let ((done '()) (missing '()))
    (dolist (p (getf input :nodes))
      (let ((old (find-node (getf p :id))))
        (if old
            (let ((n (copy-list old)))
              (loop for (k v) on p by #'cddr
                    when (and v (not (eq k :id))) do (setf (getf n k) v))
              (update-node! n)
              (push (getf n :title) done))
            (push (getf p :id) missing))))
    (dolist (title (reverse done)) (note-change! (str "~ " title)))
    (emit-event "status" "text" (str "Updated " (join ", " (reverse done))))
    (str "Updated: " (join ", " (reverse done)) "."
         (when missing (str " No idea with id: " (join ", " missing) ".")))))

(deftool remove-nodes
  "Remove ideas from the map by id. Other ideas' prerequisites on them are dropped too."
  (:object (:ids (:array :string)))
  (input)
  (let ((done (remove nil (mapcar #'remove-node! (getf input :ids)))))
    (dolist (id done) (note-change! (str "- " id)))
    (emit-event "status" "text" (str "Removed " (join ", " done)))
    (str "Removed: " (join ", " done) ".")))

(deftool add-groups
  "Add groups to the map, each a lowercase-slug id and a one-sentence compression."
  (:object (:groups (:array (:object (:id :string) (:compression :string)))))
  (input)
  (let ((done (remove nil (mapcar #'add-group! (getf input :groups)))))
    (dolist (id done) (note-change! (str "group " id)))
    (str "Added groups: " (join ", " done) ".")))

(deftool read-node
  "Read one idea in full, including its notes and the learner's written attempts at it."
  (:object (:id :string))
  (input)
  (let ((id (getf input :id)))
    (if (find-node id)
        (str (node-context id) #\Newline (attempts-context id))
        (str "No idea with id " id "."))))

;;; -- Artifact tools: what the model makes that is not prose --

(deftool create-artifact
  "Make something the learner opens beside the chat: a self-contained web page (html: a complete document; scripts from CDNs are fine; interactive explorations, simulations, visualisers, drills), a diagram (svg: a complete <svg> element with viewBox; or mermaid: a diagram definition), a document (markdown), or a program (code, with language). Returns the artifact's id. Mention the artifact in your reply by title; do not repeat its content there."
  (:object (:type (:enum "html" "svg" "mermaid" "markdown" "code"))
           (:title :string "short, specific; five words or fewer")
           (:content :string "the whole thing")
           (:language (:maybe :string) "for code: the language"))
  (input)
  (let ((a (add-artifact! :title (getf input :title) :type (getf input :type)
                          :content (getf input :content) :language (getf input :language)
                          :node (getf *run* :node))))
    (push (getf a :id) (getf *run* :artifacts))
    (emit-event "artifact" "html" (artifact-block a))
    (str "Created artifact " (getf a :id) " (" (getf a :type) "): " (getf a :title))))

(deftool update-artifact
  "Replace an artifact's content (and optionally its title). Read it first with read_artifact if you do not have its current content."
  (:object (:id :string) (:content :string "the whole new content") (:title (:maybe :string)))
  (input)
  (let ((a (update-artifact! (getf input :id) :content (getf input :content) :title (getf input :title))))
    (cond (a (pushnew (getf a :id) (getf *run* :artifacts) :test #'equal)
             (emit-event "artifact" "html" (artifact-block a))
             (str "Updated artifact " (getf a :id) " to version " (getf a :version) "."))
          (t (str "No artifact with id " (getf input :id) ".")))))

(deftool read-artifact
  "Read an artifact's current content by id."
  (:object (:id :string))
  (input)
  (let ((a (find-artifact (getf input :id))))
    (if a
        (str "Artifact " (getf a :id) " (" (getf a :type) "): " (getf a :title) #\Newline
             (artifact-text a))
        (str "No artifact with id " (getf input :id) "."))))

(deftool create-flashcards
  "Make a deck of flashcards the learner drills beside the chat (flip, mark known, shuffle). Front is a question or cue, back the answer; both markdown, short. Give each card the id of the idea it tests when there is one."
  (:object (:title :string)
           (:cards (:array (:object (:front :string) (:back :string) (:node (:maybe :string) "idea id")))))
  (input)
  (let ((a (add-artifact! :title (getf input :title) :type "flashcards"
                          :content (getf input :cards) :node (getf *run* :node))))
    (push (getf a :id) (getf *run* :artifacts))
    (emit-event "artifact" "html" (artifact-block a))
    (str "Created flashcards " (getf a :id) " with " (length (getf input :cards)) " cards.")))

(deftool create-quiz
  "Make a multiple-choice quiz the learner takes beside the chat, scored at the end. Three to five options per question, one correct (answer is its 0-based index), and a one-sentence explanation of why."
  (:object (:title :string)
           (:questions (:array (:object (:question :string)
                                        (:options (:array :string))
                                        (:answer :integer "0-based index of the correct option")
                                        (:explanation :string)
                                        (:node (:maybe :string) "idea id")))))
  (input)
  (let ((a (add-artifact! :title (getf input :title) :type "quiz"
                          :content (getf input :questions) :node (getf *run* :node))))
    (push (getf a :id) (getf *run* :artifacts))
    (emit-event "artifact" "html" (artifact-block a))
    (str "Created quiz " (getf a :id) " with " (length (getf input :questions)) " questions.")))

(defparameter *buddy-tools*
  '(add-nodes update-nodes remove-nodes add-groups read-node
    create-artifact update-artifact read-artifact create-flashcards create-quiz))

;;; -- The prompt --

(defprompt converse
  :system (str "You are the learner's study buddy, living inside their knowledge map of one field. "
               "The map is the shared object: groups of ideas; each idea has a one-sentence compression, why it matters, prerequisites, optional deeper notes, and the verdict on the learner's latest written explanation."
               #\Newline *rules* #\Newline
               "The learner writes to you to learn, to reshape the map, and to have things made. You have tools for the last two; use them, do not describe what you could do." #\Newline
               "Reply in markdown: concise, no preamble, no sign-off, mechanism over vocabulary. Headings, lists, tables and code fences all render. Refer to ideas by title. When you used a tool, say what you did in one line at the end." #\Newline
               "Changing the map: when asked, fill gaps, go deeper on one idea (breadth first: three to six sub-ideas one level down, each listing the parent among its prereqs), remove, merge, regroup, rename, or record what they have learned in notes. "
               "Ids are lowercase slugs. Group ids must exist in the map or be added with add_groups first. Prereqs must be ids that exist or that you are adding. Era is a year, 0 if unknown. Keep compression one sentence. If asked where the learner is weak, say so with reasons." #\Newline
               "Making things: when a flashcard deck, a quiz, a diagram, a document, a program, or anything interactive would teach better than prose, make it with create_flashcards, create_quiz or create_artifact, then refer to it by title in a short reply — never paste its content into the reply as well. "
               "Diagrams: svg for anything spatial (an architecture, a data path, a timeline, a mechanism), mermaid for flows, sequences and state machines. "
               "Interactive: html, a complete document, self-contained, with its own styles; it may load libraries from a CDN. Good for simulators, step-through visualisers, calculators, drills. "
               "Quizzes from a chip or a quick 'quiz me' can stay in the reply as questions with answers under a heading at the end; a quiz to be scored is create_quiz. "
               "To change an artifact, read it if you do not have its content, then update_artifact with the whole new content." #\Newline
               "You may use web search when it is on; cite primary sources when you cite."))

;; The learner's turn: the map and where they are, then their words.
(defun scope-note (scope)
  (cond ((equal scope "timeline")
         "The learner is working on the TIMELINE of this field: one bar per group spanning the years of its ideas, and the dated ideas inside. Requests here are about dates (era), which group an idea sits in, and what is missing in time. Make the changes with your tools.")
        ((equal scope "topics")
         "The learner is working on the TOPIC LIST of this field: the groups and the ideas inside each. Requests here are about adding, renaming, regrouping, removing and reordering topics. Make the changes with your tools.")))

(defun ask-turn (text node group &optional scope)
  (str (map-context) #\Newline #\Newline
       (artifacts-context) #\Newline #\Newline
       (when scope (str (scope-note scope) #\Newline #\Newline))
       (when group (str "The learner is looking at group: " group #\Newline #\Newline))
       (when node (str (node-context node) #\Newline (attempts-context node) #\Newline #\Newline))
       "Learner says:" #\Newline (trim text)))

;; What the relay streams, turned into what the browser shows.
(defun relay-event (name data)
  (cond ((equal name "delta") (emit-event "delta" "text" (gethash "text" data)))
        ((equal name "thinking") (emit-event "thinking" "text" (gethash "text" data)))
        ((equal name "tool_call")
         (let ((tool (gethash "name" data)) (input (gethash "input" data)))
           (cond ((equal tool "WebSearch")
                  (emit-event "status" "text" (str "Searched the web: " (and (hash-table-p input) (gethash "query" input)))))
                 ((equal tool "WebFetch")
                  (emit-event "status" "text" (str "Read " (and (hash-table-p input) (gethash "url" input))))))))
        ((equal name "sources")
         (setf (getf *run* :sources)
               (mapcar (lambda (s) (list :url (gethash "url" s) :title (gethash "title" s)))
                       (coerce (gethash "sources" data) 'list))))
        ((equal name "warning") (emit-event "status" "text" (gethash "message" data)))))

;; One ask, start to finish: store the learner's message, run the conversation with
;; tools, store the reply. EMIT, when given, is where the live events go.
(defun run-ask (text &key chat node group scope search effort emit)
  (add-message! "you" (trim text) :chat chat :node node)
  (let ((*run* (list :node node :changes '() :artifacts '() :sources '() :emit emit)))
    (handler-case
        (let* ((reply (converse (append (conversation-messages chat)
                                        (list (list :role "user" :content (ask-turn text node group scope))))
                                :system (getf (prompt 'converse) :system)
                                :tools *buddy-tools*
                                :search search
                                :effort (if (member effort '("low" "medium" "high") :test #'equal) effort *effort*)
                                :on-event #'relay-event))
               (changed (run-changes))
               (m (add-message! "buddy" (strip-quotes (trim reply)) :chat chat :node node :changes changed
                                :artifacts (reverse (getf *run* :artifacts))
                                :sources (getf *run* :sources))))
          (emit-event "message" "html" (message-view m) "changed" (and changed t))
          m)
      (llm-error (e)
        (let ((m (add-message! "error" (llm-error-message e) :chat chat :node node)))
          (emit-event "message" "html" (message-view m) "changed" (and (run-changes) t))
          m)))))

;; A new chat is named after its first exchange, as claude.ai names chats: a short
;; title from the model, once the reply is in. Until then it wears its first words.
(defprompt chat-title
  :system "You name a chat between a learner and their study buddy. Given the learner's first message and the reply, write a title of two to five words that says what the chat is about: specific, plain, no quotes, no trailing punctuation, no leading 'Chat about'. Title case for names only."
  :schema (:object (:title :string "two to five words")))

;; (name-chat! chat text reply) → the renamed chat, or NIL if the model could not be asked.
(defun name-chat! (chat text reply)
  (handler-case
      (let ((title (getf (ask-structured 'chat-title
                                         (str "Field: " (map-title) #\Newline
                                              "Learner's first message:" #\Newline (trim text) #\Newline #\Newline
                                              "Reply (opening):" #\Newline
                                              (let ((r (trim (or reply "")))) (subseq r 0 (min 1200 (length r))))))
                         :title)))
        (and (not (blankp title)) (rename-chat! (getf chat :id) (strip-quotes title))))
    (llm-error () nil)))

;; From the REPL: name every chat in the current field still wearing its first words
;; (a title ending in …), from its first exchange. One model call per chat.
(defun name-chats! ()
  (loop for c in (remove-if-not (lambda (c) (and (equal (getf c :map) (map-id)) (not (getf c :deleted))
                                                 (let ((title (getf c :title)))
                                                   (and (plusp (length title)) (char= (char title (1- (length title))) #\…)))))
                                (chats))
        for ms = (chat-messages (getf c :id))
        for you = (find "you" ms :key (lambda (m) (getf m :role)) :test #'equal)
        for buddy = (find "buddy" ms :key (lambda (m) (getf m :role)) :test #'equal)
        when (and you buddy)
          collect (let ((named (name-chat! c (getf you :text) (getf buddy :text))))
                    (format t "~&~a → ~a~%" (getf c :title) (if named (getf named :title) "(not named)"))
                    named)))

;; `here` is the place the learner asked from: "" (whole field), "timeline", "topics",
;; or an idea id. `chat` is the chat to continue; blank starts one, titled from the
;; first words, and the browser is told (a `chat` event) so its list can show it; once
;; the reply is in, the model names it and a `title` event carries the name.
;; From the dock (`dock` set) the answer streams as server-sent events; a plain post
;; waits and redirects back to where the ask came from.
(defaction ask-buddy "/action/ask" (map-name here chat text search effort dock)
  (unless (select-map map-name) (return-from ask-buddy (not-found "field")))
  (let* ((node (and (not (blankp here)) (find-node here) here))
         (group (and (not (blankp here)) (not node) (find-group here) here))
         (scope (and (member here '("timeline" "topics") :test #'equal) here))
         (search (not (blankp search)))
         (existing (live-chat chat)))
    (flet ((chat-for (text)
             (or existing (new-chat! (or here "") (chat-title-from text))))
           (run (chat emit)
             (let ((m (run-ask text :chat (getf chat :id) :node node :group group :scope scope
                                    :search search :effort effort :emit emit)))
               (when (and (not existing) (equal (getf m :role) "buddy"))
                 (let ((named (name-chat! chat text (getf m :text))))
                   (when (and named emit)
                     (funcall emit "title" (obj "id" (getf named :id) "title" (getf named :title)))))))))
      (cond ((blankp dock)
             (unless (blankp text) (run (chat-for text) nil))
             (redirect (focus-url here)))
            ((blankp text) "")
            (t (sse-response (lambda (emit)
                               (let ((c (chat-for text)))
                                 (unless existing
                                   (funcall emit "chat" (obj "id" (getf c :id) "title" (getf c :title)
                                                             "html" (chat-item c t))))
                                 (run c emit)))))))))

;;; ---- Chats: the list beside the dock --------------------------------------

;; The chats at one place, as the dock's rail shows them.
(defpage chat-list-page "/chats" (map-name scope current)
  (unless (select-map map-name) (return-from chat-list-page (not-found "field")))
  (chat-list (or scope "") current))

;; One chat's messages, as the dock's log shows them; "new" is the empty state for
;; a chat not yet started at `scope`.
(defpage chat-log-page "/chat/:id" (id map-name scope)
  (unless (select-map map-name) (return-from chat-log-page (not-found "field")))
  (dock-log (and (not (equal id "new")) (getf (live-chat id) :id)) (or scope "")))

(defaction rename-chat "/action/rename-chat" (map-name id title)
  (unless (select-map map-name) (return-from rename-chat (not-found "field")))
  (let ((c (rename-chat! id title)))
    (raw-response "text/plain; charset=utf-8" (if c (getf c :title) ""))))

(defaction delete-chat "/action/delete-chat" (map-name id)
  (unless (select-map map-name) (return-from delete-chat (not-found "field")))
  (delete-chat! id)
  (raw-response "text/plain; charset=utf-8" "ok"))

;;; ---- Write: check an explanation ---------------------------------------

(defprompt check-explanation
  :system (str "You are checking a learner's written explanation of one idea from a knowledge map." #\Newline
               *rules* #\Newline
               "Judge only what is written. Do not supply what the learner probably meant. "
               "Name the single most important missing idea first in the missing list. "
               "Be concrete and short: each item one sentence. "
               "The verdict is one or two plain sentences on whether this explanation would let the learner rebuild the idea from scratch.")
  :schema (:object (:right (:array :string) "what the learner got right")
                   (:missing (:array :string) "what a correct explanation needs that is absent; most important first")
                   (:wrong (:array :string) "claims that are false or confused")
                   (:verdict :string)))

(defun clean-feedback (fb)
  (list :right (mapcar #'strip-quotes (getf fb :right))
        :missing (mapcar #'strip-quotes (getf fb :missing))
        :wrong (mapcar #'strip-quotes (getf fb :wrong))
        :verdict (strip-quotes (getf fb :verdict))))

(defaction attempt "/action/attempt" (map-name node-id text)
  (unless (select-map map-name) (return-from attempt (not-found "field")))
  (unless (blankp text)
    (handler-case
        (let ((feedback (ask-structured 'check-explanation
                                        (str "Field: " (map-title) #\Newline (node-context node-id) #\Newline
                                             "Learner wrote:" #\Newline text))))
          (add-attempt! node-id (trim text) (clean-feedback feedback)))
      ;; The failure shows in the idea's chat, in the newest one or a fresh one.
      (llm-error (e) (add-message! "error" (llm-error-message e) :node node-id
                                   :chat (getf (or (newest-chat node-id) (new-chat! node-id "Checking an attempt")) :id)))))
  (redirect (node-url node-id)))

;;; ---- Hand edits (plain) ---------------------------------------------------

(defaction edit-node "/action/edit-node" (map-name node-id title compression why notes group prereqs era)
  (unless (select-map map-name) (return-from edit-node (not-found "field")))
  (update-node! (list :id node-id :title title :compression compression :why why :notes notes
                      :group group :prereqs prereqs :era era))
  (redirect (node-url node-id)))

(defaction add-node "/action/add-node" (map-name title group)
  (unless (select-map map-name) (return-from add-node (not-found "field")))
  (let ((n (add-node! (list :title title :group (if (blankp group) "misc" group)))))
    (redirect (if n (node-url (getf n :id)) (field-url)))))

(defaction remove-node "/action/remove-node" (map-name node-id)
  (unless (select-map map-name) (return-from remove-node (not-found "field")))
  (let ((group (getf (find-node node-id) :group)))
    (remove-node! node-id)
    (redirect (if group (group-url group) (field-url)))))

(defaction remove-artifact "/action/remove-artifact" (id)
  (let ((a (find-artifact id)))
    (remove-artifact! id)
    (redirect (cond ((and a (getf a :node) (select-map (getf a :map))) (node-url (getf a :node)))
                    (a (field-url (getf a :map)))
                    (t "/fields")))))

(defaction about "/action/about" (text)
  (set-about-text! (or text ""))
  (redirect "/"))

;;; ---- Seed a field: breadth first, with web search ------------------------

(defprompt seed-map
  :system (str "You design a knowledge map of a field for one self-directed learner: the core ideas, in prerequisite order, that let them rebuild the field from first principles." #\Newline
               *rules* #\Newline
               "Breadth first: cover the whole field at one level of depth rather than any part deeply. "
               "Use web search to check the ideas and dates against primary sources. "
               "groups: five to eight, each a lowercase-slug id and a one-sentence compression, ordered so prerequisites flow from the first group to the last. "
               "nodes: twenty-five to forty ideas, four to six per group, each with the schema fields; notes empty; prereqs are ids of other nodes in this map only; era is the year the idea was first had. "
               "title: the field's short title. compression: the field in one sentence.")
  :schema (:object (:title :string)
                   (:compression :string)
                   (:groups (:array (:object (:id :string) (:compression :string))))
                   (:nodes (:array #.*node-schema*))))

(defaction seed "/action/seed" (field note)
  (when (blankp field) (return-from seed (redirect "/fields")))
  (let ((id (slugify field)))
    (when (map-exists-p id) (setf id (str id "-" (get-universal-time))))
    (let ((r (ask-with-search 'seed-map
                              (str "Field: " field #\Newline
                                   "Learner's note (what they already know, and why they want it): " (or note "") #\Newline
                                   "Map id: " id))))
      (write-map! id (getf* r :title field) (getf r :compression)
                  (mapcar (lambda (g) (list :id (slugify (getf g :id)) :compression (getf g :compression)))
                          (getf r :groups))
                  (mapcar #'normalise-node (getf r :nodes)))
      (redirect (field-url id)))))
