;;;; L5b — Pages. A directory: / (what this is for) → /fields → /computers →
;;;; /computers/switches → /computers/switches/ram. Every page is live:
;;;; re-evaluate the form, refresh the browser.

(in-package :studybuddy)

;;; ---- Small components --------------------------------------------------

(defcomponent node-link (id)
  (let ((n (find-node id)))
    (html (:a :class "nodelink" :href (node-url id) (if n (getf n :title) id)))))

(defcomponent group-tag (group-id)
  (html (:span :class "tag" group-id)))

(defcomponent string-list (items &key (class "plain"))
  (when items
    (html (:ul :class class (dolist (s items) (html (:li s)))))))

(defcomponent hidden (name value)
  (html (:input :type "hidden" :name name :value value)))

(defcomponent markdown (text)
  (html (:div :class "md" (:raw (markdown->html text)))))

;;; ---- The Claude dock: the one way to talk to the field --------------------
;;; A round button bottom-right of the content opens a chat panel on every page of a
;;; field (the tastetrainer dock, in s-expressions). `focus` is where the learner is:
;;; "" for the field, a group id, an idea id. It rides along as the form's `here`, so
;;; the model is told what you are looking at; static/dock.js does the rest.

(defparameter *field-chips*
  '(("What am I weakest on?" "Looking at my attempts, which ideas in this field am I weakest on, and what should I do next?")
    ("Fill the gaps" "What core ideas is this map missing? Add them, breadth first.")
    ("Quiz me" "Quiz me across this field: five questions, answers hidden at the end.")))

(defparameter *timeline-chips*
  '(("Date the undated" "Give every idea without a date a sensible era, using your tools.")
    ("Fill time gaps" "Where does this timeline have long gaps with no ideas? Add the core ideas that belong there, breadth first.")))

(defparameter *topic-chips*
  '(("Fill the gaps" "What core ideas is this map missing? Add them, breadth first.")
    ("Regroup" "Is anything in the wrong group, or are the groups badly chosen? Fix it with your tools.")
    ("Tighten" "Merge or remove ideas that are examples, remixes or padding rather than core ideas.")))

(defparameter *node-chips*
  '(("Explain it to me" "Explain this idea to me from first principles, mechanism first. Then record the explanation in its notes.")
    ("Go deeper" "Expand this idea into the sub-ideas I would need to write out to own it, one level down.")
    ("Quiz me" "Quiz me on this idea and its neighbours: five questions, answers hidden at the end.")
    ("Questions to answer" "Give me five questions about mechanism that I should be able to answer in a paragraph each, hardest gap first given my attempts.")
    ("Why does it matter?" "Why does this idea matter for the rest of the field? What does it unlock, and what breaks without it?")))

;; A plain eight-point spark: reads as "Claude" without borrowing the real logo.
(defcomponent claude-mark (&optional (class "mark"))
  (html (:svg :class class :viewBox "0 0 24 24" :fill "none" :stroke "currentColor"
              :stroke-width "2.2" :stroke-linecap "round"
          (:path :d "M12 3v18M3 12h18M5.6 5.6l12.8 12.8M18.4 5.6 5.6 18.4"))))

(defun node-title (id) (let ((n (find-node id))) (if n (getf n :title) id)))

;; The "Looking at" chip: the field, a group of it, or one idea.
(defun focus-label (focus)
  (cond ((equal focus "timeline") (str (map-title) " / timeline"))
        ((equal focus "topics") (str (map-title) " / topics"))
        ((find-group focus) (str (map-title) " / " focus))
        ((find-node focus) (node-title focus))
        (t (map-title))))

;;; ---- Artifacts: cards in the chat, pages of their own ----------------------

(defun artifact-url (id) (str "/artifact/" id))
(defun artifact-view-url (id) (str "/artifact/" id "/view"))

(defparameter *artifact-kinds*
  '(("html" "⌘" "Interactive") ("svg" "◇" "Diagram") ("mermaid" "⇄" "Diagram")
    ("markdown" "¶" "Document") ("code" "{}" "Code") ("flashcards" "▭" "Flashcards") ("quiz" "?" "Quiz")))

