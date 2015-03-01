;; Add `and` and `or` to the evaluator

(define (and? exp)
  (tagged-list? exp 'and))

(define (and-clauses exp)
  (cdr exp))

(define (eval-and clauses env)
  (if (null? clauses) true
    (let ((result (eval (first-exp clauses) env)))
      (if (true? result)
        (eval-and (rest-exps clauses) env)
        false))))

(define (or? exp)
  (tagged-list? exp 'or))

(define (or-clauses exp)
  (cdr exp))

(define (eval-or clauses env)
  (if (null? clauses) false
    (let ((result (eval (first-exp clauses) env)))
      (if (true? result)
        result
        false))))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((and? exp) (eval-and (and-clauses exp) env))
        ((or? exp) (eval-or (or-clauses exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))
