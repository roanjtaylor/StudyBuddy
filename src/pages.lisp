;;;; L5b — Pages. A directory: / (what this is for, and the fields) → /computers →
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
;;; One chat per field, never stored (the tastetrainer dock, in s-expressions). `focus` is where the learner is:
;;; "" for the field, a group id, an idea id. It rides along as the form's `here`, so
;;; the model is told what you are looking at; static/dock.js does the rest.

;; A plain eight-point spark: reads as "Claude" without borrowing the real logo.
(defcomponent claude-mark (&optional (class "mark"))
  (html (:svg :class class :viewBox "0 0 24 24" :fill "none" :stroke "currentColor"
              :stroke-width "2.2" :stroke-linecap "round"
          (:path :d "M12 3v18M3 12h18M5.6 5.6l12.8 12.8M18.4 5.6 5.6 18.4"))))

(defun node-title (id) (let ((n (find-node id))) (if n (getf n :title) id)))

;; The "Looking at" chip: the field, a group of it, or one idea.
(defun focus-label (focus)
  (cond ((equal focus "timeline") (str (map-title) " timeline"))
        ((equal focus "topics") (str (map-title) " / topics"))
        ((find-group focus) (str (map-title) " / " focus))
        ((find-node focus) (node-title focus))
        (t (map-title))))

;;; ---- Artifacts: cards in the chat, pages of their own ----------------------

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
  (html (:a :class "artifact-card" :href (artifact-view-url (getf a :id))
            :data-artifact (getf a :id) :data-type (getf a :type) :data-title (getf a :title)
          (:span :class "artifact-icon" (artifact-kind a))
          (:span :class "artifact-meta"
            (:span :class "artifact-title" (getf a :title))
            (:span :class "artifact-kind" (artifact-meta a))))))

