;;;; L5c — Actions. One AI channel (ask) that answers and reshapes the map, one AI
;;;; check of a written explanation, one AI seed of a new field, and the plain
;;;; hand edits.

(in-package :studybuddy)

(defparameter *rules*
  "Rules you must obey:
1. Core ideas, not examples. A node is one idea with a one-sentence compression (to which the learner may ask for further lines, such as the same sentence in other languages) and a body that explains it. Favour the few ideas that generate the rest; never pad with remixes, tools or trivia.
2. Theory is learned from the originator, products by using them. When you cite, cite primary sources.
3. Nothing is understood until it has been written out and checked.")

;; How an idea's body is written and, above all, rewritten. Every prompt that can touch a
;; body carries this, so new material is worked into the text rather than added under it.
(defparameter *body-rule*
  (str "An idea's body is its whole explanation in markdown, read top to bottom as one piece: it opens with why the idea matters, in a sentence or two of plain prose, then gives the mechanism, then whatever depth has been earned. "
       "A body is always sent complete and replaces the old one, so changing it means REWRITING it: put new material where it belongs in the explanation, reword and reorder what is there so the whole reads as if written in one sitting, and cut what the new version makes redundant. "
       "Never append: no add-on section at the end, no 'Notes', 'Update', 'Addendum' or 'Why it matters' heading tacked on, nothing that repeats what the body already says. "
       "The body is about the idea, never about the edit: do not describe what changed or what an earlier version lacked. Keep what was correct and useful unless the learner asks to drop it."))

;; Read-time available (#.) so the prompt schemas below can splice it in.
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *node-schema*
    '(:object (:id :string "lowercase slug, hyphens only")
              (:title :string "a short name for the idea, five words or fewer")
              (:compression :string "one sentence that compresses the idea")
              (:body :string "the idea's explanation in markdown, one piece; at its shortest, one or two sentences on why it matters")
              (:group :string "group id this node belongs to")
              (:era :integer "year the idea was first had; negative for BC; 0 if unknown"))))

;;; ---- URLs ----------------------------------------------------------------

;;; One page per field: /computers, with /computers/ram opening an idea below it.

