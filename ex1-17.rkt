#lang planet neil/sicp

; exponentiation in a logarithmic number of steps for even exponents
(define (square n)
  (* n n))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

; recursive process and recursive procedure

(define (mult-rec a b)
  (if (= b 0)
      0
      (+ a (mult-rec a (- b 1)))))

; design a multiplication procedure that uses a logarithmic number of steps

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))
; ex 1.17
(define (mult-log a b)
  (cond ((= b 0) 0)
        ((even? b) (mult-log (double a) (halve b)))
        (else (+ a (mult-log (double a) (halve (- b 1)))))))
  