;; In the chat, a visual artifact (a diagram, a page) shows itself, as claude.ai shows
;; images inline: a framed preview, named in its corner; its card is there unseen, for
;; the scripts to read what to open on the stage.
;; Anything else (cards, a quiz, a document, code) is its card alone.
(defparameter *inline-artifact-types* '("svg" "mermaid" "html"))

;; The way to delete an artifact: a red bin that shows on hover; a click on it adds
;; "Delete? Delete / Cancel" beside it (static/map.js), and only that Delete deletes.
(defcomponent artifact-remove (a)
  (html (:form :method "post" :action "/action/remove-artifact" :class "artifact-del-form"
          (hidden "id" (getf a :id))
          (:button :type "button" :class "artifact-del" :title "Delete" :aria-label "Delete"
                   :aria-expanded "false" (icon "trash"))
          (:span :class "artifact-del-confirm" :hidden t
            "Delete?"
            (:button :type "submit" :class "artifact-del-yes" "Delete")
            (:button :type "button" :class "artifact-del-no" "Cancel")))))

;; Pin to the open idea (static/videos.js): kept in its tray, and given to later chats about it.
;; Shown only on pages that have a tray (an idea's page).
(defcomponent artifact-pin (a)
  (html (:button :type "button" :class (if (getf a :pinned) "artifact-pin pinned" "artifact-pin")
                 :data-artifact (getf a :id) :data-node (getf a :node)
                 :title (if (getf a :pinned) "Pinned to this idea; click to unpin" "Pin to this idea")
                 :aria-label "Pin to this idea" :aria-pressed (if (getf a :pinned) "true" "false")
                 (icon "pin"))))

;; removable: where it may be deleted from (under its idea), the bin joins the corner tools.
(defcomponent artifact-block (a &optional removable)
  (if (member (getf a :type) *inline-artifact-types* :test #'equal)
      (html (:figure :class (str "artifact-inline artifact-inline-" (getf a :type)) :data-artifact (getf a :id)
              (:iframe :class "artifact-preview" :src (artifact-view-url (getf a :id)) :title (getf a :title)
                       :loading "lazy" :sandbox (if (equal (getf a :type) "svg") "" "allow-scripts"))
              ;; Over the top right corner: the bin, the name, and the way to full screen
              ;; (the frame swallows clicks, so that has to be a button over it).
              (:div :class "artifact-tools"
                (artifact-pin a)
                (when removable (artifact-remove a))
                (:span :class "artifact-name" (getf a :title))
                (:button :type "button" :class "artifact-expand" :title "Full screen" :aria-label "Full screen" (icon "expand")))
              (artifact-card a)))
      (html (artifact-card a)
            (html (:div :class "artifact-tools" (artifact-pin a)
                                       (when removable (artifact-remove a)))))))

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
    ("trash"  . "M4 7h16M10 11v6M14 11v6M6 7l1 13h10l1-13M9 7V4h6v3")
    ("wide"   . "M4 12h16M14 6l6 6-6 6")
    ("expand" . "M4 9V4h5M20 9V4h-5M4 15v5h5M20 15v5h-5")
    ("globe"  . "M12 3a9 9 0 1 0 0 18 9 9 0 0 0 0-18zM3 12h18M12 3c3 3 3 15 0 18M12 3c-3 3-3 15 0 18")
    ("pin"    . "M9 4h6l-1 6 3 3H7l3-3zM12 13v8")
    ("spark"  . "M12 3v18M3 12h18M5.6 5.6l12.8 12.8M18.4 5.6 5.6 18.4")))

(defcomponent icon (name &optional (class "ico"))
  (html (:svg :class class :viewBox "0 0 24 24" :fill "none" :stroke "currentColor"
              :stroke-width "2" :stroke-linecap "round" :stroke-linejoin "round" :aria-hidden "true"
          (:path :d (cdr (assoc name *icons* :test #'equal))))))

;; The composer both chats share: one card with the box, what Claude is looking at, the
;; model and effort, and send/stop. Only the placeholder and the "looking at" label differ.
(defcomponent composer (placeholder looking-at &optional clearable)
  (html (:div :class "composer"
          (:textarea :name "text" :rows 2 :spellcheck "false" :placeholder placeholder)
          (:div :class "composer-row"
            (:span :class "composer-tools"
              (:span :class "pill" :title "What Claude is looking at"
                (:span :class "pill-text" looking-at))
              (model-effort-controls))
            ;; Shown by static/study.js once a first exchange has finished.
            (when clearable
              (html (:button :type "button" :class "dock-send dock-clear" :hidden t
                             :title "Clear chat" :aria-label "Clear chat" (icon "trash"))))
            (:button :type "submit" :class "dock-send" :title "Send" :aria-label "Send" (icon "send"))
            (:button :type "button" :class "dock-send dock-stop" :hidden t
                     :title "Stop" :aria-label "Stop" (icon "stop"))))))

;; The field chat. Not stored: static/dock.js keeps its turns in the page and sends them
;; back with every ask, so the log starts empty and only the composer shows.
(defcomponent claude-dock (focus)
  (progn
    (html (:button :type "button" :id "dock-open" :class "dock-launcher" :hidden t
                   :aria-label "Ask Claude" :title "Ask Claude" (claude-mark "mark big"))
          (:section :id "dock" :class "dock inline pane" :aria-label "Claude"
            (:div :class "dock-body"
              (:div :class "dock-chat"
                (:div :id "dock-log" :class "dock-log")
                (:form :id "dock-form" :class "dock-form" :method "post" :action "/action/ask"
                       :data-field (map-title)
                  (hidden "map-name" (map-id))
                  (:input :type "hidden" :name "here" :value focus)
                  ;; The artifact open on the stage, so the model knows what "this" is.
                  (:input :type "hidden" :name "artifact" :value "")
                  (composer "Ask, ask for a change, or ask for cards, a quiz, a diagram, a page…"
                            (focus-label focus) t)))
              ;; The stage: where an artifact opens beside the chat, as on claude.ai.
              (:aside :id "dock-stage" :class "dock-stage" :hidden t
                (:header
                  ;; Full screen only: the X at the top left puts the topic back in view.
                  (:button :type "button" :id "stage-x" :class "dock-btn stage-x" :title "Close (Esc)" :aria-label "Close" (icon "x"))
                  (:span :id "stage-title" :class "stage-title")
                  (:button :type "button" :id "stage-focus" :class "dock-btn" :title "Full screen" :aria-label "Full screen" (icon "expand"))
                  (:button :type "button" :id "stage-close" :class "dock-btn" :title "Close" (icon "x")))
                (:iframe :id "stage-frame" :class "stage-frame" :title "Artifact")))))))


;;; ---- Views of a field -----------------------------------------------------
;;; One page shows it all: breadth (the groups) as a timeline with the field's chat,
;;; and depth (the open idea and its study chat) underneath.
;;;
;;; Every view is a sheet of paper: a fixed width, text at its natural size, and as tall
;;; as it needs to be. Nothing pans or zooms; what does not fit the width wraps onto the
;;; next row, and the page scrolls. The sheet shrinks to fit a window narrower than it.

(defparameter *views* '("map" "timeline"))  ; actions.lisp still checks a ?view= on redirect

(defparameter *paper-w* 1480 "Width of the full-width sheet.")
(defparameter *half-w* 740 "Width of the timeline sheet (the left half).")
(defparameter *margin* 20)

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

;;; -- Timeline: years along the x axis, a lane per group -----------------------

(defparameter *tl-left* 40 "Where the years start; room for the expand arrow.")
(defparameter *tl-top* 52)
(defparameter *label-px* 7.5 "Width of one character of a dot's label (14.4px text).")
(defvar *tl-marks* nil "(idea-id . css-class) pairs: ideas to mark on the timeline, as in a proposal's preview.")
(defparameter *row-h* 20 "Height of one row of ideas, as tight as the old outline list.")

;; A tick every 10 years, or wider when the span is long.
(defun tick-step (span) (cond ((<= span 150) 10) ((<= span 600) 50) (t 500)))

;; One row per item, in order, so every idea sits on its own line.
;; → list of (item x row), and the number of rows used.
(defun pack-rows (items x-of)
  (values (loop for it in items for row from 0
                collect (list it (funcall x-of it) row))
          (max 1 (length items))))

;; One shared year axis across the full width. Each group is a bar from its first to its
;; last idea, named inside; clicking it opens the group's ideas as dots on the same axis.
(defcomponent timeline (nodes &optional (w *half-w*) open current)
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
               (hi (let ((h (* step (ceiling (reduce #'max eras) step)))) (if (= h lo) (+ lo step) h)))
               (segs (remove-if-not (lambda (s) (and (< (getf s :from) hi) (> (getf s :to) lo))) (getf (ensure-map) :axis))))
          (labels ((shown (year)           ; years from LO to YEAR as drawn: squeezed ranges count for less
                     (- (- year lo)
                        (loop for s in segs
                              sum (* (- 1 (getf s :scale))
                                     (max 0 (- (min year (getf s :to)) (max lo (getf s :from))))))))
                   (x (year) (round (+ *tl-left* (* (- right *tl-left*) (/ (shown year) (shown hi))))))
                   (ticks ()               ; a year every STEP, skipping those squeezed too close to the last
                     (let ((last nil))
                       (loop for year from lo to hi by step
                             when (or (null last) (>= (- (x year) last) 30))
                               collect (progn (setf last (x year)) year))))
                   (label (n) (truncate-string (getf n :title)
                                               (max 6 (floor (- w (x (getf n :era)) 24) *label-px*))))
                   (grid (h)
                     ;; A squeezed range is shaded, so it reads as not to scale.
                     (dolist (s segs)
                       (let ((a (x (max lo (getf s :from)))) (b (x (min hi (getf s :to)))))
                         (html (:rect :x a :y 0 :width (max 1 (- b a)) :height h :class "axis-squeeze"
                                      (:title (getf s :from) "-" (getf s :to) " shown at " (round (* 100 (getf s :scale))) "% of true scale")))))
                     (dolist (year (ticks))
                       (html (:line :class "gridline" :x1 (x year) :y1 0 :x2 (x year) :y2 h)))))
            (html
              (:div :class "tl"
                (with-canvas (w 30)
                  (dolist (s segs)
                    (let ((a (x (max lo (getf s :from)))) (b (x (min hi (getf s :to)))))
                      (html (:rect :x a :y 20 :width (max 1 (- b a)) :height 10 :class "axis-squeeze"))))
                  (dolist (year (ticks))
                    (html (:line :class "gridline" :x1 (x year) :y1 22 :x2 (x year) :y2 30)
                          (:text :x (x year) :y 16 :class "tick" :text-anchor "middle" year))))
                (dolist (g groups)
                  (let* ((id (getf g :id))
                         (gn (stable-sort (remove id dated :key (lambda (n) (getf n :group)) :test-not #'equal)
                                          #'< :key (lambda (n) (getf n :era))))
                         (a (x (getf (first gn) :era)))
                         (b (max (x (getf (car (last gn)) :era)) (+ a 8)))
                         (name-w (* 9 (length id)))
                         (flip (> (+ a 28 name-w) (- w 10))))
                    (multiple-value-bind (placed rows) (pack-rows gn (lambda (n) (x (getf n :era))))
                      (html
                        (:details :class (let ((mark (cdr (assoc (str "g:" id) *tl-marks* :test #'equal)))) (if mark (str "tl-group tl-g-" mark) "tl-group")) :open (or (eq open :all) (equal id open))
                          (:summary
                            (with-canvas (w 28)
                              (grid 28)
                              (:text :x 8 :y 19 :class "chev chev-closed" "▸")
                              (:text :x 8 :y 19 :class "chev chev-open" "▾")
                              (:rect :x a :y 4 :width (- b a) :height 20 :rx 4 :class "span")
                              (:title (getf* g :compression ""))
                              (if flip
                                  (html (:text :x (- b 8) :y 19 :class "bar-title" :text-anchor "end" id))
                                  (html (:text :x (+ a 8) :y 19 :class "bar-title" id)))))
                          (with-canvas (w (+ 6 (* *row-h* rows)))
                            (grid (+ 6 (* *row-h* rows)))
                            (dolist (it placed)
                              (destructuring-bind (n nx row) it
                                (html (:a :href (node-url (getf n :id))
                                        :class (let ((base (if (equal (getf n :id) current) "tl-idea tl-current" "tl-idea"))
                                                     (mark (cdr (assoc (getf n :id) *tl-marks* :test #'equal))))
                                                 (if mark (str base " tl-m-" mark) base))
                                        ;; The idea being read below gets a highlighter-yellow band behind its label.
                                        (when (equal (getf n :id) current)
                                          (html (:rect :x (+ nx 7) :y (+ 3 (* *row-h* row))
                                                       :width (ceiling (+ 6 (* *label-px* (length (label n)))))
                                                       :height 17 :rx 3 :class "cur-hl")))
                                        ;; An invisible target over the dot and its label, so the whole thing clicks.
                                        (:rect :x (- nx 10) :y (+ 2 (* *row-h* row)) :width (ceiling (+ 22 (* *label-px* (length (label n)))))
                                               :height 18 :class "hit")
                                        (:circle :cx nx :cy (+ 11 (* *row-h* row)) :r 4 :class "dot")
                                        (:title (getf n :era) " — " (getf n :title) " — " (getf n :compression))
                                        (:text :x (+ nx 10) :y (+ 16 (* *row-h* row)) :class "box-title"
                                               (label n)))))))))))))
            (let ((undated (- (length nodes) (length dated))))
              (when (> undated 0)
                (html (:p :class "quiet small" undated " ideas have no date and are left out here."))))))))))

;;; ---- The study pane: a compact, throw-away chat about the open idea -----------
;;; The same pane as the breadth chat (the `composer` above, the `.pane` styles).
;;; static/study.js keeps the conversation in memory; the server stores nothing.

(defcomponent study-pane (n)
  (let ((id (getf n :id)))
    (html (:section :class "dock inline pane study" :aria-label "Study"
            ;; Empty until the first message: only the composer shows.
            (:div :class "dock-log study-log")
            (:form :class "dock-form study-form" :method "post" :action "/action/study"
              (hidden "map-name" (map-id)) (hidden "here" id)
              (composer (str "Explain " (getf n :title) " in your own words, or ask about it…")
                        (getf n :title) t))))))

;; The two choices beside every composer: which model answers, and how hard it thinks.
;; static/dock.js and static/study.js remember them; web search is always available.
(defcomponent model-effort-controls ()
  (html (:label :class "toggle select" :title "Model"
          (:select :name "model"
            (let ((current (preferred-model)))
              (loop for (id label) in *models*
                    do (html (:option :value id :selected (equal id current) label))))))
        (:label :class "toggle select" :title "Effort"
          (:span "Effort")
          (:select :name "effort" :data-pref "dock-effort"
            (loop for e in *efforts*
                  do (html (:option :value e :selected (equal e *effort*) e)))))))

(defcomponent field-view (nodes &optional idea)
  (let ((open (and idea (getf idea :group))))
    (html (if (null nodes)
              (html (:div :class "stage empty" (:p :class "quiet" "No ideas here yet.")))
              (html (:section :class "idea-below breadth"
                      (:div :class "stage grid"
                        (:section :class "cell timeline" :aria-label "Timeline"
                          (timeline nodes *half-w* open (and idea (getf idea :id)))))
                      ;; The field's chat, where the depth section has the study chat. Its context is
                      ;; always the whole field's timeline, whichever idea is open below.
                      (:aside :class "idea-side"
                        (claude-dock "timeline")))))
          ;; Below: the open idea on the left; on the right, writing and the chat pinned to it.
          (:section :id "idea" :class "idea-below"
            (:div :class "idea-main"
              (if idea
                  (node-detail idea)
                  (html (:p :class "quiet" "Open an idea above to read it here."))))
            (:aside :class (str "idea-side" (if idea " has-idea" ""))
              (:div :class "idea-study" (when idea (study-pane idea))))))))

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

;;; ---- Home: what this is for, and the fields ------------------------------

(defpage home "/" (new)
  (layout "StudyBuddy"
    (html (:div :class "home"
            (:div :class "home-about" (markdown (about-text)))
            (:aside :class "home-fields" :aria-label "Fields"
              (:div :class "heading"
                (:h2 "Fields")
                (:a :class "round" :href (if new "/" "/?new=1")
                    :title (if new "Cancel" "New field")
                    (if new "×" "+")))
              (when new
                (html (:form :method "post" :action "/action/seed" :class "ask-form"
                        (:label "Field" (:input :type "text" :name "field" :required t :placeholder "e.g. Thermodynamics"))
                        (:label "What you already know, and why you want it"
                                (:textarea :name "note" :rows 4))
                        (:button :type "submit" :class "primary" "Create field"))))
              (field-list))))))

;; The old address folds into the home page.
(defpage fields-page "/fields" ()
  (redirect "/"))

;;; ---- A field, or one group of it -----------------------------------------

;; The field page: the timeline and its chat, and below them the idea (if one is open).
(defun render-field (&optional idea-id)
  (let* ((idea (and (not (blankp idea-id)) (find-node idea-id)))
         (nodes (map-nodes))
         (*page-class* "field")
         (*focus* (if idea idea-id ""))
         (*crumbs* (append (list (cons (map-id) (and idea (field-url))))
                           (when idea (list (list (getf idea :title))))))
         (*nav-extra* (html (:span :class "tagline" (getf *map* :compression)))))
    (layout (if idea (str (getf idea :title) " · " (map-title)) (map-title))
      (html (map-warnings)
            (field-view nodes idea)))))

(defpage field-page "/:name" (name idea)
  (unless (select-map name) (return-from field-page (not-found "field")))
  ;; The old /field?idea=x address becomes /field/x.
  (if (and (not (blankp idea)) (find-node idea))
      (redirect (node-url idea))
      (render-field)))

;; An idea lives at /field/idea, below the field's timeline; an old group
;; address folds back into the field.
(defpage group-page "/:name/:group" (name group)
  (unless (select-map name) (return-from group-page (not-found "field")))
  (cond ((find-node group) (render-field group))
        ((find-group group) (redirect (field-url)))
        (t (not-found "idea"))))

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

;;; ---- The thing itself, for the frame --------

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
                                       ;; A lone ~ in a label pairs up as markdown strikethrough ("Unsupported markdown: del"), so show it as ≈.
                                       (:raw "import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11.4.1/dist/mermaid.esm.min.mjs';"
                                             "for(const p of document.querySelectorAll('pre.mermaid'))p.textContent=p.textContent.replace(/(?<!~)~(?!~)/g,'\\u2248');"
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

(defcomponent node-detail (n)
  (let ((id (getf n :id)))
    (html (:div :class "node"
            (:section :class "node-main"
                         ;; data-field marks each editable text, so static/study.js can draw a
                         ;; proposed edit as a diff right here, in the text itself.
                         (:p :class "crumb"
                             (getf n :group)
                             (:span :data-field "era" (when (getf n :era) (html " · " (getf n :era)))))
                         (:h1 :data-field "title" (getf n :title))
                         (:p :class "compression" :data-field "compression" (getf n :compression))
                         ;; The whole explanation, one piece: no separate "why" line or notes box.
                         (:div :class "body md" :data-field "body" :hidden (blankp (getf n :body))
                           (:raw (markdown->html (getf n :body))))
                         (let ((as (remove-if (lambda (a) (getf a :pinned)) (map-artifacts id))))
                           (when as
                             (html (:h2 "Made for this idea")
                                   (:div :class "artifact-list"
                                     (dolist (a as)
                                       (html (:div :class "artifact-tile"
                                               (artifact-block a t))))))))
                         (video-section n))))))

(defpage node-page "/:name/:group/:id" (name group id)
  (unless (select-map name) (return-from node-page (not-found "field")))
  (if (find-node id) (redirect (node-url id)) (not-found "idea")))
