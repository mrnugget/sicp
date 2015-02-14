#lang planet neil/sicp

(define (iterative-improve good-enough improve-guess)
  (define (iter guess)
    (if (good-enough guess)
        guess
        (iter good-enough improve-guess (improve-guess guess))))
  (lambda (guess) (iter guess)))