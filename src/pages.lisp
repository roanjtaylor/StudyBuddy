;;;; L5b — Pages. A directory: / (what this is for) → /fields → /computers →
;;;; /computers/switches → /computers/switches/ram. Every page is live:
;;;; re-evaluate the form, refresh the browser.

(in-package :studybuddy)

;;; ---- Small components --------------------------------------------------

(defcomponent level-badge (id)
  (let ((n (node-level id)))
    (html (:span :class (str "lvl lvl-" n) :title (str "level " n) (level-name n)))))

(defcomponent node-link (id)
  (let ((n (find-node id)))
    (html (:a :class "nodelink" :href (node-url id) (if n (getf n :title) id)) " " (level-badge id))))

(defcomponent group-tag (group-id)
  (html (:a :class "tag" :href (group-url group-id) group-id)))

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
  '(("What am I weakest on?" "Looking at my levels and attempts, which ideas in this field am I weakest on, and what should I do next?")
    ("Fill the gaps" "What core ideas is this map missing? Add them, breadth first.")
    ("Quiz me" "Quiz me across this field: five questions, answers hidden at the end.")))

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
  (cond ((find-group focus) (str (map-title) " / " focus))
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
            (cond ((equal role "buddy") (markdown (getf m :text)))
                  (t (html (:p (getf m :text)))))
            (when (and node (equal role "you"))
              (html (:a :class "msg-about" :href (node-url node) "about " (node-title node))))
            (when (getf m :artifacts)
              (html (:div :class "msg-artifacts"
                      (dolist (id (getf m :artifacts))
                        (let ((a (find-artifact id))) (when a (artifact-card a)))))))
            (when (getf m :sources)
              (html (:details :class "sources"
                      (:summary (length (getf m :sources)) " sources")
                      (:ul (dolist (s (getf m :sources))
                             (html (:li (:a :href (getf s :url) :target "_blank" :rel "noopener"
                                            (or (getf s :title) (getf s :url))))))))))
            (when (getf m :changes)
              (html (:p :class "changes" "✻ map changed: " (getf m :changes))))))))

;; The conversation, or, before there is one, a nudge and a few canned asks. The ask
;; action returns exactly this, and dock.js swaps it into #dock-log.
(defcomponent dock-log (focus)
  (let ((ms (map-messages)))
    (html (if ms
              (dolist (m ms) (message-view m))
              (html (:p :class "dock-empty" "Ask anything about this field, or tell me how to change the map.")
                    (:div :class "dock-chips"
                      (loop for (label text) in (if (find-node focus) *node-chips* *field-chips*)
                            do (html (:button :type "button" :class "chip" :data-text text label)))))))))