(defun artifact-kind (a)
  (let ((k (assoc (getf a :type) *artifact-kinds* :test #'equal)))
    (values (or (second k) "•") (or (third k) (getf a :type)))))

;; "Flashcards · 12 cards", "Diagram · svg", "Code · python"
(defun artifact-meta (a)
  (multiple-value-bind (icon kind) (artifact-kind a)
    (declare (ignore icon))
    (let ((type (getf a :type)) (c (getf a :content)))
      (str kind " · "
           (cond ((equal type "flashcards") (str (length c) " cards"))
                 ((equal type "quiz") (str (length c) " questions"))
                 ((equal type "code") (or (getf a :language) "code"))
                 (t type))
           (when (> (getf* a :version 1) 1) (str " · v" (getf a :version)))))))

;; Opens in the dock's stage when the dock is there, on its own page otherwise.
(defcomponent artifact-card (a)
  (html (:a :class "artifact-card" :href (artifact-url (getf a :id))
            :data-artifact (getf a :id) :data-type (getf a :type) :data-title (getf a :title)
          (:span :class "artifact-icon" (artifact-kind a))
          (:span :class "artifact-meta"
            (:span :class "artifact-title" (getf a :title))
            (:span :class "artifact-kind" (artifact-meta a))))))

;; In the chat, a visual artifact (a diagram, a page) shows itself, as claude.ai shows
;; images inline: a framed preview with its card under it to open it on the stage.
;; Anything else (cards, a quiz, a document, code) is its card alone.
(defparameter *inline-artifact-types* '("svg" "mermaid" "html"))

(defcomponent artifact-block (a)
  (if (member (getf a :type) *inline-artifact-types* :test #'equal)
      (html (:figure :class (str "artifact-inline artifact-inline-" (getf a :type)) :data-artifact (getf a :id)
              (:iframe :class "artifact-preview" :src (artifact-view-url (getf a :id)) :title (getf a :title)
                       :loading "lazy" :sandbox (if (equal (getf a :type) "svg") "" "allow-scripts"))
              (artifact-card a)))
      (artifact-card a)))

;; The artifact as text, for the model to read back.
(defun artifact-text (a)
  (let ((c (getf a :content)))
    (cond ((equal (getf a :type) "flashcards")
           (join #\Newline (mapcar (lambda (card) (str "- " (getf card :front) " → " (getf card :back)
                                                      (when (getf card :node) (str " [" (getf card :node) "]"))))
                                   c)))
          ((equal (getf a :type) "quiz")
           (join #\Newline (mapcar (lambda (q) (str "- " (getf q :question) " | options: " (join " / " (getf q :options))
                                                   " | answer: " (getf q :answer) " | " (getf q :explanation)))
                                   c)))
          (t c))))

(defcomponent message-view (m)
  (let ((role (getf m :role)) (node (getf m :node)))
    (html (:article :class (str "msg msg-" role)
            (when (equal role "buddy") (html (:span :class "msg-mark" (claude-mark "mark"))))
            (cond ((equal role "buddy") (markdown (getf m :text)))
                  (t (html (:p (getf m :text)))))
            (when (and node (equal role "you"))
              (html (:a :class "msg-about" :href (node-url node) "about " (node-title node))))
            (when (getf m :artifacts)
              (html (:div :class "msg-artifacts"
                      (dolist (id (getf m :artifacts))
                        (let ((a (find-artifact id))) (when a (artifact-block a)))))))
            (when (getf m :sources)
              (html (:details :class "sources"
                      (:summary (length (getf m :sources)) " sources")
                      (:ul (dolist (s (getf m :sources))
                             (html (:li (:a :href (getf s :url) :target "_blank" :rel "noopener"
                                            (or (getf s :title) (getf s :url))))))))))
            (when (getf m :changes)
              (html (:p :class "changes" "✻ map changed: " (getf m :changes))))))))

;; Small line icons, drawn once here so the dock borrows nothing.
(defparameter *icons*
  '(("rail"   . "M4 5h16M4 12h16M4 19h16")
    ("new"    . "M12 5v14M5 12h14")
    ("send"   . "M12 19V5M5 12l7-7 7 7")
    ("stop"   . "M7 7h10v10H7z")
    ("rename" . "M4 20h4l10.5-10.5a2.1 2.1 0 0 0-3-3L5 17z")
    ("trash"  . "M4 7h16M10 11v6M14 11v6M6 7l1 13h10l1-13M9 7V4h6v3")
    ("check"  . "M5 12l5 5L20 7")
    ("x"      . "M6 6l12 12M18 6L6 18")
    ("open"   . "M14 4h6v6M20 4l-9 9M19 14v6H5V6h6")
    ("wide"   . "M4 12h16M14 6l6 6-6 6")
    ("globe"  . "M12 3a9 9 0 1 0 0 18 9 9 0 0 0 0-18zM3 12h18M12 3c3 3 3 15 0 18M12 3c-3 3-3 15 0 18")
    ("spark"  . "M12 3v18M3 12h18M5.6 5.6l12.8 12.8M18.4 5.6 5.6 18.4")))

