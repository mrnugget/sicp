#lang planet neil/sicp

; first definition

(define (square-list items)
  (if (null? items)
    nil
    (cons (* (car items) (car items)) (square-list (cdr items)))))

; second defintion

(define (square-list items)
  (map (lambda (x) (* x x)) items))
