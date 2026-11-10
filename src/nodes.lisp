;;;; L5a — Data. Field (a map), Node, Level, Attempt, Artifact, View.
;;;;
;;;; A field is one file under data/maps/, one form per line:
;;;;   (:map :id "computers" :title "Computers" :compression "…")
;;;;   (:group :id "switches" :compression "A switch can control another switch.")
;;;;   (:node :id "flip-flop" :title "…" :compression "…" :body "…"
;;;;          :group "switches" :prereqs ("logic-gates") :era 1918)
;;;; :body is the idea's whole explanation in markdown, one piece read top to bottom: it
;;;; opens with why the idea matters and grows by being rewritten, never appended to.
;;;; The map is the shared object the learner and the model both edit. Everything
;;;; the learner does (levels, attempts) lives in its own store keyed
;;;; by :ref = "map/node-id" so the map file stays a clean description of the field.

(in-package :studybuddy)

(defstore attempt  (:file "attempts.lisp"  :key :id :append t))
(defstore setting  (:file "settings.lisp"  :key :key))
(defstore artifact (:file "artifacts.lisp" :key :id))

(defvar *map* nil "The current field: (:id :title :compression :groups :nodes). Bound per request.")
(defvar *default-map* "computers")

;;; ---- Fields (maps) ----------------------------------------------------

(defun map-file (name) (data-path (str "maps/" name ".lisp")))

(defun tagged (forms tag)
  (loop for f in forms when (eq (car f) tag) collect (cdr f)))

