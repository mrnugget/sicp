#lang planet neil/sicp


(define (add a b) (+ a b))
(define (inc n) (+ n 1))
(define (identity x) x)

; recursive accumulate

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner
       (term a)
       (accumulate combiner null-value term (next a) next b))))

; new sum
(define (sum-new term a next b)
  (accumulate + 0 term a next b))
(define (sum-int a b)
  (sum-new identity a inc b))


;accumulate with filter
(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b) 
      null-value
      (if (filter a) 
          (combiner (term a)
                    (filtered-accumulate filter combiner null-value term (next a) next b))
          (filtered-accumulate filter combiner null-value term (next a) next b))))

(define (sum-even-int a b)
  (filtered-accumulate even? + 0 identity a inc b))

