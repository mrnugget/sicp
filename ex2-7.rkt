#lang planet neil/sicp

; from the book
(define (make-interval a b) (cons a b))

; ex2.7

(define (upper-bound interval) (car interval))
(define (lower-bound interval) (cdr interval))