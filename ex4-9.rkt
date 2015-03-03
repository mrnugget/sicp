;; while loop

(define test-exp '(while (> i 0) (display i)))

;; can be rewritten as a derived expression like this

(define (while-iter clause)
  (if (clause) (begin
                 (display i)
                 (while-iter clause))))

(define (while? exp)
  (tagged-list? exp 'while))

(define (while-condition exp)
  (cadr exp))

(define (while-body exp)
  (caddr exp))

(define (while->combination exp)
  (sequence->exp (list
                   (list 'define
                         (list 'while-iter)
                         (make-if (while-condition exp)
                                  (sequence->exp (list (while-body exp) (list 'while-iter)))
                                  '()))
                   (list 'while-iter))))

;; To hook it up in eval:
(while? exp) (eval (while->combination exp) env)

(write (while->combination test-exp))

;; -> (begin (define (while-iter) (if (> i 0) (begin (display i) (while-iter)) ())) (while-iter))
