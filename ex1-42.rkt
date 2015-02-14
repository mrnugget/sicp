#lang planet neil/sicp

(define (square n)
  (* n n))

(define (inc n)
  (+ n 1))

(define (compose f g)
  (lambda (x) (f (g x))))

((compose square inc) 6)
; 49