(defcomponent claude-dock (focus)
  (html (:button :type "button" :id "dock-open" :class "dock-launcher"
                 :aria-label "Ask Claude" :title "Ask Claude" (claude-mark "mark big"))
        (:section :id "dock" :class "dock" :aria-label "Claude" :hidden t
          (:header
            (:span :class "dock-badge" (claude-mark "mark"))
            (:span :class "dock-title" "Claude")
            (:button :type "button" :id "dock-wide" :class "dock-btn" :title "Widen" "⇥")
            (:button :type "button" :id "dock-close" :class "dock-btn" :title "Close" :aria-label "Close" "×"))
          (:div :class "dock-body"
            (:div :class "dock-chat"
              (:div :id "dock-log" :class "dock-log" (dock-log focus))
              (:form :id "dock-form" :class "dock-form" :method "post" :action "/action/ask"
                     :data-field (map-title)
                (hidden "map-name" (map-id)) (hidden "dock" "1")
                (:input :type "hidden" :name "here" :value focus)
                (:div :class "dock-ctx"
                  (:span :class "quiet" "Looking at")
                  (:span :class "pill"
                    (:span :class "pill-text" (focus-label focus))
                    (if (blankp focus)
                        (html (:span :class "pill-gap"))
                        (html (:button :type "button" :id "dock-drop" :aria-label "Leave this out" "×")))))
                (:textarea :name "text" :rows 2 :spellcheck "false"
                           :placeholder "Ask, ask for a change, or ask for cards, a quiz, a diagram, a page…")
                (:div :class "dock-row"
                  (:span :class "dock-opts"
                    (:label :class "check" (:input :type "checkbox" :name "search" :value "1") " web")
                    (:label :class "check" "think "
                      (:select :name "effort" :id "dock-effort"
                        (:option :value "" "off") (:option :value "low" "low")
                        (:option :value "medium" "medium") (:option :value "high" "high"))))
                  (:button :type "submit" :class "dock-send" "Send")
                  (:button :type "button" :id "dock-stop" :class "dock-send dock-stop" :hidden t "Stop"))))
            ;; The stage: where an artifact opens beside the chat, as on claude.ai.
            (:aside :id "dock-stage" :class "dock-stage" :hidden t
              (:header
                (:span :id "stage-title" :class "stage-title")
                (:a :id "stage-open" :class "dock-btn" :href "#" :target "_blank" :title "Open on its own page" "↗")
                (:button :type "button" :id "stage-close" :class "dock-btn" :title "Close" "×"))
              (:iframe :id "stage-frame" :class "stage-frame" :title "Artifact"))))))


;;; ---- Views of a field -----------------------------------------------------
;;; One page shows it all: breadth (the groups) as a timeline and a map side by side,
;;; and depth (every idea) underneath.

