(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define tree (list (list 1 2) (list 3 4)))

;; Redefine count-leaves from section 2.2.2 as an accumulation
;; original:
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

;; with accumulation

(define (enumerate-tree tree)
   (cond ((null? tree) null)
         ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                       (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (accumulate
    +
    0
    (map (lambda (x) 1) (enumerate-tree t))))