(defcomponent icon (name &optional (class "ico"))
  (html (:svg :class class :viewBox "0 0 24 24" :fill "none" :stroke "currentColor"
              :stroke-width "2" :stroke-linecap "round" :stroke-linejoin "round" :aria-hidden "true"
          (:path :d (cdr (assoc name *icons* :test #'equal))))))

;; One chat in the rail. Its title is a button; rename and delete appear on hover.
(defcomponent chat-item (c &optional current)
  (html (:li :class (str "chat-item" (if current " current" "")) :data-chat (getf c :id)
          (:button :type "button" :class "chat-open" :title (getf c :title)
            (:span :class "chat-title" (getf c :title)))
          (:span :class "chat-tools"
            (:button :type "button" :class "chat-rename" :title "Rename" :aria-label "Rename" (icon "rename"))
            (:button :type "button" :class "chat-delete" :title "Delete" :aria-label "Delete" (icon "trash"))))))

;; The chats at one place, newest first. /chats returns exactly this.
(defcomponent chat-list (scope &optional current)
  (let ((cs (scope-chats scope)))
    (html (if cs
              (dolist (c cs) (chat-item c (equal (getf c :id) current)))
              (html (:li :class "rail-empty" "No chats here yet."))))))

;; Before a chat has a message: a greeting for the place, and a few asks to start from.
(defcomponent dock-empty (scope)
  (let ((node (find-node scope)))
    (html (:div :class "dock-empty"
            (:p :class "greeting"
              (cond (node (str "Let's go deep on " (getf node :title) "."))
                    ((equal scope "timeline") "Let's work on the timeline.")
                    ((equal scope "topics") "Let's shape the topics.")
                    (t (str "What are we working on in " (map-title) "?"))))
            (:div :class "dock-chips"
              (loop for (label text) in (cond (node *node-chips*) ((equal scope "timeline") *timeline-chips*)
                                              ((equal scope "topics") *topic-chips*) (t *field-chips*))
                    do (html (:button :type "button" :class "chip" :data-text text label))))))))

;; One chat's messages, or the empty state. /chat/:id returns exactly this and
;; dock.js swaps it into #dock-log.
(defcomponent dock-log (chat scope)
  (let ((ms (and chat (chat-messages chat))))
    (html (if ms
              (dolist (m ms) (message-view m))
              (dock-empty scope)))))

(defcomponent claude-dock (focus)
  (let* ((chat (newest-chat focus)) (chat-id (getf chat :id)))
    (html (:button :type "button" :id "dock-open" :class "dock-launcher" :hidden t
                   :aria-label "Ask Claude" :title "Ask Claude" (claude-mark "mark big"))
          (:section :id "dock" :class "dock inline" :aria-label "Claude"
            (:header
              (:button :type "button" :id "dock-rail-toggle" :class "dock-btn" :title "Chats" :aria-label "Chats" (icon "rail"))
              (:span :class "dock-badge" (claude-mark "mark"))
              (:span :id "dock-title" :class "dock-title" (getf* chat :title "New chat"))
              (:button :type "button" :id "dock-new" :class "dock-btn" :title "New chat" :aria-label "New chat" (icon "new"))
              (:button :type "button" :id "dock-wide" :class "dock-btn" :title "Widen" :aria-label "Widen" (icon "wide"))
              (:button :type "button" :id "dock-close" :class "dock-btn" :title "Close" :aria-label "Close" (icon "x")))
            (:div :class "dock-body"
              ;; The rail: this place's chats, as claude.ai lists them.
              (:aside :id "dock-rail" :class "dock-rail" :aria-label "Chats"
                (:div :class "rail-head"
                  (:span :class "rail-title" "Chats")
                  (:button :type "button" :id "rail-new" :class "rail-newbtn" (icon "new") " New chat"))
                (:ul :id "chat-list" :class "chat-list" (chat-list focus chat-id)))
              (:div :class "dock-chat"
                (:div :id "dock-log" :class "dock-log" (dock-log chat-id focus))
                ;; The composer: one card, as on claude.ai.
                (:form :id "dock-form" :class "dock-form" :method "post" :action "/action/ask"
                       :data-field (map-title)
                  (hidden "map-name" (map-id)) (hidden "dock" "1")
                  (:input :type "hidden" :name "here" :value focus)
                  (:input :type "hidden" :name "chat" :value (or chat-id ""))
                  (:div :class "composer"
                    (:textarea :name "text" :rows 1 :spellcheck "false"
                               :placeholder "Ask, ask for a change, or ask for cards, a quiz, a diagram, a page…")
                    (:div :class "composer-row"
                      (:span :class "composer-tools"
                        (:span :class "pill" :title "What Claude is looking at"
                          (:span :class "pill-text" (focus-label focus)))
                        (:label :class "toggle" :title "Search the web"
                          (:input :type "checkbox" :name "search" :value "1") (icon "globe") (:span "Web"))
                        (:label :class "toggle select" :title "Extended thinking"
                          (:span "Think")
                          (:select :name "effort" :id "dock-effort"
                            (:option :value "" "off") (:option :value "low" "low")
                            (:option :value "medium" "medium") (:option :value "high" "high"))))
                      (:button :type "submit" :class "dock-send" :title "Send" :aria-label "Send" (icon "send"))
                      (:button :type "button" :id "dock-stop" :class "dock-send dock-stop" :hidden t
                               :title "Stop" :aria-label "Stop" (icon "stop"))))))
              ;; The stage: where an artifact opens beside the chat, as on claude.ai.
              (:aside :id "dock-stage" :class "dock-stage" :hidden t
                (:header
                  (:span :id "stage-title" :class "stage-title")
                  (:a :id "stage-open" :class "dock-btn" :href "#" :target "_blank" :title "Open on its own page" (icon "open"))
                  (:button :type "button" :id "stage-close" :class "dock-btn" :title "Close" (icon "x")))
                (:iframe :id "stage-frame" :class "stage-frame" :title "Artifact")))))))


;;; ---- Views of a field -----------------------------------------------------
;;; One page shows it all: breadth (the groups) as a timeline and a map side by side,
;;; and depth (every idea) underneath.
;;;
;;; Every view is a sheet of paper: a fixed width, text at its natural size, and as tall
;;; as it needs to be. Nothing pans or zooms; what does not fit the width wraps onto the
;;; next row, and the page scrolls. The sheet shrinks to fit a window narrower than it.

(defparameter *views* '("map" "timeline"))  ; actions.lisp still checks a ?view= on redirect

(defparameter *paper-w* 1480 "Width of the depth sheet (the bottom, full-width cell).")
(defparameter *half-w* 740 "Width of a breadth sheet (one of the two top cells).")
(defparameter *margin* 20)

(defun nodes-in-group (nodes group-id)
  (stable-sort (remove group-id nodes :key (lambda (n) (getf n :group)) :test-not #'equal)
               #'< :key (lambda (n) (node-depth (getf n :id)))))

;; (wrap-words "a long title here" 8) → ("a long" "title" "here…") at most 2 lines
(defun wrap-words (s width &optional (max-lines 2))
  (let ((lines '()) (line ""))
    (dolist (w (split #\Space s))
      (if (and (> (length line) 0) (> (+ (length line) 1 (length w)) width))
          (progn (push line lines) (setf line w))
          (setf line (if (string= line "") w (str line " " w)))))
    (push line lines)
    (setf lines (nreverse lines))
    (if (> (length lines) max-lines)
        (append (subseq lines 0 (1- max-lines))
                (list (truncate-string (join " " (nthcdr (1- max-lines) lines)) width)))
        lines)))

;; Characters that fit in PX, at PER-CHAR pixels each (8 for 16px body text).
(defun chars-at (px &optional (per-char 8)) (max 4 (floor px per-char)))

;; Lines of text starting at X Y, LEAD apart. Used inside a :text element.
(defun text-lines (x y lines lead)
  (declare (ignore y))
  (loop for line in lines for i from 0
        do (html (:tspan :x x :dy (if (= i 0) 0 lead) line))))

;; The svg every sheet is drawn in: W wide at 1:1, H tall, scaled down only to fit a
;; narrower window (style.css: max-width 100%).
(defmacro with-canvas ((w h) &body body)
  `(html (:div :class "map-wrap"
           (:svg :class "map" :xmlns "http://www.w3.org/2000/svg"
                 :viewBox (str "0 0 " ,w " " ,h) :width ,w :height ,h
             ,@body))))

;;; -- Breadth map: the groups as an outline -----------------------------------------
;;; Each group is a title with its one-line compression underneath; opening it lists its
;;; ideas in prerequisite order, like a folder in a file tree.

;; The groups a group's ideas build on, other than itself.
(defun group-prereqs (nodes group-id)
  (remove group-id
          (remove-duplicates
           (loop for n in nodes
                 when (equal (getf n :group) group-id)
                   append (loop for p in (getf n :prereqs)
                                for pn = (find-node p)
                                when pn collect (getf pn :group)))
           :test #'equal)
          :test #'equal))

;; Layer of a group: 0 with nothing before it, else one past its latest prerequisite group.
(defun group-layer (nodes group-id &optional seen)
  (let ((ps (remove-if (lambda (g) (member g seen :test #'equal)) (group-prereqs nodes group-id))))
    (if ps
        (1+ (reduce #'max (mapcar (lambda (g) (group-layer nodes g (cons group-id seen))) ps)))
        0)))

(defcomponent breadth-map (nodes &optional (w *half-w*) open)
  (declare (ignore w))
  (let ((groups (stable-sort (copy-list (visible-groups nodes)) #'<
                             :key (lambda (g) (group-layer nodes (getf g :id))))))
    (html (:div :class "outline"
            (dolist (g groups)
              (let* ((id (getf g :id))
                     (mine (nodes-in-group nodes id)))
                (html (:details :class "outline-group" :open (equal id open)
                        (:summary
                          (:span :class "outline-title" id)
                          (:span :class "outline-sub" " — " (getf* g :compression "")))
                        (:ul
                          (dolist (n mine)
                            (html (:li (:a :href (node-url (getf n :id)) :title (getf n :compression)
                                        (getf n :title))))))))))))))

;;; -- Timeline: years along the x axis, a lane per group -----------------------

(defparameter *tl-left* 40 "Where the years start; room for the expand arrow.")
(defparameter *tl-top* 52)
(defparameter *label-px* 9 "Width of one character of a dot's label.")

;; A tick every 10 years, or wider when the span is long.
(defun tick-step (span) (cond ((<= span 150) 10) ((<= span 600) 50) (t 500)))

;; Greedy rows for labels along a line: each item takes the first row whose last label
;; has ended before it starts. → list of (item x row), and the number of rows used.
(defun pack-rows (items x-of width-of)
  (let ((ends '()) (placed '()))
    (dolist (it items)
      (let* ((x (funcall x-of it))
             (row (or (position-if (lambda (e) (<= e x)) ends) (length ends)))
             (end (+ x (funcall width-of it))))
        (if (< row (length ends))
            (setf (nth row ends) end)
            (setf ends (append ends (list end))))
        (push (list it x row) placed)))
    (values (nreverse placed) (max 1 (length ends)))))

;; One shared year axis across the full width. Each group is a bar from its first to its
;; last idea, named inside; clicking it opens the group's ideas as dots on the same axis.
(defcomponent timeline (nodes &optional (w *paper-w*) open)
  (let* ((dated (remove-if-not (lambda (n) (getf n :era)) nodes))
         (groups (remove-if-not (lambda (g) (some (lambda (n) (equal (getf n :group) (getf g :id))) dated))
                                (visible-groups nodes)))
         (eras (mapcar (lambda (n) (getf n :era)) dated))
         ;; Room on the right for the last labels.
         (right (- w 30 (min 240 (floor w 4)))))
    (if (null dated)
        (html (:p :class "quiet" "No ideas here have a date yet."))
        (let* ((step (tick-step (- (reduce #'max eras) (reduce #'min eras))))
               (lo (* step (floor (reduce #'min eras) step)))
               (hi (let ((h (* step (ceiling (reduce #'max eras) step)))) (if (= h lo) (+ lo step) h))))
          (labels ((x (year) (round (+ *tl-left* (* (- right *tl-left*) (/ (- year lo) (- hi lo))))))
                   (label (n) (truncate-string (getf n :title)
                                               (max 6 (floor (- w (x (getf n :era)) 24) *label-px*))))
                   (label-w (n) (+ 20 (* *label-px* (length (label n)))))
                   (grid (h)
                     (loop for year from lo to hi by step
                           do (html (:line :class "gridline" :x1 (x year) :y1 0 :x2 (x year) :y2 h)))))
            (html
              (:div :class "tl"
                (with-canvas (w 30)
                  (loop for year from lo to hi by step
                        do (html (:line :class "gridline" :x1 (x year) :y1 22 :x2 (x year) :y2 30)
                                 (:text :x (x year) :y 16 :class "tick" :text-anchor "middle" year))))
                (dolist (g groups)
                  (let* ((id (getf g :id))
                         (gn (stable-sort (remove id dated :key (lambda (n) (getf n :group)) :test-not #'equal)
                                          #'< :key (lambda (n) (getf n :era))))
                         (a (x (getf (first gn) :era)))
                         (b (max (x (getf (car (last gn)) :era)) (+ a 8)))
                         (name-w (* 9 (length id)))
                         (flip (> (+ a 28 name-w) (- w 10))))
                    (multiple-value-bind (placed rows) (pack-rows gn (lambda (n) (x (getf n :era))) #'label-w)
                      (html
                        (:details :class "tl-group" :open (equal id open)
                          (:summary
                            (with-canvas (w 34)
                              (grid 34)
                              (:text :x 8 :y 22 :class "chev chev-closed" "▸")
                              (:text :x 8 :y 22 :class "chev chev-open" "▾")
                              (:rect :x a :y 5 :width (- b a) :height 24 :rx 4 :class "span")
                              (:title (getf* g :compression ""))
                              (if flip
                                  (html (:text :x (- b 8) :y 22 :class "bar-title" :text-anchor "end" id))
                                  (html (:text :x (+ a 8) :y 22 :class "bar-title" id)))))
                          (with-canvas (w (+ 8 (* 30 rows)))
                            (grid (+ 8 (* 30 rows)))
                            (dolist (it placed)
                              (destructuring-bind (n nx row) it
                                (html (:a :href (node-url (getf n :id))
                                        (:circle :cx nx :cy (+ 16 (* 30 row)) :r 6 :class "dot")
                                        (:title (getf n :era) " — " (getf n :title) " — " (getf n :compression))
                                        (:text :x (+ nx 12) :y (+ 22 (* 30 row)) :class "box-title"
                                               (label n)))))))))))))
            (let ((undated (- (length nodes) (length dated))))
              (when (> undated 0)
                (html (:p :class "quiet small" undated " ideas have no date and are left out here."))))))))))

;;; -- The field at a glance: a 2x2 grid ------------------------------------------
;;; Two columns: the timeline on the left (an expandable bar per group), the outline of groups on the right.

(defcomponent scope-button (scope what)
  (html (:button :type "button" :class "scope-claude" :data-scope scope :data-label (str (map-title) " / " scope)
                 :title (str "Ask Claude about the " what) :aria-label (str "Ask Claude about the " what)
           (claude-mark "mark"))
        (:div :class "dock-anchor")))

(defcomponent field-view (nodes &optional idea)
  (let ((open (and idea (getf idea :group))))
    (html (if (null nodes)
              (html (:div :class "stage empty" (:p :class "quiet" "No ideas here yet.")))
              (html (:div :class "stage grid"
                      (:section :class "cell timeline" :aria-label "Timeline"
                        (scope-button "timeline" "timeline")
                        (timeline nodes *half-w* open))
                      (:section :class "cell" :aria-label "Topics"
                        (scope-button "topics" "topics")
                        (breadth-map nodes *half-w* open)))))
          ;; Below: the open idea on the left; on the right, writing and the chat pinned to it.
          (:section :id "idea" :class "idea-below"
            (:div :class "idea-main"
              (if idea
                  (node-detail idea)
                  (html (:p :class "quiet" "Open an idea above to read it here."))))
            (:aside :class "idea-side"
              (:div :class "idea-write" (when idea (idea-write idea)))
              (claude-dock (if idea (getf idea :id) "")))))))

(defcomponent map-warnings ()
  (let ((bad (check-map)))
    (when bad
      (html (:p :class "warn"
              "Dangling prerequisites: "
              (join "; " (mapcar (lambda (b) (str (car b) " → " (cdr b))) bad)))))))

(defcomponent field-list ()
  (html (:ul
          (dolist (m (list-maps))
            (html (:li (:a :href (field-url m) (getf (field-summary m) :title))))))))

;;; ---- Home: what this is for ----------------------------------------------

(defpage home "/" ()
  (layout "StudyBuddy"
    (html (:div :class "home"
            (markdown (about-text))))))

;;; ---- Fields ---------------------------------------------------------------

(defpage fields-page "/fields" (new)
  (let ((*crumbs* '(("fields"))))
    (layout "Fields"
      (html (:div :class "heading"
              (:h1 "Fields")
              (:a :class "round" :href (if new "/fields" "/fields?new=1")
                  :title (if new "Cancel" "New field")
                  (if new "×" "+")))
            (when new
              (html (:form :method "post" :action "/action/seed" :class "ask-form"
                      (:label "Field" (:input :type "text" :name "field" :required t :placeholder "e.g. Thermodynamics"))
                      (:label "What you already know, and why you want it"
                              (:textarea :name "note" :rows 4))
                      (:button :type "submit" :class "primary" "Create field"))))
            (field-list)))))

;;; ---- A field, or one group of it -----------------------------------------

;; The field page: timeline and outline, and below them the idea (if one is open).
(defun render-field (&optional idea-id)
  (let* ((idea (and (not (blankp idea-id)) (find-node idea-id)))
         (nodes (map-nodes))
         (*page-class* "field")
         (*focus* (if idea idea-id ""))
         (*crumbs* (append (list (cons "fields" "/fields")
                                 (cons (map-id) (and idea (field-url))))
                           (when idea (list (list (getf idea :title))))))
         (*nav-extra* (html (:span :class "tagline" (getf *map* :compression)))))
    (layout (if idea (str (getf idea :title) " · " (map-title)) (map-title))
      (html (map-warnings)
            (field-view nodes idea)))))

(defpage field-page "/:name" (name idea)
  (unless (select-map name) (return-from field-page (not-found "field")))
  (render-field idea))

;; Old group and idea addresses fold back into the one page.
(defpage group-page "/:name/:group" (name group)
  (unless (select-map name) (return-from group-page (not-found "field")))
  (cond ((find-group group) (redirect (field-url)))
        ((find-node group) (redirect (node-url group)))
        (t (not-found "group"))))

;;; ---- An idea --------------------------------------------------------------

(defcomponent feedback-view (fb)
  (when fb
    (html (:div :class "feedback"
            (:p :class "verdict" (getf fb :verdict))
            (:div :class "three"
              (:div (:h4 "Right") (string-list (getf fb :right)))
              (:div (:h4 "Missing") (string-list (getf fb :missing)))
              (:div (:h4 "Wrong") (string-list (getf fb :wrong))))
            ))))

(defcomponent attempt-view (a)
  (html (:article :class "attempt"
          (:p :class "quiet small" (getf a :at))
          (:pre :class "wrote" (getf a :text))
          (feedback-view (getf a :feedback)))))

(defcomponent write-box (id)
  (html (:form :method "post" :action "/action/attempt" :class "write ask-form"
          (hidden "map-name" (map-id)) (hidden "node-id" id)
          (:textarea :name "text" :rows 8 :required t :spellcheck "false"
                     :placeholder "Explain it cold, in your own words, as if teaching it.")
          (:div :class "ask-row"
            (:span :class "quiet small" "The model names what is right, missing and wrong.")
            (:button :type "submit" :class "primary" "Check my explanation")))))

(defcomponent edit-node-form (n)
  (html (:details :class "edit"
          (:summary "Edit by hand")
          (:form :method "post" :action "/action/edit-node" :class "ask-form"
            (hidden "map-name" (map-id)) (hidden "node-id" (getf n :id))
            (:label "Title" (:input :type "text" :name "title" :value (getf n :title) :required t))
            (:label "Compression" (:textarea :name "compression" :rows 2 (getf n :compression)))
            (:label "Why it matters" (:textarea :name "why" :rows 2 (getf n :why)))
            (:label "Notes (markdown)" (:textarea :name "notes" :rows 8 (getf n :notes)))
            (:label "Group" (:input :type "text" :name "group" :value (getf n :group)))
            (:label "Builds on (ids, comma separated)" (:input :type "text" :name "prereqs" :value (join ", " (getf n :prereqs))))
            (:label "Era (year)" (:input :type "text" :name "era" :value (getf n :era)))
            (:div :class "ask-row"
              (:button :type "submit" :class "primary" "Save")))
          (:form :method "post" :action "/action/remove-node" :class "inline"
            (hidden "map-name" (map-id)) (hidden "node-id" (getf n :id))
            (:button :type "submit" :class "danger" "Remove this idea from the map")))))

;;; ---- An artifact on its own page, and the thing itself for the frame --------

;; JSON safe to sit inside a <script> element.
(defun script-json (x)
  (let ((s (jzon:stringify (lisp->json x))))
    (with-output-to-string (out)
      (loop for i from 0 below (length s)
            do (if (and (char= (char s i) #\<) (< (1+ i) (length s)) (char= (char s (1+ i)) #\/))
                   (write-string "<\\/" out)
                   (write-char (char s i) out))))))

;; A chromeless page for the frame: the app's styles, the artifact's content.
(defun artifact-frame (a &rest body)
  (html (:raw "<!doctype html>")
    (:html :lang "en"
      (:head (:meta :charset "utf-8")
             (:meta :name "viewport" :content "width=device-width, initial-scale=1")
             (:title (getf a :title))
             (:link :rel "stylesheet" :href (static-url "style.css"))
             (:link :rel "stylesheet" :href (static-url "artifact.css")))
      (:body :class (str "artifact artifact-" (getf a :type))
        (dolist (p body) (html (:raw p)))))))

(defpage artifact-view "/artifact/:id/view" (id)
  (let ((a (find-artifact id)))
    (unless a (return-from artifact-view (not-found "artifact")))
    (let ((type (getf a :type)) (c (getf a :content)))
      (cond ((equal type "html") (raw-response "text/html; charset=utf-8" c))
            ((equal type "svg")
             (artifact-frame a (html (:div :class "svg-wrap" (:raw c)))))
            ((equal type "mermaid")
             (artifact-frame a (html (:pre :class "mermaid" c)
                                     (:script :type "module"
                                       (:raw "import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11.4.1/dist/mermaid.esm.min.mjs';"
                                             "mermaid.initialize({startOnLoad:true,theme:matchMedia('(prefers-color-scheme: dark)').matches?'dark':'neutral'});")))))
            ((equal type "markdown")
             (artifact-frame a (html (:div :class "md doc" (:raw (markdown->html c))))))
            ((equal type "code")
             (artifact-frame a (html (:pre :class "code" (:code c)))))
            ((member type '("flashcards" "quiz") :test #'equal)
             (artifact-frame a (html (:script :type "application/json" :id "data" (:raw (script-json c)))
                                     (:div :id "app" :data-kind type :data-id (getf a :id))
                                     (:script :src (static-url "md.js"))
                                     (:script :src (static-url "artifact.js")))))
            (t (not-found "artifact"))))))

;; What the frame's sandbox should be: the model's own documents run cut off from the
;; app; the app's own viewers (cards, quiz, documents) run as the app.
(defun artifact-sandbox (a)
  (if (member (getf a :type) '("html" "svg" "mermaid") :test #'equal)
      "allow-scripts allow-forms allow-popups allow-modals allow-downloads"
      nil))

(defpage artifact-page "/artifact/:id" (id)
  (let ((a (find-artifact id)))
    (unless a (return-from artifact-page (not-found "artifact")))
    (unless (select-map (getf a :map)) (return-from artifact-page (not-found "field")))
    (let ((*page-class* "field")
          (*crumbs* (list (cons "fields" "/fields") (cons (map-id) (field-url)) (list (getf a :title)))))
      (layout (getf a :title)
        (html (:div :class "artifact-head"
                (:span :class "artifact-icon" (artifact-kind a))
                (:span :class "artifact-title" (getf a :title))
                (:span :class "quiet small" (artifact-meta a) " · " (getf a :at))
                (when (getf a :node)
                  (html (:a :class "quiet small" :href (node-url (getf a :node)) "about " (node-title (getf a :node)))))
                (:span :class "gap")
                (:a :class "quiet small" :href (artifact-view-url id) :target "_blank" "open the thing itself ↗")
                (:form :method "post" :action "/action/remove-artifact" :class "inline"
                  (hidden "id" id)
                  (:button :type "submit" :class "danger small" "Remove")))
              (:iframe :class "artifact-full" :src (artifact-view-url id) :sandbox (artifact-sandbox a)
                       :title (getf a :title)))))))

(defcomponent node-detail (n)
  (let ((id (getf n :id)))
    (html (:div :class "node"
            (:section :class "node-main"
                         (:p :class "crumb"
                             (getf n :group)
                             (when (getf n :era) (html " · " (getf n :era))))
                         (:h1 (getf n :title))
                         (:p :class "compression" (getf n :compression))
                         (:p :class "why" (getf n :why))
                         (when (getf n :prereqs)
                           (html (:p :class "quiet" "Builds on: "
                                     (loop for (p . rest) on (getf n :prereqs)
                                           do (node-link p) (when rest (html ", "))))))
                         (let ((d (dependents id)))
                           (when d
                             (html (:p :class "quiet" "Leads to: "
                                       (loop for (m . rest) on d
                                             do (node-link (getf m :id)) (when rest (html ", ")))))))
                         (unless (blankp (getf n :notes))
                           (html (:section :class "notes" (:h2 "Notes") (markdown (getf n :notes)))))
                         (let ((as (map-artifacts id)))
                           (when as
                             (html (:h2 "Made for this idea")
                                   (:div :class "artifact-list" (dolist (a as) (artifact-card a))))))
                         (edit-node-form n))))))

(defcomponent idea-write (n)
  (let ((id (getf n :id)))
    (html (:h2 "Explain it")
          (write-box id)
          (let ((as (node-attempts id)))
            (when as
              (html (:h2 "Attempts" (:span :class "quiet small" " (" (length as) ")"))
                    (dolist (a as) (attempt-view a))))))))

(defpage node-page "/:name/:group/:id" (name group id)
  (unless (select-map name) (return-from node-page (not-found "field")))
  (if (find-node id) (redirect (node-url id)) (not-found "idea")))
