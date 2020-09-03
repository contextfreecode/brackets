#lang racket
 
(require racket/match)

(struct Rgb (r g b) #:transparent)

(define (darken rgb)
  (match-define (Rgb r g b) rgb)
  (define scale 0.5)
  (Rgb (* scale r) (* scale g) (* scale b)))
  ;;;   (apply ->Rgb (map #(* scale %) [r g b]))))

(define named-colors
  (hash
    'red (Rgb 1.0 0.0 0.0)
    'yellow (Rgb 1.0 1.0 0.0)
    'blue (Rgb 0.0 0.0 1.0)))

(define (main)
  (let* ([names #(red yellow blue)]
         [rgbs (vector-map ((curry hash-ref) named-colors) names)]
         [darks (vector-map darken rgbs)])
    (for ([i (in-range (vector-length names))])
      (displayln (string-join (map ~v (list
        (vector-ref names i)
        (vector-ref rgbs i)
        (vector-ref darks i))))))))
  ;;; (define names #(red yellow blue))
  ;;; (define rgbs (vector-map ((curry hash-ref) named-colors) names))
  ;;; (println names)
  ;;; (println rgbs)
  ;;; (println (darken (hash-ref named-colors 'red)))
  ;;; (printf "Hi ~v~n" (hash-ref named-colors 'red)))

(main)
