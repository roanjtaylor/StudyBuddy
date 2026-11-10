;;;; L5b — Videos pinned to an idea.
;;;;
;;;; A pin is (:id "computers/ram/VIDEOID" :map :node :video :title :channel :at), kept in
;;;; data/videos.lisp beside the map (not inside it, so the model rewriting an idea never
;;;; drops them). Search scrapes YouTube's public results page: no API key needed.
;;;; The browser side is static/videos.js.

(in-package :studybuddy)

(defstore video (:file "videos.lisp" :key :id))

(defun node-videos (node)
  (remove-if-not (lambda (v) (and (equal (getf v :map) (map-id)) (equal (getf v :node) node)))
                 (videos)))

(defun video-pin-id (node video) (str (map-id) "/" node "/" video))

(defun pin-video! (node video title channel)
  (put-video! (list :id (video-pin-id node video) :map (map-id) :node node :video video
                    :title (trim (or title "Untitled video")) :channel (trim (or channel ""))
                    :at (now-iso))))

(defun unpin-video! (node video)
  (let ((id (video-pin-id node video)))
    (when (find-video id)
      (setf *videos* (remove id *videos* :key (lambda (v) (getf v :id)) :test #'equal))
      (save-videos)
      id)))

;;; ---- YouTube ids and search -----------------------------------------------

(defun video-id-char-p (c) (or (alphanumericp c) (char= c #\-) (char= c #\_)))

;; A bare 11-character id, or the id inside a watch / youtu.be / embed / shorts / live link.
(defun parse-video-id (s)
  (let ((s (trim (or s ""))))
    (flet ((take (marker)
             (let ((p (search marker s)))
               (when p
                 (let* ((start (+ p (length marker)))
                        (end (or (position-if-not #'video-id-char-p s :start start) (length s))))
                   (when (= (- end start) 11) (subseq s start end)))))))
      (cond ((and (= (length s) 11) (every #'video-id-char-p s)) s)
            (t (or (take "v=") (take "youtu.be/") (take "/embed/") (take "/shorts/") (take "/live/")))))))

(defparameter *browser-headers*
  '(("User-Agent" . "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36")
    ("Accept-Language" . "en-US,en;q=0.9")))

(defun jget (x &rest path)
  (dolist (k path x)
    (setf x (cond ((and (hash-table-p x) (stringp k)) (gethash k x))
                  ((and (vectorp x) (not (stringp x)) (integerp k) (< k (length x))) (aref x k))
                  (t nil)))))

(defun text-of (x)
  (or (jget x "simpleText") (jget x "runs" 0 "text")))

;; Every "videoRenderer" object anywhere inside the parsed page data, in page order.
(defun collect-video-renderers (x)
  (let ((found '()))
    (labels ((walk (x)
               (cond ((hash-table-p x)
                      (let ((v (gethash "videoRenderer" x)))
                        (if (hash-table-p v)
                            (push v found)
                            (maphash (lambda (k val) (declare (ignore k)) (walk val)) x))))
                     ((and (vectorp x) (not (stringp x))) (map nil #'walk x)))))
      (walk x))
    (nreverse found)))

(defun youtube-initial-data (html)
  (let* ((marker "ytInitialData = ")
         (p (search marker html)))
    (when p
      (let* ((start (+ p (length marker)))
             (end (search ";</script>" html :start2 start)))
        (when end (jzon:parse (subseq html start end)))))))

;; (search-youtube "transistor explained") → list of plists, up to 12 videos.
(defun search-youtube (query)
  (let* ((url (str "https://www.youtube.com/results?search_query=" (quri:url-encode query)))
         (page (dex:get url :headers *browser-headers* :force-string t))
         (data (youtube-initial-data page)))
    (loop for r in (collect-video-renderers data)
          for id = (jget r "videoId")
          when (and (stringp id) (= (length id) 11))
            collect (list :video id
                          :title (or (text-of (jget r "title")) "Untitled video")
                          :channel (or (text-of (jget r "ownerText")) "")
                          :avatar (or (jget r "channelThumbnailSupportedRenderers" "channelThumbnailWithLinkRenderer" "thumbnail" "thumbnails" 0 "url") "")
                          :length (or (text-of (jget r "lengthText")) "")
                          :views (or (text-of (jget r "shortViewCountText")) (text-of (jget r "viewCountText")) "")
                          :published (or (text-of (jget r "publishedTimeText")) ""))
              into out
          finally (return (subseq out 0 (min 12 (length out)))))))

;; Title and channel of one video, from YouTube's oEmbed.
(defun video-details (id)
  (handler-case
      (let ((j (jzon:parse (dex:get (str "https://www.youtube.com/oembed?format=json&url="
                                         (quri:url-encode (str "https://www.youtube.com/watch?v=" id)))
                                    :headers *browser-headers* :force-string t))))
        (list :title (jget j "title") :channel (jget j "author_name")))
    (error () nil)))

;;; ---- The section under an idea ---------------------------------------------

(defun video-thumb (id) (str "https://i.ytimg.com/vi/" id "/mqdefault.jpg"))

(defcomponent video-item (v)
  (html (:li :class "vid" :data-video (getf v :video)
          (:button :type "button" :class "vid-play" :data-video (getf v :video)
                   :data-title (getf v :title) :data-channel (getf v :channel)
            (:img :src (video-thumb (getf v :video)) :alt "" :loading "lazy")
            (:span :class "vid-meta"
              (:span :class "vid-title" (getf v :title))
              (:span :class "quiet small" (getf v :channel))))
          (:button :type "button" :class "vid-unpin" :title "Unpin this video"
                   :aria-label "Unpin this video" :data-video (getf v :video) "×"))))

;; Pinned videos, then the button that opens the browser. static/videos.js does the rest.
(defcomponent video-section (n)
  (let ((vs (node-videos (getf n :id))))
    (html (:section :class "videos" :data-map (map-id) :data-node (getf n :id) :data-title (getf n :title)
            (:h2 :class "videos-h" :hidden (null vs) "Videos")
            (:div :class "vid-player" :hidden t)
            (:ul :class "vid-list" :hidden (null vs)
              (dolist (v vs) (video-item v)))
            (:button :type "button" :class "vid-open" :aria-expanded "false"
              (:span :class "yt-ico" :aria-hidden "true" "▶") "Find videos")
            (:div :class "vid-browse" :hidden t
              (:form :class "vid-search" :action "/action/video-search" :method "post"
                (:input :type "text" :name "q" :autocomplete "off"
                        :placeholder "Search YouTube, or paste a link…" :aria-label "Search YouTube")
                (:button :type "submit" "Search"))
              (:p :class "quiet small vid-status" :role "status")
              (:ul :class "vid-results"))))))

;;; ---- Actions ---------------------------------------------------------------

(defun json-reply (&rest kvs)
  (raw-response "application/json" (jzon:stringify (apply #'obj kvs))))

(defaction video-search "/action/video-search" (q)
  (cond ((blankp q) (json-reply "ok" nil "error" "Type something to search for."))
        ;; A pasted link is a single result, not a search.
        ((parse-video-id q)
         (let* ((id (parse-video-id q)) (d (video-details id)))
           (json-reply "ok" t
                       "results" (vector (obj "video" id "title" (or (getf d :title) "YouTube video")
                                              "channel" (or (getf d :channel) "") "avatar" "" "length" "" "views" "" "published" "")))))
        (t (handler-case
               (json-reply "ok" t
                           "results" (coerce (mapcar (lambda (r)
                                                       (apply #'obj (loop for (k v) on r by #'cddr
                                                                          append (list (lower k) v))))
                                                     (search-youtube (trim q)))
                                             'vector))
             (error () (json-reply "ok" nil "error" "YouTube could not be reached. Try again, or paste a link."))))))

(defaction pin-video "/action/pin-video" (map-name node-id video title channel)
  (cond ((not (select-map map-name)) (json-reply "ok" nil "error" "No such field."))
        ((not (find-node node-id)) (json-reply "ok" nil "error" "No such idea."))
        ((not (parse-video-id video)) (json-reply "ok" nil "error" "That is not a video."))
        (t (let ((v (pin-video! node-id (parse-video-id video) title channel)))
             (json-reply "ok" t "html" (video-item v))))))

(defaction unpin-video "/action/unpin-video" (map-name node-id video)
  (if (and (select-map map-name) (unpin-video! node-id video))
      (json-reply "ok" t)
      (json-reply "ok" nil "error" "That video was not pinned.")))
