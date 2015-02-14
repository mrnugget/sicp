#lang planet neil/sicp

; before let.
; Use lambda to introduce "local" variables.
(define (local-lambda a b)
  ((lambda (x y)
    (+ (* x 2)
       (* y 2)))
  (+ a 10)
  (+ b 20)))

; using let:

(define (local-let a b)
  (let ((x (+ a 10))
        (y (+ b 20)))
    (+ (* x 2)
       (* y 2))))



(let ((x 3)
      (y (+ x 2)))
  (* x y))