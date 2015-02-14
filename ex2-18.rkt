#lang planet neil/sicp

(define (append a b)
  (if (null? a)
      b
      (cons (car a) (append (cdr a) b))))

(define (reverse list)
  (if (null? (cdr list))
      list
      (append
       (reverse (cdr list))      ; rest at beginning
       (cons (car list) nil))))  ; first element at the end

; (reverse (list 1 2 3 4))
; (append (reverse (list 2 3 4)) (list 1))
; (append (append (reverse (list 3 4)) (list 2)) (list 1))
; (append (append (append (reverse (list 4)) (list 3)) (list 2)) (list 1))
; (append (append (append (list 4) (list 3)) (list 2)) (list 1))
; (append (append (list 4 3) (list 2)) (list 1)
; (append (list 4 3 2) (list 1))
; (list 4 3 2 1)

; other solution
(define (reverse-iter l)
  (define (iter remaining result)
    (if (null? remaining)
        result
        (iter (cdr remaining) (cons (car remaining) result))))
  (iter l nil))
