#lang planet neil/sicp

(define (length list)
  (if (null? list)
      0
      (+ 1 (length (cdr list)))))

(define (last-pair list)
  (if (= (length list) 1)
      list
      (last-pair (cdr list))))

; other solutions from here: http://www.billthelizard.com/2010/12/sicp-217-last-item-in-list.html

(define (last-pair-r list)
  (if (null? (cdr list))
      list
      (last-pair-r (cdr list))))
