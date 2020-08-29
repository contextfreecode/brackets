(ns color)
(require '[clojure.pprint :as pp])
(import clojure.lang.Keyword)

(defrecord Rgb [r g b])
(defrecord Hsv [h s v])

(def ^:const named-colors
  {:red (Rgb. 1.0 0.0 0.0)
   :yellow (Rgb. 1.0 1.0 0.0)
   :blue (Rgb. 0.0 0.0 1.0)})

(defn hsv-to-rgb [{:keys [h s v]}]
  (let [c (* s v)
        h1 (* h 6)
        x (* c (- 1.0 (Math/abs (- (mod h1 2.0) 1.0))))
        rgb1 (cond
               (< h1 1) [c x 0.0]
               (< h1 2) [x c 0.0]
               (< h1 3) [0.0 c x]
               (< h1 4) [0.0 x c]
               (< h1 5) [x 0.0 c]
               :else [c 0.0 x])
        m (- v c)
        rgb (apply ->Rgb (map #(+ % m) rgb1))]
    rgb))

(defprotocol Color (to-rgb [color]))
(extend-protocol Color
  Hsv (to-rgb [hsv] (hsv-to-rgb hsv))
  Keyword (to-rgb [name] (get named-colors name))
  Rgb (to-rgb [rgb] rgb))

; (defmulti to-rgb class)
; (defmethod to-rgb Hsv [hsv] (hsv-to-rgb hsv))
; (defmethod to-rgb Keyword [name] (get named-colors name))
; (defmethod to-rgb Rgb [rgb] rgb)

(defn main []
  (let [colors [(Hsv. 1.0 1.0 1.0) :yellow (Rgb. 0.0 0.0 1.0)]]
    (pp/pprint colors)
    (pp/pprint (into [] (map to-rgb colors)))))

(main)
