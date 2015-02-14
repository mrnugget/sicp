(define (equal? list1 list2)
  (cond ((or (null? list1) (null? list2)) #t)
    ((eq? (car list1) (car list2)) (equal? (cdr list1) (cdr list2)))))

(write (equal? '(this is a list) '(this is a list)))
(write (equal? '(this is a list) '(this (is a) list)))
