(define x (list (list 1 2) (list 3 4)))
(write x)

(define (fringe l)
  (cond ((null? l) nil)
        ((not (pair? (car l)))
         (append (cons (car l) nil) (fringe (cdr l))))
        (else
          (append (fringe (car l)) (fringe (cdr l))))))

(write (fringe x))

(write (fringe (list x x)))
