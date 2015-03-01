;; a `let*` expression can be rewritten as `let` by nesting the `let`s

(let* ((x 5)
       (y 5)
       (z (+ x y)))
  (* z 2))

;; is equal to

(let ((x 5))
  (let ((y 5))
    (let ((z (+ x y)))
      (* z 2))))

;; a) implement `let*->nested-lets`

(define (make-nested-lets variables expressions body)
  (if (or (null? variables) (null? expressions)) body
    (list 'let
          (list (list (car variables) (car expressions)))
          (make-nested-lets (cdr variables) (cdr expressions) body))))

(define (let*->nested-lets exp)
  (make-nested-lets
    (let-variables exp)
    (let-expressions exp)
    (let-body exp)))

;; testing
;; (define nle (list 'let* (list (list 'var1 'exp1) (list 'var2 'exp3)) 'body))
;; (write (let*->nested-lets nle))
;; -> (let ((var1 exp1)) (let ((var2 exp3)) (body)))


;; b) It is okay to hook up the nested lets in the evaluator with
;; (eval (let*->nested-lets exp) env)
;; since the `let` get turned into lambdas, which get evaluated in turn

(define (let*? exp)
  (tagged-list? exp 'let*))

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
        ((let? exp) (eval (let->combination exp) env))
        ((let*? exp) (eval (let*->nested-lets exp) env)) ;; new
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))
