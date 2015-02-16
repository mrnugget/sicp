(define (mystery x)
  (define (loop x y)
    (if (null? x)
      y
      (let ((temp (cdr x)))
        (set-cdr! x y)
        (loop temp x))))
  (loop x '()))

;; mystery reverses the order of elements in a list by cutting the original list
;; up

(define l (list 'a 'b 'c 'd 'e 'f))
(write l)

(define w (mystery l))
(write w)

;; l is now the pointer to the last element: (cons 'a nil)
;; w is the pointer to the last-element of the original `l`, which is now
;; the first element of `w`
