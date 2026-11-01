;;;; L1 — HTML as s-expressions. One macro and you never type an angle bracket.
;;;;
;;;;   (html (:div :class "node" (:h1 title) (:p "a<b")))
;;;;   → "<div class=\"node\"><h1>…</h1><p>a&lt;b</p></div>"
;;;;
;;;; Rules: a form (:tag attrs… children…) is an element; keyword/value pairs
;;;; before the first non-keyword are attributes (nil omits, t is bare); literal
;;;; strings are escaped at macro time; any other form is evaluated and its result
;;;; escaped (nil prints nothing); (:raw x) inserts x unescaped. Output goes to
;;;; *html-out*, a string stream bound by the outermost call, so an inner (html …)
;;;; — inside dolist, a component, anywhere — writes straight into the same page.

(in-package :studybuddy)

(defvar *html-out* nil "The stream the current page is being written to.")

(defparameter *void-elements* '(:br :img :input :meta :link :hr :source))

;; (escape "a<b & \"c\"") → "a&lt;b &amp; &quot;c&quot;"
(defun escape (s)
  (with-output-to-string (out)
    (loop for c across s
          do (case c
               (#\& (write-string "&amp;" out))
               (#\< (write-string "&lt;" out))
               (#\> (write-string "&gt;" out))
               (#\" (write-string "&quot;" out))
               (t (write-char c out))))))

;; Runtime helpers the macro expands into.
(defun emit (x)
  (when x (write-string (escape (if (stringp x) x (princ-to-string x))) *html-out*)))

(defun emit-raw (x)
  (when x (write-string (if (stringp x) x (princ-to-string x)) *html-out*)))

(defun emit-attr (name value)
  (cond ((null value))
        ((eq value t) (format *html-out* " ~a" name))
        (t (format *html-out* " ~a=\"~a\"" name
                   (escape (if (stringp value) value (princ-to-string value)))))))

;; Macro-time: split (:tag :a 1 :b 2 child…) into attrs and children.
(defun split-attrs (forms)
  (loop while (and forms (keywordp (car forms)) (cdr forms))
        collect (list (pop forms) (pop forms)) into attrs
        finally (return (values attrs forms))))

(defun html-form (form)
  (cond ((stringp form) `(write-string ,(escape form) *html-out*))
        ((and (consp form) (eq (car form) :raw))
         `(progn ,@(mapcar (lambda (f) `(emit-raw ,f)) (cdr form))))
        ((and (consp form) (keywordp (car form)))
         (let ((tag (lower (car form))))
           (multiple-value-bind (attrs children) (split-attrs (cdr form))
             `(progn
                (write-string ,(str "<" tag) *html-out*)
                ,@(mapcar (lambda (a) `(emit-attr ,(lower (first a)) ,(second a))) attrs)
                (write-char #\> *html-out*)
                ,@(if (member (car form) *void-elements*)
                      '()
                      `(,@(mapcar #'html-form children)
                        (write-string ,(str "</" tag ">") *html-out*)))))))
        (t `(emit ,form))))

(defmacro html (&body forms)
  (with-gensyms (body)
    `(flet ((,body () ,@(mapcar #'html-form forms) nil))
       (if *html-out*
           (,body)
           (with-output-to-string (*html-out*) (,body))))))

;; (defcomponent button (text &key href) (html (:a :class "btn" :href href text)))
;; Called inside html it splices its output; called alone it returns a string.
(defmacro defcomponent (name args &body body)
  `(defun ,name ,args ,@body))

;;; ---- Markdown, the subset the model and the learner write ----------------
;;; Paragraphs, # to #### headings, - and 1. lists (nested by indent), ``` fences,
;;; > quotes, | tables |, ---, **bold**, *em*, `code`, ~~struck~~, [links](url).
;;; Everything is escaped first, so model output can never inject markup. The same
;;; subset is rendered live in the browser by static/md.js while a reply streams.

;; (wrap-pairs "a **b** c" "**" "<b>" "</b>") → "a <b>b</b> c"   — unpaired delimiters stay.
(defun wrap-pairs (s delim open close)
  (let ((n (length delim)) (start 0))
    (with-output-to-string (out)
      (loop
        (let* ((a (search delim s :start2 start))
               (b (and a (search delim s :start2 (+ a n)))))
          (unless b (write-string s out :start start) (return))
          (write-string s out :start start :end a)
          (write-string open out)
          (write-string s out :start (+ a n) :end b)
          (write-string close out)
          (setf start (+ b n)))))))

;; [text](http://…) → <a>. Only http(s) links; anything else is left as written.
(defun md-links (s)
  (let ((start 0))
    (with-output-to-string (out)
      (loop
        (let* ((a (search "[" s :start2 start))
               (b (and a (search "](" s :start2 a)))
               (c (and b (position #\) s :start (+ b 2)))))
          (unless c (write-string s out :start start) (return))
          (let ((url (subseq s (+ b 2) c)))
            (if (or (prefix-p "http://" url) (prefix-p "https://" url) (prefix-p "/" url))
                (progn (write-string s out :start start :end a)
                       (format out "<a href=\"~a\" target=\"_blank\" rel=\"noopener\">~a</a>"
                               url (subseq s (1+ a) b))
                       (setf start (1+ c)))
                (progn (write-string s out :start start :end (1+ a))
                       (setf start (1+ a))))))))))

(defun md-inline (s)
  (let ((e (escape s)))
    (setf e (wrap-pairs e "`" "<code>" "</code>"))
    (setf e (wrap-pairs e "**" "<strong>" "</strong>"))
    (setf e (wrap-pairs e "~~" "<s>" "</s>"))
    (setf e (wrap-pairs e "*" "<em>" "</em>"))
    (md-links e)))

;; "| a | b |" → ("a" "b"); NIL for a line that is not a table row.
(defun table-cells (line)
  (let ((tl (trim line)))
    (when (and (> (length tl) 1) (char= (char tl 0) #\|))
      (mapcar #'trim (split-keep-empty #\| (string-trim "|" tl))))))

(defun split-keep-empty (char s)
  (loop with start = 0
        for pos = (position char s :start start)
        collect (subseq s start pos)
        while pos do (setf start (1+ pos))))

;; "|---|:--:|" is the line under a table's header.
(defun table-rule-p (line)
  (let ((cells (table-cells line)))
    (and cells (every (lambda (c) (and (> (length c) 0) (every (lambda (ch) (find ch "-: ")) c))) cells))))

;; "3. text" → "text", else NIL.
(defun ordered-item (line)
  (let ((dot (position #\. line)))
    (when (and dot (> dot 0) (every #'digit-char-p (subseq line 0 dot))
               (< (1+ dot) (length line)) (char= (char line (1+ dot)) #\Space))
      (subseq line (+ dot 2)))))

;; Leading spaces, for nested lists: "  - b" is one level in.
(defun indent-of (line)
  (or (position-if-not (lambda (c) (char= c #\Space)) line) (length line)))

(defun md-line-kind (line)
  (let ((tl (trim line)) (depth (floor (indent-of line) 2)))
    (cond ((string= tl "") '(:blank))
          ((prefix-p "```" tl) (list :fence (trim (subseq tl 3))))
          ((prefix-p "#### " tl) (list :h 5 (subseq tl 5)))
          ((prefix-p "### " tl) (list :h 4 (subseq tl 4)))
          ((prefix-p "## " tl) (list :h 3 (subseq tl 3)))
          ((prefix-p "# " tl) (list :h 2 (subseq tl 2)))
          ((and (>= (length tl) 3) (every (lambda (c) (find c "-*_")) tl)) '(:hr))
          ((prefix-p "> " tl) (list :quote (subseq tl 2)))
          ((string= tl ">") (list :quote ""))
          ((table-cells tl) (list :row (table-cells tl)))
          ((or (prefix-p "- " tl) (prefix-p "* " tl)) (list :li "ul" (subseq tl 2) depth))
          ((ordered-item tl) (list :li "ol" (ordered-item tl) depth))
          (t (list :text tl)))))

;; (markdown->html "# Hi\n\n- a\n- b") → "<h2>Hi</h2>…<ul><li>a</li><li>b</li></ul>"
(defun markdown->html (text)
  (let ((para '()) (lists '()) (fence nil) (code '()) (bq '()) (table '()))
    (with-output-to-string (out)
      (labels ((end-para () (when para
                              (format out "<p>~a</p>~%" (md-inline (join " " (nreverse para))))
                              (setf para '())))
               ;; lists is a stack of open list tags, innermost first.
               (close-lists (to-depth)
                 (loop while (> (length lists) to-depth)
                       do (format out "</li></~a>~%" (pop lists))))
               (end-lists () (close-lists 0))
               (item (tag text depth)
                 (cond ((> (length lists) (1+ depth)) (close-lists (1+ depth))
                        (format out "</li><li>~a" (md-inline text)))
                       ((= (length lists) (1+ depth))
                        (if (equal (first lists) tag)
                            (format out "</li><li>~a" (md-inline text))
                            (progn (close-lists depth) (push tag lists)
                                   (format out "<~a><li>~a" tag (md-inline text)))))
                       (t (loop while (< (length lists) depth) do (push "ul" lists) (format out "<ul><li>"))
                          (push tag lists)
                          (format out "<~a><li>~a" tag (md-inline text)))))
               (end-quote () (when bq
                               (format out "<blockquote>~a</blockquote>~%" (markdown->html (join (string #\Newline) (nreverse bq))))
                               (setf bq '())))
               (end-table () (when table
                               (let ((rows (nreverse table)))
                                 (format out "<table><thead><tr>~{<th>~a</th>~}</tr></thead><tbody>" (mapcar #'md-inline (first rows)))
                                 (dolist (r (rest rows)) (format out "<tr>~{<td>~a</td>~}</tr>" (mapcar #'md-inline r)))
                                 (format out "</tbody></table>~%"))
                               (setf table '())))
               (end-fence () (format out "<pre~@[ class=\"lang-~a\"~]><code>~a</code></pre>~%"
                                     (and (not (blankp fence)) (escape fence))
                                     (escape (join (string #\Newline) (nreverse code))))
                             (setf code '() fence nil))
               (end-blocks () (end-para) (end-lists) (end-quote) (end-table)))
        (dolist (line (lines (or text "")))
          (if fence
              (if (prefix-p "```" (trim line)) (end-fence) (push line code))
              (destructuring-bind (kind &rest args) (md-line-kind line)
                (unless (eq kind :quote) (end-quote))
                (unless (eq kind :row) (end-table))
                (ecase kind
                  (:blank (end-para) (end-lists))
                  (:fence (end-blocks) (setf fence (or (first args) "")))
                  (:h (end-blocks)
                      (format out "<h~a>~a</h~a>~%" (first args) (md-inline (second args)) (first args)))
                  (:hr (end-blocks) (format out "<hr>~%"))
                  (:quote (end-para) (end-lists) (push (first args) bq))
                  (:row (end-para) (end-lists)
                        (unless (table-rule-p line) (push (first args) table)))
                  (:li (end-para) (item (first args) (second args) (third args)))
                  (:text (if lists
                             ;; A wrapped line inside a list item continues it.
                             (format out " ~a" (md-inline (first args)))
                             (push (first args) para)))))))
        (when fence (end-fence))
        (end-blocks)))))
