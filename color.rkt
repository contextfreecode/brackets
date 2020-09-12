#lang racket
(require racket/match)

(struct Rgb (r g b) #:transparent)

(define (darken rgb)
  (match-define (Rgb r g b) rgb)
  (define scale 0.5)
  (Rgb (* scale r) (* scale g) (* scale b)))
  ; (apply Rgb (map (lambda (x) (* scale x)) (list r g b))))

(define named-colors
  (hash
    'red (Rgb 1.0 0.0 0.0)
    'yellow (Rgb 1.0 1.0 0.0)
    'blue (Rgb 0.0 0.0 1.0)))

(define (main)
  (let* ([names #(red yellow blue)]
         [rgbs (vector-map ((curry hash-ref) named-colors) names)]
         [darks (vector-map darken rgbs)])
    ; Zip might be better here.
    (for ([i (in-range (vector-length names))])
      (printf "~v ~v ~v~n"
        (vector-ref names i)
        (vector-ref rgbs i)
        (vector-ref darks i)))))
      ; Alternatively, map through vector-ref, stringify, and join.
      ; (displayln (string-join (map
      ;   (lambda (vec) (~v (vector-ref vec i)))
      ;   (list names rgbs darks)))))))

(main)
