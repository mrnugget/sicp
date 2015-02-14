#lang planet neil/sicp

(define (double f)
  (lambda (x) (f (f x))))

(define (inc x)
  (newline)
  (display x)
  (+ x 1))

; (((double (double double)) inc) 1)

(((double (double double)) inc) 5)
