;; solution taken from here: http://community.schemewiki.org/?sicp-ex-2.32

(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s))))
      (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(define set (list 1 2 3))
(write (subsets set))
