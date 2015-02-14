(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define m (make-mobile (make-branch 2 (list 1 2)) (make-branch 3 (list 3 4 5))))
(write m)

; Write left-branch and right-branch
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))

; Write branch-length and branch-structure
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

; Write total-weight
(define (branch-weight branch)
  (if (pair? (branch-structure branch))
    (total-weight (branch-structure branch))
    (branch-structure branch)))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))
