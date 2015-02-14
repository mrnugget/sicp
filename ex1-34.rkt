#lang planet neil/sicp

(define (f g)
  (g 2))

(f (lambda (x) (* x x)))
(f (lambda (x) (* x (+ x 1))))

; ex 1.34: what happens when we run this: (f f)
; prediction: it's going to crash
; result: yep, crash. 2 is not a procedure.