;; (read-map "computers") → the map plist, or NIL when there is no such file.
(defun read-map (name)
  (let ((forms (read-file-forms (map-file name))))
    (when forms
      (let ((head (first (tagged forms :map))))
        (list :id name
              :title (getf* head :title name)
              :compression (getf head :compression)
              :axis (getf head :axis)
              :groups (tagged forms :group)
              :nodes (mapcar #'normalise-node (tagged forms :node)))))))

;; (load-map "computers") → the map plist, now current.
(defun load-map (name)
  (setf *map* (or (read-map name) (error "No map file ~a" (map-file name)))))

;; (select-map "computers") → the map, or NIL. Pages call this with the URL's name.
(defun select-map (name)
  (and (map-exists-p name) (load-map name)))

(defun ensure-map () (or *map* (load-map *default-map*)))

(defun map-id () (getf (ensure-map) :id))
(defun map-title () (getf (ensure-map) :title))
(defun map-nodes () (getf (ensure-map) :nodes))
(defun map-groups () (getf (ensure-map) :groups))

;; (list-maps) → ("computers" …) from data/maps/*.lisp
(defun list-maps ()
  (sort (mapcar #'pathname-name (directory (data-path "maps/*.lisp"))) #'string<))

(defun map-exists-p (name) (probe-file (map-file name)))

(defun map-forms (map)
  (append (list (append (list :map :id (getf map :id) :title (getf map :title) :compression (getf map :compression))
                        (when (getf map :axis) (list :axis (getf map :axis)))))
          (mapcar (lambda (g) (cons :group g)) (getf map :groups))
          (mapcar (lambda (n) (cons :node n)) (getf map :nodes))))

;; Write a whole new map file (seed). Refuses to overwrite.
(defun write-map! (id title compression groups nodes)
  (when (map-exists-p id) (error "Map ~a already exists" id))
  (write-file-forms (map-file id)
                    (map-forms (list :id id :title title :compression compression
                                     :groups groups :nodes nodes)))
  id)

;; Mirror the current map to its file after any edit.
(defvar *dry-run* nil "True while a proposal is applied to a throw-away copy of the map: nothing is written.")
(defun save-map! ()
  (unless *dry-run* (write-file-forms (map-file (map-id)) (map-forms *map*)))
  *map*)

;; (check-map) → list of (node-id . missing-prereq-id); NIL when every id resolves.
(defun check-map ()
  (loop for n in (map-nodes)
        append (loop for p in (getf n :prereqs)
                     unless (find-node p) collect (cons (getf n :id) p))))

;; Title and size of a field not yet loaded.
(defun field-summary (name)
  (let* ((m (read-map name)) (nodes (getf m :nodes)))
    (list :id name :title (getf m :title) :compression (getf m :compression)
          :ideas (length nodes))))

;;; ---- Nodes -------------------------------------------------------------

(defun find-node (id)
  (find id (map-nodes) :key (lambda (n) (getf n :id)) :test #'equal))

(defun find-group (id)
  (find id (map-groups) :key (lambda (g) (getf g :id)) :test #'equal))

(defun group-nodes (group-id)
  (remove group-id (map-nodes) :key (lambda (n) (getf n :group)) :test-not #'equal))

;; Nodes that list ID as a prerequisite.
(defun dependents (id)
  (remove-if-not (lambda (n) (member id (getf n :prereqs) :test #'equal)) (map-nodes)))

;; The node, what it builds on, and what builds on it — in map order.
(defun neighbourhood (id)
  (let ((n (find-node id)))
    (remove-if-not (lambda (m) (or (eq m n)
                                   (member (getf m :id) (getf n :prereqs) :test #'equal)
                                   (member id (getf m :prereqs) :test #'equal)))
                   (map-nodes))))

;; Prerequisite depth within the node's own group: 0 with no same-group prereqs.
(defun node-depth (id &optional seen)
  (let ((n (find-node id)))
    (if (or (null n) (member id seen :test #'equal))
        0
        (let ((same (remove-if-not (lambda (p) (let ((pn (find-node p)))
                                                 (and pn (equal (getf pn :group) (getf n :group)))))
                                   (getf n :prereqs))))
          (if same
              (1+ (reduce #'max (mapcar (lambda (p) (node-depth p (cons id seen))) same)))
              0)))))

(defun node-ref (id &optional (map (map-id))) (str map "/" id))

;;; ---- Editing the map (by hand or by the model) -------------------------

;; Groups in map order, plus any group a node names that was never declared.
(defun ensure-group! (id)
  (unless (or (blankp id) (find-group id))
    (setf (getf *map* :groups) (append (map-groups) (list (list :id id :compression ""))))))

(defun add-group! (g)
  (let ((id (slugify (getf* g :id ""))))
    (unless (or (blankp id) (find-group id))
      (setf (getf *map* :groups) (append (map-groups) (list (list :id id :compression (trim (getf* g :compression ""))))))
      (save-map!)
      id)))

;; Change a group's compression and/or id (renaming moves its ideas along with it).
(defun update-group! (id &key compression new-id)
  (let ((g (find-group id)) (new (slugify (or new-id ""))))
    (when g
      (let ((g2 g))
        (when (and (not (blankp new)) (not (equal new id)) (not (find-group new)))
          (setf (getf *map* :nodes)
                (mapcar (lambda (n) (if (equal (getf n :group) id) (plist-update n :group new) n))
                        (map-nodes)))
          (setf g2 (plist-update g2 :id new)))
        (when compression (setf g2 (plist-update g2 :compression (trim compression))))
        (setf (getf *map* :groups) (substitute g2 g (map-groups)))
        (save-map!)
        g2))))

;; Drop a group, but only once no idea sits in it.
(defun remove-group! (id)
  (when (and (find-group id) (null (group-nodes id)))
    (setf (getf *map* :groups) (remove id (map-groups) :key (lambda (g) (getf g :id)) :test #'equal))
    (save-map!)
    id))

;; The timeline's squeezed year ranges: ((:from 1850 :to 1930 :scale 0.15) ...). Inside a range a year
;; takes SCALE times the width it would at true scale, so a quiet stretch stops dominating the axis.
(defun clean-axis (segments)
  (sort (loop for s in segments
              for from = (getf s :from) for to = (getf s :to) for scale = (getf s :scale)
              when (and (realp from) (realp to) (realp scale) (< from to))
                collect (list :from (round from) :to (round to)
                              :scale (/ (round (* 100 (max .03 (min 1 scale)))) 100.0)))
        #'< :key (lambda (s) (getf s :from))))

(defun set-axis! (segments)
  (setf (getf *map* :axis) (clean-axis segments))
  (save-map!)
  t)

;; Put the named groups first, in that order; groups not named keep their order after them.
(defun set-group-order! (ids)
  (let* ((ids (remove-duplicates (mapcar #'slugify ids) :test #'equal :from-end t))
         (named (loop for id in ids for g = (find-group id) when g collect g))
         (rest (remove-if (lambda (g) (member (getf g :id) ids :test #'equal)) (map-groups))))
    (setf (getf *map* :groups) (append named rest))
    (save-map!)
    t))

(defun add-node! (node)
  (let ((n (normalise-node node)))
    (unless (or (blankp (getf n :id)) (find-node (getf n :id)))
      (ensure-group! (getf n :group))
      (setf (getf *map* :nodes) (append (map-nodes) (list n)))
      (save-map!)
      n)))

;; Replace the node with the same id, keeping its place in the map.
(defun update-node! (node)
  (let* ((n (normalise-node node)) (old (find-node (getf n :id))))
    (when old
      (ensure-group! (getf n :group))
      (setf (getf *map* :nodes) (substitute n old (map-nodes)))
      (save-map!)
      n)))

;; Drop the node and every reference to it in other nodes' prereqs.
(defun remove-node! (id)
  (when (find-node id)
    (setf (getf *map* :nodes)
          (mapcar (lambda (n) (plist-update n :prereqs (remove id (getf n :prereqs) :test #'equal)))
                  (remove id (map-nodes) :key (lambda (n) (getf n :id)) :test #'equal)))
    (save-map!)
    id))

;; Turn a proposal plist (from the model, a form, or the file) into a clean node plist.
(defun normalise-node (p)
  (list :id (slugify (getf* p :id (getf* p :title "")))
        :title (trim (getf* p :title ""))
        :compression (trim (getf* p :compression ""))
        ;; One body of text per idea. Older files kept :why and :notes apart; they fold into it.
        :body (trim (or (getf p :body)
                        (join (str #\Newline #\Newline)
                              (remove-if #'blankp (list (getf p :why) (getf p :notes))))))
        :group (slugify (getf* p :group "misc"))
        :prereqs (mapcar #'slugify (remove-if #'blankp (let ((pr (getf p :prereqs)))
                                                         (if (stringp pr) (split #\, pr) pr))))
        :era (let ((e (getf p :era)))
               (cond ((and (integerp e) (/= e 0)) e)
                     ((and (stringp e) (not (blankp e))) (parse-integer e :junk-allowed t))
                     (t nil)))))

;;; ---- What is in view ----------------------------------------------------

;; (visible-nodes "switches") → that group; an idea id → its neighbourhood; else all.
(defun visible-nodes (&optional focus)
  (cond ((blankp focus) (map-nodes))
        ((find-group focus) (group-nodes focus))
        ((find-node focus) (neighbourhood focus))
        (t (map-nodes))))

;; Groups, in map order, that have at least one visible node (undeclared ones included).
(defun visible-groups (nodes)
  (let ((ids (remove-duplicates (mapcar (lambda (n) (getf n :group)) nodes) :test #'equal :from-end t)))
    (append (remove-if-not (lambda (g) (member (getf g :id) ids :test #'equal)) (map-groups))
            (loop for id in ids unless (find-group id) collect (list :id id :compression "")))))

;;; ---- Attempts ----------------------------------------------------------

;; Newest first.
(defun node-attempts (id)
  (let ((ref (node-ref id)))
    (reverse (remove ref (attempts) :key (lambda (a) (getf a :ref)) :test-not #'equal))))

(defun latest-attempt (id) (first (node-attempts id)))

(defun add-attempt! (id text feedback)
  (put-attempt! (list :id (str (now-iso) "#" (length (attempts)))
                      :ref (node-ref id) :map (map-id) :node-id id
                      :at (now-iso) :text text :feedback feedback)))

;;; ---- Artifacts: things the model makes that are not prose ----------------
;;; What claude.ai calls an artifact: a page, a diagram, a deck of cards, a quiz, a
;;; document, a program — made in the conversation, kept beside the map, opened on
;;; its own. :type is one of *artifact-types*; :content is the text (html, svg,
;;; mermaid, markdown, code) or, for flashcards and quiz, the cards/questions as a
;;; list of plists. An artifact may be about one node.

(defparameter *artifact-types* '("html" "svg" "mermaid" "markdown" "code" "flashcards" "quiz"))

(defun map-artifacts (&optional node)
  (remove-if-not (lambda (a) (and (equal (getf a :map) (map-id))
                                  (or (null node) (equal (getf a :node) node))))
                 (artifacts)))

;; (new-artifact-id "RAM flashcards") → "ram-flashcards", or "ram-flashcards-2" if taken.
(defun new-artifact-id (title)
  (let ((base (let ((s (slugify (or title "artifact")))) (if (blankp s) "artifact" s))))
    (loop for i from 1
          for id = (if (= i 1) base (str base "-" i))
          unless (find-artifact id) return id)))

(defun add-artifact! (&key title type content node language)
  (let ((a (list :id (new-artifact-id title) :map (map-id) :node node
                 :type type :title (trim (or title "Untitled")) :language language
                 :content content :at (now-iso) :version 1)))
    (put-artifact! a)))

(defun update-artifact! (id &key title content)
  (let ((old (find-artifact id)))
    (when old
      (let ((new (copy-list old)))
        (when (and title (not (blankp title))) (setf (getf new :title) (trim title)))
        (when content (setf (getf new :content) content))
        (setf (getf new :at) (now-iso)
              (getf new :version) (1+ (getf* old :version 1)))
        (put-artifact! new)))))

(defun remove-artifact! (id)
  (when (find-artifact id)
    (setf *artifacts* (remove id *artifacts* :key (lambda (a) (getf a :id)) :test #'equal))
    (save-artifacts)
    id))

;;; ---- Settings ----------------------------------------------------------

(defun setting (key) (getf (find-setting key) :value))
(defun set-setting! (key value) (put-setting! (list :key key :value value :at (now-iso))))

;;; ---- About: the articulation on the home page --------------------------

(defun about-file () (data-path "about.md"))

(defun about-text ()
  (if (probe-file (about-file))
      (uiop:read-file-string (about-file) :external-format :utf-8)
      "# studybuddy\n\nWrite here what this product is for."))

(defun set-about-text! (text)
  (ensure-directories-exist (about-file))
  (with-open-file (out (about-file) :direction :output :if-exists :supersede :external-format :utf-8)
    (write-string text out))
  text)
