#lang planet neil/sicp
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))


;; define generic split operation that can be used by up-split and right-split

(define (split position-bigger position-smaller)
  (define (p painter n)
    (if (= n 0)
        painter
        (let ((smaller (p painter (- n 1))))
          (position-bigger painter (position-smaller smaller smaller)))))
  p)

(define gen-right-split (split beside below))
(define gen-up-split (split below beside))
