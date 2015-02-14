#lang planet neil/sicp

(define (square n)
  (* n n))

(define (compose f g)
  (lambda (x) (f (g x))))

; iterative process
(define (repeated f n)
  (define (iter f counter)
    (if (= counter 1)
        f
        (iter (compose f f) (- counter 1))))
  (iter f n))
; recursive process
(define (rrepeated f n)
  (if (= n 1)
      f
      (compose f (rrepeated f (- n 1)))))

((repeated square 2) 5)