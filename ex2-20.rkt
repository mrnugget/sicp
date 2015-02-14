#lang planet neil/sicp

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (same-parity n . r)
  (define (items-with-parity items result correct-parity?)
    (if (null? items)
        result
        (if (correct-parity? (car items))
            (items-with-parity (cdr items) (append result (list (car items))) correct-parity?)
            (items-with-parity (cdr items) result correct-parity?))))
   
  (if (even? n)
      (items-with-parity r (list n) even?)
      (items-with-parity r (list n) odd?)))
