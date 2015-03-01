;; Simple version of proc without a table
;; So it's not "really" data directed
(define (get proc)
  (cond ((eq? proc 'quote) (lambda (exp env) (text-of-quotation exp)))
        ((eq? proc 'set!) eval-assigment)
        ((eq? proc 'define) eval-definition)
        ((eq? proc 'if) eval-if)
        ((eq? proc 'lambda) (lambda (exp env)
                              (make-procedure (lambda-parameters exp)
                                              (lambda-body exp)
                                              env)))
        ((eq? proc 'begin) (lambda (exp env)
                             (eval-sequence (begin-actions exp) env)))
        ((eq? proc 'cond) (lambda (exp env)
                            (eval (cond->if exp) env)))
        (else (error "Unknown procedure -- GET" proc))))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        (((get (car exp)) (cdr exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

