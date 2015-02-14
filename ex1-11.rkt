#lang planet neil/sicp

; A function f is defined by the rule that
;
;   if n < 3
;     f(n) = n
; and
;
;   if n >= 3
;     f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3)

; Write a procedure that computes f by means of a recursive process

(define (f-rec n)
  (if (< n 3) n
      (+ 
       (f-rec (- n 1))
       (* 2 (f-rec (- n 2)))
       (* 3 (f-rec (- n 3))))))

; Write a procedure that computes f by means of an iterative process
(define (fi n)
  (define (iter a b c count)
    (if (> count n)
     a
     (iter 
      (+ a (* 2 b) (* 3 c))
      a
      b
      (+ count 1))))
  
  (if (< n 3) n
      (iter 2 1 0 3)))
; Seed iter with count=3 and the results of f(n-1), f(n-2), f(n-3), where n=3
; The count up to n, with a = f(n-1), b = f(n-2), c = f(n-3)
; When we reach n+1, return f(n-1), which is a