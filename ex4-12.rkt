;; Functions from the book to make `lookup-variable-value`,
;; `set-variable-value!` and `define-variable!` work

(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

(define (make-frame variables values) (cons variables values))
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

(define (scan-environment var found-proc env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars) (env-loop (enclosing-environment env)))
            ((eq? var (car vars)) (found-proc vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

(define (lookup-variable-value var env)
  (scan-environment var (lambda (vals) (car vals)) env))

(define (set-variable-value! var val env)
  (scan-environment var (lambda (vals) (set-car! vals val)) env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

;; testing
(define test-env
  (extend-environment '(key1 key2 key3 key4) '(val1 val2 val3 val4) the-empty-environment))

(write (lookup-variable-value 'key3 test-env))
; (set-variable-value! 'key3 'new-val3 test-env)
(write (lookup-variable-value 'key3 test-env))

; (write (lookup-variable-value 'keyX test-env))
; (set-variable-value! 'keyX 'should-fail test-env)
; (write (lookup-variable-value 'keyX test-env))

(write (lookup-variable-value 'key1 test-env))
(define-variable! 'keyX 'valX test-env)
(write (lookup-variable-value 'keyX test-env))
