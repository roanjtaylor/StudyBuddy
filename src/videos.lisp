;;;; L5b — Images and videos for an idea: browsed under the idea, pinned beside the chat.
;;;;
;;;; A video pin is (:id "computers/ram/VIDEOID" :map :node :video :title :channel :at), kept in
;;;; data/videos.lisp beside the map (not inside it, so the model rewriting an idea never
;;;; drops them). An image pin is the same in data/images.lisp. Video search scrapes YouTube's
;;;; public results page; image search uses Wikimedia Commons' open API: no key for either.
;;;; The browser side is static/videos.js.

(in-package :studybuddy)

(defstore video (:file "videos.lisp" :key :id))
(defstore image (:file "images.lisp" :key :id))

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

;;; ---- Images: Wikimedia Commons ----------------------------------------------

(defun node-images (node)
  (remove-if-not (lambda (v) (and (equal (getf v :map) (map-id)) (equal (getf v :node) node)))
                 (images)))

(defun image-key (title) (format nil "~36r" (sxhash title)))

(defun image-pin-id (node key) (str (map-id) "/" node "/" key))

(defun pin-image! (node key title thumb page)
  (put-image! (list :id (image-pin-id node key) :map (map-id) :node node :key key
                    :title (trim (or title "Image")) :thumb thumb :page page :at (now-iso))))

