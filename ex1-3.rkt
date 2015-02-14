#lang planet neil/sicp

(define (square x)
  (* x x))

(define (sum-of-squares a b)
  (+ (square a) (square b)))

; My first solution
(define (sum-of-squares-two-biggest a b c)
  (cond ((or (< a b c) (< a c b)) (sum-of-squares b c))
        ((or (< b a c) (< b c a)) (sum-of-squares a c))
        ((or (< c a b) (< c b a)) (sum-of-squares b a))))

; Inspired by SO: http://stackoverflow.com/questions/161666/sicp-exercise-1-3-request-for-comments
(define (min a b)
  (if (< a b) a b))
(define (max a b)
  (if (> a b) a b))

(define (sum-of-squares-two-biggest-so a b c)
  (sum-of-squares (max a b) (max c (min a b))))


