#lang planet neil/sicp

(define (add a b) (+ a b))
(define (inc n) (+ n 1))
(define (identity x) x)

; sum procedure from book
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (sum-old-int a b)
  (sum identity a inc b))

(define (product term a next b)
  (if (> a b)
      1 
      (* (term a) (product term (next a) next b))))

; ex1.32: Show that sum and product are both special cases of a still more
; general notion called accumulate that combines a collection of terms,
; using some general accumulation function:
;
;     (accumulate combiner null-value term a next b)
;
; Write accumulate.

; recursive process (folding from right)
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner
       (term a)
       (accumulate combiner null-value term (next a) next b))))

; Write accumulator to generate an iterative process

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

; new sum
(define (sum-new term a next b)
  (accumulate + 0 term a next b))
(define (sum-int a b)
  (sum-new identity a inc b))