(defparameter *views* '("map" "timeline"))  ; actions.lisp still checks a ?view= on redirect

(defparameter *col-w* 310)
(defparameter *row-h* 92)
(defparameter *box-w* 280)
(defparameter *box-h* 72)

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

;; The svg every picture is drawn in; map.js pans and zooms it.
;; :pan t makes it a map (map.js pans and zooms it); otherwise it scrolls like a page.
(defmacro with-canvas ((w h &key pan) &body body)
  `(html (:div :class (str "map-wrap" (when ,pan " pan"))
           (:svg :class "map" :xmlns "http://www.w3.org/2000/svg"
                 :viewBox (str "0 0 " ,w " " ,h) :width "100%"
             (:g :class "viewport" ,@body)))))

;;; -- Depth map: every idea, a column per group, prerequisites as lines --------

;; → hash id → (x y), total width, total height. Rows are prerequisite depth in the group.
(defun map-positions (nodes groups)
  (let ((pos (make-hash-table :test #'equal)) (col 0) (maxrows 0))
    (dolist (g groups)
      (let ((gn (nodes-in-group nodes (getf g :id))))
        (loop for n in gn for row from 0
              do (setf (gethash (getf n :id) pos)
                       (list (+ 20 (* col *col-w*)) (+ 88 (* row *row-h*)))))
        (setf maxrows (max maxrows (length gn))))
      (incf col))
    (values pos (+ 40 (* col *col-w*)) (+ 108 (* maxrows *row-h*)))))

(defcomponent depth-map (nodes)
  (let ((groups (visible-groups nodes)))
    (multiple-value-bind (pos w h) (map-positions nodes groups)
      (with-canvas (w h :pan t)
        (loop for g in groups for col from 0
              do (let ((x (+ 20 (* col *col-w*))))
                   (html (:a :href (group-url (getf g :id))
                           (:text :x x :y 34 :class "group-title" (getf g :id)))
                         (:text :x x :y 58 :class "group-comp"
                                (truncate-string (getf* g :compression "") 36)))))
        (dolist (n nodes)
          (let ((to (gethash (getf n :id) pos)))
            (dolist (p (getf n :prereqs))
              (let ((from (gethash p pos)))
                (when (and from to)
                  (html (:line :class "edge"
                               :x1 (+ (first from) (/ *box-w* 2)) :y1 (+ (second from) *box-h*)
                               :x2 (+ (first to) (/ *box-w* 2)) :y2 (second to))))))))
        (dolist (n nodes)
          (let* ((id (getf n :id)) (p (gethash id pos)) (x (first p)) (y (second p)))
            (html (:a :href (node-url id)
                    (:rect :x x :y y :width *box-w* :height *box-h* :rx 6
                           :class (str "box lvl-" (node-level id)))
                    (:title (getf n :title) " — " (getf n :compression))
                    (:text :x (+ x 12) :y (+ y 28) :class "box-title"
                      (loop for line in (wrap-words (getf n :title) 27) for i from 0
                            do (html (:tspan :x (+ x 12) :dy (if (= i 0) 0 21) line))))))))))))

;;; -- Breadth map: one box per group, left to right in prerequisite order -------

(defparameter *gbox-w* 340)
(defparameter *gbox-h* 170)
(defparameter *gap* 50)

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

;; Column of a group: 0 with nothing before it, else one past its latest prerequisite group.
(defun group-layer (nodes group-id &optional seen)
  (let ((ps (remove-if (lambda (g) (member g seen :test #'equal)) (group-prereqs nodes group-id))))
    (if ps
        (1+ (reduce #'max (mapcar (lambda (g) (group-layer nodes g (cons group-id seen))) ps)))
        0)))

;; Prerequisites run left to right.
(defcomponent breadth-map (nodes)
  (let* ((groups (visible-groups nodes))
         (pos (make-hash-table :test #'equal))
         (fill (make-hash-table)) (layers 0) (rows 0)
         (bw *gbox-w*) (bh *gbox-h*))
    (dolist (g groups)
      (let* ((layer (group-layer nodes (getf g :id))) (row (gethash layer fill 0)))
        (setf (gethash (getf g :id) pos) (list layer row)
              (gethash layer fill) (1+ row)
              layers (max layers (1+ layer))
              rows (max rows (1+ row)))))
    (flet ((px (g) (destructuring-bind (layer row) (gethash (getf g :id) pos)
                     (+ 20 (* layer (+ bw *gap*)))))
           (py (g) (destructuring-bind (layer row) (gethash (getf g :id) pos)
                     (+ 20 (* row (+ bh *gap*))))))
      (with-canvas ((+ 40 (* layers (+ bw *gap*)))
                    (+ 40 (* rows (+ bh *gap*)))
                    :pan t)
        (dolist (g groups)
          (dolist (p (group-prereqs nodes (getf g :id)))
            (let ((from (find p groups :key (lambda (x) (getf x :id)) :test #'equal)))
              (when from
                (html (:line :class "edge"
                             :x1 (+ (px from) bw) :y1 (+ (py from) (/ bh 2))
                             :x2 (px g) :y2 (+ (py g) (/ bh 2))))))))
        (dolist (g groups)
          (let* ((id (getf g :id)) (x (px g)) (y (py g))
                 (mine (nodes-in-group nodes id))
                 (done (count-if (lambda (n) (>= (node-level (getf n :id)) 2)) mine)))
            (html (:a :href (group-url id)
                    (:rect :x x :y y :width bw :height bh :rx 8 :class "box group-box")
                    (:text :x (+ x 16) :y (+ y 34) :class "group-title gb-text" id)
                    (:text :x (+ x 16) :y (+ y 62) :class "box-title gb-text"
                      (loop for line in (wrap-words (getf* g :compression "") 34 3) for i from 0
                            do (html (:tspan :x (+ x 16) :dy (if (= i 0) 0 21) line))))
                    (:text :x (+ x 16) :y (+ y bh -14) :class "group-comp gb-meta"
                           (length mine) " ideas · " done " explained")))))))))

;;; -- Timeline: years along the x axis, a lane per group -----------------------

(defparameter *tl-left* 190)
(defparameter *tl-right* 870)
(defparameter *tl-top* 52)

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

(defcomponent timeline (nodes depth)
  (let* ((dated (remove-if-not (lambda (n) (getf n :era)) nodes))
         (groups (remove-if-not (lambda (g) (some (lambda (n) (equal (getf n :group) (getf g :id))) dated))
                                (visible-groups nodes)))
         (eras (mapcar (lambda (n) (getf n :era)) dated)))
    (if (null dated)
        (html (:p :class "quiet" "No ideas here have a date yet."))
        (let* ((step (tick-step (- (reduce #'max eras) (reduce #'min eras))))
               (lo (* step (floor (reduce #'min eras) step)))
               (hi (let ((h (* step (ceiling (reduce #'max eras) step)))) (if (= h lo) (+ lo step) h)))
               (deep (equal depth "depth"))
               (lanes '()) (y *tl-top*))
          (flet ((x (year) (round (+ *tl-left* (* (- *tl-right* *tl-left*) (/ (- year lo) (- hi lo)))))))
            ;; Lane = (group nodes-by-year placed-items height top).
            (dolist (g groups)
              (let ((gn (stable-sort (remove (getf g :id) dated :key (lambda (n) (getf n :group)) :test-not #'equal)
                                     #'< :key (lambda (n) (getf n :era)))))
                (multiple-value-bind (placed rows)
                    (if deep
                        (pack-rows gn (lambda (n) (x (getf n :era)))
                                   (lambda (n) (+ 20 (* 9 (length (getf n :title))))))
                        (values nil 0))
                  (let ((height (if deep (+ 16 (* 30 rows)) 78)))
                    (push (list g gn placed height y) lanes)
                    (incf y height)))))
            (setf lanes (nreverse lanes))
            (html
              (with-canvas (900 (+ y 16))
                (loop for year from lo to hi by step
                      do (html (:line :class "gridline" :x1 (x year) :y1 (- *tl-top* 10) :x2 (x year) :y2 y)
                               (:text :x (x year) :y (- *tl-top* 20) :class "tick" :text-anchor "middle" year)))
                (dolist (lane lanes)
                  (destructuring-bind (g gn placed height ly) lane
                    (declare (ignore height))
                    (html (:line :class "lane" :x1 20 :y1 ly :x2 *tl-right* :y2 ly)
                          (:a :href (group-url (getf g :id))
                            (:text :x 14 :y (+ ly 26) :class "group-title" (getf g :id)))
                          (if deep
                              (dolist (it placed)
                                (destructuring-bind (n nx row) it
                                  (html (:a :href (node-url (getf n :id))
                                          (:circle :cx nx :cy (+ ly 20 (* 30 row)) :r 6
                                                   :class (str "dot lvl-" (node-level (getf n :id))))
                                          (:title (getf n :era) " — " (getf n :compression))
                                          (:text :x (+ nx 12) :y (+ ly 26 (* 30 row)) :class "box-title"
                                                 (getf n :title))))))
                              (let* ((first-year (getf (first gn) :era))
                                     (last-year (getf (car (last gn)) :era))
                                     (a (x first-year)) (b (max (x last-year) (+ a 8))))
                                (html (:a :href (group-url (getf g :id))
                                        (:rect :x a :y (+ ly 12) :width (- b a) :height 18 :rx 4 :class "span")
                                        (:title (getf* g :compression ""))
                                        (:text :x a :y (+ ly 56) :class "group-comp"
                                               first-year "–" last-year " · "
                                               (truncate-string (getf* g :compression "") 52)))))))))))
            (let ((undated (- (length nodes) (length dated))))
              (when (> undated 0)
                (html (:p :class "quiet small" undated " ideas have no date and are left out here.")))))))))

;;; -- The field at a glance: a 2x2 grid ------------------------------------------
;;; Top row, breadth: timeline left, map right. Bottom row, depth: one merged cell.

(defcomponent field-view (nodes)
  (if (null nodes)
      (html (:div :class "stage empty" (:p :class "quiet" "No ideas here yet.")))
      (html (:div :class "stage grid"
              (:section :class "cell" :aria-label "Timeline" (timeline nodes "breadth"))
              (:section :class "cell" :aria-label "Map" (breadth-map nodes))
              (:section :class "cell depth" :aria-label "Every idea"
                (depth-map nodes)
                (timeline nodes "depth"))))))

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

;; Shared by the field page (focus "") and the group page (focus = group id or idea id).
(defun render-field (focus)
  (let* ((group (and (not (blankp focus)) (find-group focus)))
         (nodes (visible-nodes focus))
         (*page-class* "field")
         (*focus* focus)
         (*crumbs* (append (list (cons "fields" "/fields")
                                 (cons (map-id) (and group (field-url))))
                           (when group (list (list (getf group :id))))))
         (*nav-extra* (html (:span :class "tagline" (if group (getf group :compression) (getf *map* :compression))))))
    (layout (if group (str (getf group :id) " · " (map-title)) (map-title))
      (html (unless group (map-warnings))
            (field-view nodes)))))

(defpage field-page "/:name" (name around)
  (unless (select-map name) (return-from field-page (not-found "field")))
  (render-field (if (and around (find-node around)) around "")))

;; /computers/switches is the group; /computers/ram forgives a dropped group.
(defpage group-page "/:name/:group" (name group)
  (unless (select-map name) (return-from group-page (not-found "field")))
  (cond ((find-group group) (render-field group))
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
            (when (getf fb :suggested-level)
              (html (:p :class "quiet small" "Model's suggestion: level " (getf fb :suggested-level)
                        " (" (level-name (getf fb :suggested-level)) "). You decide.")))))))

(defcomponent attempt-view (a)
  (html (:article :class "attempt"
          (:p :class "quiet small" (getf a :at))
          (:pre :class "wrote" (getf a :text))
          (feedback-view (getf a :feedback)))))

(defcomponent rate-form (id)
  (let ((current (node-level id)))
    (html (:form :method "post" :action "/action/rate" :class "rate"
            (hidden "map-name" (map-id)) (hidden "node-id" id)
            (:span :class "quiet" "Your level: ")
            (loop for i from 0 to 3
                  do (html (:button :type "submit" :name "level" :value i
                                    :class (str "lvl lvl-" i (when (= i current) " current"))
                                    (level-name i))))))))

(defcomponent write-box (id)
  (html (:form :method "post" :action "/action/attempt" :class "write ask-form"
          (hidden "map-name" (map-id)) (hidden "node-id" id)
          (:textarea :name "text" :rows 8 :required t :spellcheck "false"
                     :placeholder "Explain it cold, in your own words, as if teaching it.")
          (:div :class "ask-row"
            (:span :class "quiet small" "The model names what is right, missing and wrong. It never sets your level.")
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

(defpage node-page "/:name/:group/:id" (name group id)
  (unless (select-map name) (return-from node-page (not-found "field")))
  (let ((n (find-node id)))
    (cond ((null n) (not-found "idea"))
          ;; The idea moved group: follow it.
          ((not (equal group (getf n :group))) (redirect (node-url id)))
          (t
           (let ((*focus* id)
                 (*crumbs* (list (cons "fields" "/fields") (cons (map-id) (field-url))
                                 (cons (getf n :group) (group-url (getf n :group))) (list id))))
             (layout (getf n :title)
               (html (:div :class "node"
                       (:section :class "node-main"
                         (:p :class "crumb"
                             (when (getf n :era) (html (getf n :era) " · "))
                             (:a :href (str (field-url) "?around=" id) "see what it connects to"))
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
                         (:h2 "Explain it")
                         (write-box id)
                         (rate-form id)
                         (let ((as (node-attempts id)))
                           (when as
                             (html (:h2 "Attempts" (:span :class "quiet small" " (" (length as) ")"))
                                   (dolist (a as) (attempt-view a)))))
                         (edit-node-form n))))))))))
