;; construct l as a ring

(define l (list 'a 'b 'c 'd))
(set-cdr! (cdddr l) l)

(define non-cycle (list 'a 'b 'c 'd))

(define (is-cycle? l)
  (define (iter first rest)
    (cond ((null? rest) #f)
          ((eq? first (car rest)) #t)
          (else (iter first (cdr rest)))))
  (iter (car l) (cdr l)))


(is-cycle? l) ;; -> #t
(is-cycle? non-cycle) ;; -> #f

;; the solution is not really correct, since it doesn't detect cycles in the
;; middle of a list