(defun unpin-image! (node key)
  (let ((id (image-pin-id node key)))
    (when (find-image id)
      (setf *images* (remove id *images* :key (lambda (v) (getf v :id)) :test #'equal))
      (save-images)
      id)))

;; "File:Some_name.jpg" → "Some name"
(defun clean-file-title (s)
  (let* ((s (if (prefix-p "File:" s) (subseq s 5) s))
         (dot (position #\. s :from-end t)))
    (substitute #\Space #\_ (if dot (subseq s 0 dot) s))))

;; (search-images "transistor") → list of plists, up to 12 pictures with thumbnails.
(defun search-images (query)
  (let* ((url (str "https://commons.wikimedia.org/w/api.php?action=query&format=json&generator=search"
                   "&gsrnamespace=6&gsrlimit=12&prop=imageinfo&iiprop=url%7Cmime&iiurlwidth=480&gsrsearch="
                   (quri:url-encode (str query " filetype:bitmap"))))
         (data (jzon:parse (dex:get url :headers *browser-headers* :force-string t)))
         (pages (jget data "query" "pages"))
         (found '()))
    (when (hash-table-p pages)
      (maphash (lambda (k p) (declare (ignore k))
                 (let ((info (jget p "imageinfo" 0)))
                   (when (and info (stringp (jget info "thumburl")))
                     (push (list (or (jget p "index") 0)
                                 (list :key (image-key (jget p "title"))
                                       :title (clean-file-title (jget p "title"))
                                       :thumb (jget info "thumburl")
                                       :page (or (jget info "descriptionurl") "")))
                           found))))
               pages))
    (mapcar #'second (sort found #'< :key #'first))))

;;; ---- The browser under an idea, and the pins beside the chat ----------------

(defun video-thumb (id) (str "https://i.ytimg.com/vi/" id "/mqdefault.jpg"))

(defcomponent video-item (v)
  (html (:li :class "vid" :data-video (getf v :video)
          (:button :type "button" :class "vid-play" :data-video (getf v :video)
                   :data-title (getf v :title) :data-channel (getf v :channel)
            (:img :src (video-thumb (getf v :video)) :alt "" :loading "lazy")
            (:span :class "vid-meta"
              (:span :class "vid-title" (getf v :title))
              (:span :class "quiet small" (getf v :channel))))
          (:div :class "pin-tools"
            (:button :type "button" :class "pin-tool pin-remove" :data-kind "video" :data-key (getf v :video)
                     :title "Unpin this video" :aria-label "Unpin this video" (icon "trash"))))))

(defcomponent image-item (v)
  (html (:li :class "vid pin-img" :data-image (getf v :key)
          (:a :class "pin-img-link" :href (getf v :page) :target "_blank" :rel "noopener"
              :title (getf v :title)
            (:img :src (getf v :thumb) :alt (getf v :title) :loading "lazy"))
          (:div :class "pin-tools"
            (:button :type "button" :class "pin-tool pin-remove" :data-kind "image" :data-key (getf v :key)
                     :title "Unpin this image" :aria-label "Unpin this image" (icon "trash"))))))

;; A pinned artifact: its card (opens on the stage) and a way to unpin.
(defcomponent artifact-item (a)
  (html (:li :class "vid pin-art" :data-artifact (getf a :id)
          (artifact-card a)
          (:div :class "pin-tools"
            (:button :type "button" :class "pin-tool pin-remove" :data-kind "artifact" :data-key (getf a :id)
                     :title "Unpin this artifact" :aria-label "Unpin this artifact" (icon "trash"))))))

;; Pinned images and videos, at the foot of the idea above Browse: "Images:" then "Videos:".
;; Each group is hidden until something is pinned. static/videos.js fills and empties them.
(defcomponent pin-tray (n)
  (let ((id (getf n :id)))
    (html (:div :class "pin-tray" :data-map (map-id) :data-node id
                :hidden (not (or (node-images id) (node-videos id) (node-pinned-artifacts id)))
            (:div :class "pin-group pin-artifacts" :hidden (null (node-pinned-artifacts id))
              (:h3 "Made:")
              (:ul :class "pin-list" (dolist (v (node-pinned-artifacts id)) (artifact-item v))))
            (:div :class "pin-group pin-images" :hidden (null (node-images id))
              (:h3 "Images:")
              (:ul :class "pin-list" (dolist (v (node-images id)) (image-item v))))
            (:div :class "pin-group pin-videos" :hidden (null (node-videos id))
              (:h3 "Videos:")
              (:ul :class "pin-list" (dolist (v (node-videos id)) (video-item v))))))))

;; The Browse button at the foot of the idea, and the panel it opens: one search bar,
;; images on the left and videos on the right.
(defcomponent video-section (n)
  (html (:section :class "videos" :data-map (map-id) :data-node (getf n :id) :data-title (getf n :title)
          (pin-tray n)
          (:div :class "browse-bar"
            (:button :type "button" :class "browse-open" :aria-expanded "false" "Browse"))
          (:div :class "browse" :hidden t
            (:div :class "browse-cols"
              (:section :class "browse-col browse-images" :aria-label "Images"
                (:form :class "browse-search" :data-kind "images" :action "/action/image-search" :method "post"
                  (:input :type "text" :name "q" :autocomplete "off"
                          :placeholder "Search images…" :aria-label "Search images")
                  (:button :type "submit" "Search"))
                (:p :class "quiet small col-status" :role "status")
                (:ul :class "img-results"))
              (:section :class "browse-col browse-videos" :aria-label "Videos"
                (:form :class "browse-search" :data-kind "videos" :action "/action/video-search" :method "post"
                  (:input :type "text" :name "q" :autocomplete "off"
                          :placeholder "Search YouTube, or paste a link…" :aria-label "Search YouTube")
                  (:button :type "submit" "Search"))
                (:p :class "quiet small col-status" :role "status")
                (:ul :class "vid-results")))))))

;;; ---- Actions ---------------------------------------------------------------

(defun json-reply (&rest kvs)
  (raw-response "application/json" (jzon:stringify (apply #'obj kvs))))

(defun plist->obj (r)
  (apply #'obj (loop for (k v) on r by #'cddr append (list (lower k) v))))

(defaction video-search "/action/video-search" (q)
  (cond ((blankp q) (json-reply "ok" nil "error" "Type something to search for."))
        ;; A pasted link is a single result, not a search.
        ((parse-video-id q)
         (let* ((id (parse-video-id q)) (d (video-details id)))
           (json-reply "ok" t
                       "results" (vector (obj "video" id "title" (or (getf d :title) "YouTube video")
                                              "channel" (or (getf d :channel) "") "avatar" "" "length" "" "views" "" "published" "")))))
        (t (handler-case
               (json-reply "ok" t "results" (coerce (mapcar #'plist->obj (search-youtube (trim q))) 'vector))
             (error () (json-reply "ok" nil "error" "YouTube could not be reached. Try again, or paste a link."))))))

(defaction image-search "/action/image-search" (q)
  (cond ((blankp q) (json-reply "ok" nil "error" "Type something to search for."))
        ((parse-video-id q) (json-reply "ok" t "results" (vector)))   ; a video link has no images
        (t (handler-case
               (json-reply "ok" t "results" (coerce (mapcar #'plist->obj (search-images (trim q))) 'vector))
             (error () (json-reply "ok" nil "error" "Images could not be loaded. Try again."))))))

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

;; Only addresses on Wikimedia are kept, as the search itself returns them.
(defaction pin-image "/action/pin-image" (map-name node-id key title thumb page)
  (cond ((not (select-map map-name)) (json-reply "ok" nil "error" "No such field."))
        ((not (find-node node-id)) (json-reply "ok" nil "error" "No such idea."))
        ((or (blankp key)
             (not (or (prefix-p "https://upload.wikimedia.org/" (or thumb ""))
                      (prefix-p "https://thumb.wikimedia.org/" (or thumb ""))))
             (not (prefix-p "https://commons.wikimedia.org/" (or page ""))))
         (json-reply "ok" nil "error" "That is not an image."))
        (t (json-reply "ok" t "html" (image-item (pin-image! node-id key title thumb page))))))

(defaction unpin-image "/action/unpin-image" (map-name node-id key)
  (if (and (select-map map-name) (unpin-image! node-id key))
      (json-reply "ok" t)
      (json-reply "ok" nil "error" "That image was not pinned.")))

;; Pin an artifact to an idea, or unpin it. Pinned, it stays with the idea for later chats.
(defaction pin-artifact "/action/pin-artifact" (map-name node-id id)
  (let ((a (and (select-map map-name) (find-artifact id))))
    (cond ((null a) (json-reply "ok" nil "error" "No such artifact."))
          ((not (find-node node-id)) (json-reply "ok" nil "error" "No such idea."))
          (t (json-reply "ok" t "html" (artifact-item (pin-artifact! id node-id)))))))

(defaction unpin-artifact "/action/unpin-artifact" (map-name id)
  (if (and (select-map map-name) (unpin-artifact! id))
      (json-reply "ok" t)
      (json-reply "ok" nil "error" "That artifact was not pinned.")))
