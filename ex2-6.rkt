#lang planet neil/sicp
; from the book
(define zero
  (lambda (f)
    (lambda (x) x)))

(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))


; solutions to `one` and `two`

(define one
  (lambda (f) 
    (lambda (x) (f x))))

(define two
  (lambda (f)
    (lambda (x) (f (f x)))))

; `add` procedure, inspired by this: http://jlongster.com/SICP-2.6--Church-Numerals

(define (add a b)
  (lambda (f)
    (lambda (x)
      ((a f) ((b f) x)))))

(define (church->integer f)
  (define (add-one x) (+ x 1))
  ((f add-one) 0))