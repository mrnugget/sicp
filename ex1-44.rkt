#lang planet neil/sicp

(define (smooth f)
  (let ((dx 0.7))
    (define (average a b c)
      (/ (+ a b c) 3))
    (lambda (x) (average (f (- x dx)) (f x) (f (+ x dx))))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter f counter)
    (if (= counter 1)
        f
        (iter (compose f f) (- counter 1))))
  (iter f n))

(define (n-smooth f n)
  ((repeated smooth n) f))