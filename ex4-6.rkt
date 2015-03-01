(define (let? exp)
  (tagged-list? exp 'let))

(define (let-head exp)
  (cadr exp))

(define (let-body exp)
  (cddr exp))

(define (let-variables exp)
  (map car (let-head exp)))

(define (let-expressions exp)
  (map cadr (let-head exp)))

(define (let->combination exp)
  (cons
    (list 'lambda (let-variables exp) (let-body exp))
    (let-expressions exp)))

;; testing:
;; (define le (list 'let (list (list 'var1 'exp1) (list 'var2 'exp2)) 'body))
;; -> ('let (('var1 'exp1) ('var2 'exp2)) 'body)
;; (write (let->combination le))
;; -> ((lambda (var1 var2) (body)) exp1 exp2)

;; Use it in evaluator

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
        ((let? exp) (eval (let->combination exp) env)) ;; new
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))


