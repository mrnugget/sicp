#lang planet neil/sicp

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define (length list)
  (if (null? list)
      0
      (+ 1 (length (cdr list)))))

(define (length-iter list)
  (define (iter a count)
    (if (null? a)
        count
        (iter (cdr a) (+ count 1))))
  (iter list 0))

(define (append a b)
  (if (null? a)
      a
      (cons (car a) (append (cdr a) b))))

