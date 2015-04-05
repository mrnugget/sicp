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


(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp)))
        ((application? exp) (analyze-application exp))
        (else
          (error "Unknown expression type -- ANALYZE" exp))))
