(ns color)

(defrecord Rgb [r g b])

(defn darken [{:keys [r g b]}]
  (let [scale 0.5]
    (apply ->Rgb (map #(* scale %) [r g b]))))
    ; (Rgb. (* scale r) (* scale g) (* scale b))))

(def ^:const named-colors
  {:red (Rgb. 1.0 0.0 0.0)
   :yellow (Rgb. 1.0 1.0 0.0)
   :blue (Rgb. 0.0 0.0 1.0)})

(defn main []
  (let [names [:red :yellow :blue]
        rgbs (into [] (map named-colors names))
        darks (into [] (map darken rgbs))]
    (doseq [i (range (count names))]
      (println (names i) (rgbs i) (darks i)))))
      ; (apply println (map #(% i) [names rgbs darks])))))

(main)