(defun field-url (&optional (map (map-id))) (str "/" map))
(defun group-url (group &optional (map (map-id))) (declare (ignore group)) (field-url map))
;; An idea opens below the field's timeline and outline, on the field's own page.
(defun node-url (id &optional (map (map-id))) (str "/" map "/" id))
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
         "Compression (the subtitle shown under the title; every line from here to \"Body\" is this one field):"
         #\Newline (getf n :compression) #\Newline
         "Body (the whole explanation as it stands):" #\Newline (getf n :body) #\Newline)))

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
       #\Newline "Ideas (id | title | group | era | compression | latest verdict):" #\Newline
       (join #\Newline
             (mapcar (lambda (n)
                       (let ((id (getf n :id)))
                         (str "  " id " | " (getf n :title) " | " (getf n :group) " | "
                              (or (getf n :era) "?") " | "
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
              (:body (:maybe :string) "the complete rewritten body in markdown; replaces the old one, with new material worked in, not appended")
              (:group (:maybe :string))
              (:era (:maybe :integer) "year; 0 if unknown"))))

(deftool add-nodes
  "Add new ideas to the map. Ids are lowercase slugs; group ids must exist or be added with add_groups first. Ideas are independent: no links between them."
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
  "Change existing ideas. Give the id and only the fields you are changing; the rest keep their current values. The body holds the depth the learner has earned: the mechanism, the distinctions that matter, what to remember. To change a body, read the idea first (read_node) unless you already have its full body, then send the whole body rewritten with the new material worked in where it belongs; never the old text with a section added at the end."
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
  "Read one idea in full, including its body and the learner's written attempts at it."
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

;; Shared by the dock chat and the idea study pane: both can make artifacts, and both are
;; told that anything visual is made, never pasted into the reply as text or code.
(defparameter *making-things*
  (str "Making things: when a diagram, a picture, a flashcard deck, a quiz, a document, a program, or anything interactive would teach better than prose, MAKE it with create_artifact, create_flashcards or create_quiz — the learner sees it rendered beside the chat, as on claude.ai. "
       "NEVER paste svg, html, mermaid or ASCII-art diagrams into the reply, and never tell the learner to save code to a file or open it elsewhere: you have the tool, use it. After making one, refer to it by title in a short reply and do not repeat its content. "
       "Diagrams: svg for anything spatial (a device, an architecture, a data path, a timeline, a mechanism, states side by side) — a complete <svg> with a viewBox, no fixed width/height, generous spacing, text no smaller than 12 units, labelled parts, colour used to mean something; mermaid for flows, sequences and state machines. A diagram of several states or steps is one svg laid out as panels, each titled. "
       "Interactive: html, a complete document, self-contained, with its own styles; it may load libraries from a CDN. Good for simulators, step-through visualisers, calculators, drills. "
       "Quizzes from a chip or a quick 'quiz me' can stay in the reply as questions with answers under a heading at the end; a quiz to be scored is create_quiz. "
       "To change an artifact, read it if you do not have its content, then update_artifact with the whole new content."))

(defprompt converse
  :system (str "You are the learner's study buddy, living inside their knowledge map of one field. "
               "The map is the shared object: groups of ideas; each idea has a one-sentence compression, a body that explains it, and the verdict on the learner's latest written explanation."
               #\Newline *rules* #\Newline *body-rule* #\Newline
               "The learner writes to you to learn, to reshape the map, and to have things made. You have tools for the last two; use them, do not describe what you could do." #\Newline
               "Reply in markdown: concise, no preamble, no sign-off, mechanism over vocabulary. Headings, lists, tables and code fences all render. Refer to ideas by title. When you used a tool, say what you did in one line at the end." #\Newline
               "Changing the map: when asked, fill gaps, go deeper on one idea (breadth first: three to six sub-ideas one level down, each independent, with no links between ideas), remove, merge, regroup, rename, or work what they have learned into an idea's body. "
               "Ids are lowercase slugs. Group ids must exist in the map or be added with add_groups first. Era is a year, 0 if unknown. Keep compression one sentence. If asked where the learner is weak, say so with reasons." #\Newline
               *making-things* #\Newline
               "You can search the web and fetch pages: do so when you need current or primary information, and cite primary sources when you cite."))

;; The learner's turn: the map and where they are, then their words.
(defun scope-note (scope)
  (cond ((equal scope "timeline")
         "The learner is working on the TIMELINE of this field: one bar per group spanning the years of its ideas, and the dated ideas inside. This chat is about the field as a whole, not any one idea (the learner studies single ideas in a separate chat). Requests here are about the field's breadth: dates (era), which group an idea sits in, and what is missing in time. Make the changes with your tools.")
        ((equal scope "topics")
         "The learner is working on the TOPIC LIST of this field: the groups and the ideas inside each. Requests here are about adding, renaming, regrouping, removing and reordering topics. Make the changes with your tools.")))

(defun ask-turn (text node group &optional scope open-artifact)
  (str (map-context) #\Newline #\Newline
       (artifacts-context) #\Newline #\Newline
       (let ((a (and open-artifact (find-artifact open-artifact))))
         (when a (str "The learner has the artifact \"" (getf a :title) "\" (id " (getf a :id) ") open full screen beside this chat; \"this\", \"it\" and \"the diagram\" mean that artifact. To change it, read_artifact if needed, then update_artifact." #\Newline #\Newline)))
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

;; One ask, start to finish: run the conversation with tools and send the reply. Nothing
;; is stored: HISTORY is the chat so far, kept by the browser and sent back with each ask.
;; The reply's "text" is what the browser remembers of it: the words, then what was done
;; (map changes, artifacts) so later turns can refer to them by id.
(defun run-ask (text &key history node group scope model effort artifact emit)
  (let ((*run* (list :node node :changes '() :artifacts '() :sources '() :emit emit)))
    (handler-case
        (let* ((reply (strip-quotes
                       (trim (converse (append history
                                               (list (list :role "user" :content (ask-turn text node group scope artifact))))
                                       :system (getf (prompt 'converse) :system)
                                       :tools *buddy-tools*
                                       :model (remember-model! (pick-model model))
                                       :effort (pick-effort effort)
                                       :on-event #'relay-event))))
               (changed (run-changes))
               (made (reverse (getf *run* :artifacts))))
          (emit-event "message"
                      "html" (message-view (list :role "buddy" :text reply :changes changed :artifacts made
                                                 :sources (getf *run* :sources)))
                      "text" (str reply
                                  (when changed (str #\Newline "[map changed: " changed "]"))
                                  (when made (str #\Newline "[artifacts: " (join ", " made) "]")))
                      "changed" (and changed t)))
      (llm-error (e)
        (emit-event "message"
                    "html" (message-view (list :role "error" :text (llm-error-message e)))
                    "text" ""
                    "changed" (and (run-changes) t))))))

;; `here` is the place the learner asked from: "" (whole field), "timeline", "topics",
;; a group id or an idea id. `history` is the chat so far as JSON, [{role, content}…].
;; The answer streams as server-sent events.
(defaction ask-buddy "/action/ask" (map-name here text history model effort artifact)
  (unless (select-map map-name) (return-from ask-buddy (not-found "field")))
  (let* ((node (and (not (blankp here)) (find-node here) here))
         (group (and (not (blankp here)) (not node) (find-group here) here))
         (scope (and (member here '("timeline" "topics") :test #'equal) here)))
    (if (blankp text)
        ""
        (sse-response (lambda (emit)
                        (run-ask text :history (study-messages history) :node node :group group :scope scope
                                      :model model :effort effort
                                      :artifact (and (not (blankp artifact)) artifact) :emit emit))))))

;;; ---- Study: a throw-away conversation about one idea ---------------------------
;;; The conversation is not stored: the browser keeps it in memory and sends it back with
;;; each question. The model may only *propose* edits to the open idea (propose_node_edit);
;;; the browser shows them as a diff, and nothing changes until the learner approves
;;; (/action/apply-edit).

(defparameter *editable-fields*
  '(("title" "Title") ("compression" "Compression") ("body" "Body") ("era" "Era")))

(defun field-text (node key)
  (let ((v (getf node key)))
    (cond ((null v) "") ((stringp v) v) (t (princ-to-string v)))))

(deftool propose-node-edit
  "Propose a change to the idea the learner has open. Nothing is changed until the learner approves it in a diff. Give only the fields you want to change. Each field you give replaces the old one whole. The compression is the subtitle under the title: usually one sentence, but the learner may keep several lines in it (the same sentence in other languages, for instance), so to add or change a line send every line of it, old and new, separated by newlines. It is the learner's map: when they ask for a change to a field, propose it even if it departs from the field's usual shape. A new body replaces the old one, so send the complete body, rewritten so that what is new sits where it belongs in the explanation and the whole reads as one piece; never the old body with a section added at the end. Use this when the learner asks for an edit, or when the body would be better for what they have just worked out."
  (:object (:title (:maybe :string))
           (:compression (:maybe :string) "the whole subtitle: one sentence, or every one of its lines separated by newlines when the learner keeps several")
           (:body (:maybe :string) "the complete rewritten body in markdown, new material worked in, not appended")
           (:era (:maybe :integer) "year; 0 if unknown"))
  (input)
  (let* ((id (getf *run* :node)) (old (and id (find-node id))) (changes '()))
    (cond
      ((null old) "No idea is open, so there is nothing to edit.")
      (t
       (loop for (name label) in *editable-fields*
             for key = (kw name)
             for new = (getf input key)
             when new
               do (let ((before (field-text old key))
                        (after (if (eq key :era) (if (eql new 0) "" (princ-to-string new)) (trim new))))
                    (unless (equal before after)
                      (push (obj "field" name "label" label "before" before "after" after) changes))))
       (cond ((null changes) "That matches what the idea already says; no change proposed.")
             (t (emit-event "proposal" "node" id "title" (getf old :title)
                                       "changes" (coerce (nreverse changes) 'vector))
                "Shown to the learner as a diff for approval. It is NOT applied yet; do not say it is. They will approve or reject it themselves."))))))

(defparameter *study-tools*
  '(propose-node-edit create-artifact update-artifact read-artifact create-flashcards create-quiz))

;; The learner approved a proposal: apply the fields, and only the editable ones, to the open idea.
(defaction apply-edit "/action/apply-edit" (map-name here changes)
  (unless (select-map map-name) (return-from apply-edit (not-found "field")))
  (let ((old (and (not (blankp here)) (find-node here)))
        (h (handler-case (jzon:parse changes) (error () nil))))
    (flet ((reply (ok &optional error)
             (raw-response "application/json" (jzon:stringify (obj "ok" ok "error" (or error ""))))))
      (if (or (null old) (not (hash-table-p h)))
          (reply nil "There is nothing to apply.")
          (let ((n (copy-list old)))
            (maphash (lambda (k v)
                       (when (and (assoc k *editable-fields* :test #'equal) (stringp v))
                         (setf (getf n (kw k)) (if (equal k "era") (parse-integer v :junk-allowed t) v))))
                     h)
            (update-node! n)
            (reply t))))))

(defprompt study
  :system (str "You are a tutor helping a learner study one idea from a knowledge map. This conversation is not saved. You can see the idea's data above; you cannot change it, but you can propose an edit with propose_node_edit, which the learner sees as a diff and approves or rejects. Propose edits when asked, or when the body would be better for what they have just worked out; say in one line what you proposed, never that it is done. Every part of the idea you can see (title, compression with all its lines, body, era) is yours to propose changes to; never tell the learner that you cannot edit something they can see in the idea, and never refuse an edit they asked for because it bends a field's usual shape." #\Newline
               *rules* #\Newline *body-rule* #\Newline
               "If the learner writes out their own understanding of the idea, mark it against the idea: what is right, what is missing (most important first), what is wrong, and a one-line verdict, as short lists. Judge only what is written; be honest, not kind. "
               "Otherwise answer their question directly: mechanism first, concrete, as short as the question allows. Ask them a question back only when it would teach them something. "
               "Reply in markdown, no preamble, no sign-off." #\Newline
               *making-things* #\Newline
               "You can search the web and fetch pages when you need current or primary information; cite primary sources when you cite."))

(defun study-messages (history-json)
  (let ((h (handler-case (coerce (jzon:parse history-json) 'list) (error () nil))))
    (loop for m in (last h 20)
          for role = (and (hash-table-p m) (gethash "role" m))
          for content = (and (hash-table-p m) (gethash "content" m))
          when (and (member role '("user" "assistant") :test #'equal) (stringp content))
            collect (list :role role :content content))))

(defaction study "/action/study" (map-name here text history model effort)
  (unless (select-map map-name) (return-from study (not-found "field")))
  (let ((node (and (not (blankp here)) (find-node here) here)))
    (cond ((or (blankp text) (null node)) "")
          (t (sse-response
              (lambda (emit)
                (let ((*run* (list :emit emit :node node)))
                  (handler-case
                      (let ((reply (strip-quotes
                                    (trim (converse (append (study-messages history)
                                                            (list (list :role "user"
                                                                        :content (str "Field: " (map-title) #\Newline
                                                                                      (node-context node) #\Newline #\Newline
                                                                                      (artifacts-context) #\Newline #\Newline
                                                                                      "Learner says:" #\Newline (trim text)))))
                                                    :system (getf (prompt 'study) :system)
                                                    :tools *study-tools*
                                                    :model (remember-model! (pick-model model))
                                                    :effort (pick-effort effort)
                                                    :on-event #'relay-event)))))
                        (let ((made (reverse (getf *run* :artifacts))))
                          (funcall emit "message"
                                   (obj "html" (message-view (list :role "buddy" :text reply :artifacts made))
                                        ;; what the next turn's history remembers, so the model can find its artifacts
                                        "text" (str reply (when made (str #\Newline "[artifacts: " (join ", " made) "]")))))))
                    (llm-error (e)
                      (funcall emit "message" (obj "html" (message-view (list :role "error" :text (llm-error-message e)))
                                                   "text" "")))))))))))

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
      (llm-error () nil)))
  (redirect (node-url node-id)))

;;; ---- Hand edits (plain) ---------------------------------------------------

(defaction edit-node "/action/edit-node" (map-name node-id title compression body group prereqs era)
  (unless (select-map map-name) (return-from edit-node (not-found "field")))
  (update-node! (list :id node-id :title title :compression compression :body body
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
                    (t "/")))))

(defaction about "/action/about" (text)
  (set-about-text! (or text ""))
  (redirect "/"))

;;; ---- Seed a field: breadth first, with web search ------------------------

(defprompt seed-map
  :system (str "You design a knowledge map of a field for one self-directed learner: the core ideas that let them rebuild the field from first principles." #\Newline
               *rules* #\Newline
               "Breadth first: cover the whole field at one level of depth rather than any part deeply. "
               "Use web search to check the ideas and dates against primary sources. "
               "groups: five to eight, each a lowercase-slug id and a one-sentence compression, ordered roughly by history."
               "nodes: twenty-five to forty ideas, four to six per group, each with the schema fields; body one or two sentences on why the idea matters; each idea stands alone, with no links to other ideas; era is the year the idea was first had. "
               "title: the field's short title. compression: the field in one sentence.")
  :schema (:object (:title :string)
                   (:compression :string)
                   (:groups (:array (:object (:id :string) (:compression :string))))
                   (:nodes (:array #.*node-schema*))))

(defaction seed "/action/seed" (field note)
  (when (blankp field) (return-from seed (redirect "/")))
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
