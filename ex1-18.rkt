#lang planet neil/sicp

(define (square n)
  (* n n))

(define (even? n)
  (= (remainder n 2) 0))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (mult-log a b)
  (cond ((= b 0) 0)
        ((even? b) (mult-log (double a) (halve b)))
        (else (+ a (mult-log (double a) (halve (- b 1)))))))
  
; ex 1.18
(define (mult-log-iter a b)
  (define (iter a b acc)
    (cond ((= b 0) acc)
          ((even? b) (iter (double a) (halve b) acc))
          (else (iter (double a) (halve (- b 1)) (+ acc a)))))
  
  (iter a b 0))