(define x (list (list 1 2) (list 3 4)))

(define (reverse list)
  (if (null? (cdr list))
      list
      (append
       (reverse (cdr list))
       (cons (car list) nil))))

(define (deep-reverse list)
  (cond ((null? list) nil)
        ((pair? (car list)) (append
                                    (deep-reverse (cdr list))
                                    (cons (deep-reverse (car list)) nil)))
        (else (append
                (deep-reverse (cdr list))
                (cons (car list) nil)))))

(write (deep-reverse x))
