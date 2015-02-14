#lang planet neil/sicp
; from ex2.2
(define (average a b)
  (/ (+ a b) 2))

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


; ex 2.3

(define (make-rect p1 p2 p3 p4)
  (cons p1 (cons p2 (cons p3 p4))))

; did not finish this. solution would include using either 2 points for a rectangle
; or two segments...