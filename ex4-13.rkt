;; Add a `make-unbound!` procedure to the evaluator which does the opposite
;; of `define`.

;; I also decided that `make-unbound!` only removes the binding in first frame
;; of the environment, since this is how `define` works.
;; Since you can `define` something inside a procedure, which means in its own
;; environment, it makes sense that `make-unbound!` only works in the current
;; environment too.


(define (unbinding? exp)
  (tagged-list? exp 'make-unbound!))

(define (unbinding-variable exp)
  (cadr exp))

(define (remove-binding exp env)
  (remove-variable! (unbinding-variable exp) env))

(define (remove-variable! var env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((or (null? vars) (null? (cdr vars)))
             (error "Variable not found -- MAKE-UNBOUND!" var))
            ((eq? var (cadr vars))
             (begin
               (set-cdr! vars (cddr vars))
               (set-cdr! vals (cddr vals))))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))


;; testing
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())
(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
    (cons (make-frame vars vals) base-env)
    (if (< (length vars) (length vals))
      (error "Too many arguments supplied" vars vals)
      (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))


(define test-env
  (extend-environment (list 'one 'two 'three 'four) (list 1 2 3 4) the-empty-environment))

(lookup-variable-value 'three test-env)

(remove-variable! 'three test-env)

(lookup-variable-value 'three test-env) ;; results in 'Unbound variable three' error

(lookup-variable-value 'four test-env)

(remove-variable! 'four test-env)

(lookup-variable-value 'four test-env)

