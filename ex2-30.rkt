(define tree (list
               1
               (list 2 (list 3 4) 5)
               (list 6 7)))

(write tree)

(define (square x) (* x x))

;; without higher-order procedures
(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))
(write (square-tree tree))

;; with map
(define (m-square-tree tree)
  (map (lambda (t)
         (if (pair? t)
           (m-square-tree t)
           (square t)))
       tree))
(write (square-tree tree))


