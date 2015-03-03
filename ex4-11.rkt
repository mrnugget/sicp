;; unchanged
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

;; change frame functions to work with key-value pairs
(define make-frame-pair cons)

(define (make-frame variables values)
  (cons 'frame
        (map make-frame-pair variables values)))

(define (frame-pairs frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame
            (cons (make-frame-pair var val) (frame-pairs frame))))

;;; testing frame functions
(define test-frame (make-frame (list 'key1 'key2) (list 'val1 'val2)))

(add-binding-to-frame! 'key3 'val3 test-frame)

(write (frame-pairs test-frame))

;; change lookup-variable-value
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan pairs)
      (cond ((null? pairs) (env-loop (enclosing-environment env)))
            ((eq? var (caar pairs)) (cdar pairs))
            (else (scan (cdr pairs)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (scan (frame-pairs (first-frame env)))))
  (env-loop env))

;; testing lookup-variable-value
(define test-environment (list test-frame the-empty-environment))
(lookup-variable-value 'key3 test-environment)
;; -> 'val3

;; change set-variable-value!
(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan pairs)
      (cond ((null? pairs) (env-loop (enclosing-environment env)))
            ((eq? var (caar pairs)) (set-cdr! (car pairs) val))
            (else (scan (cdr pairs)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable -- SET!" var)
      (scan (frame-pairs (first-frame env)))))
  (env-loop env))

(set-variable-value! 'key3 'new-val3 test-environment)
(lookup-variable-value 'key3 test-environment)
;; -> 'new-val3


;; change define-variable!
(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan pairs)
      (cond ((null? pairs)
             (add-binding-to-frame! var val frame))
            ((eq? var (caar pairs)) (set-cdr! (car pairs) val))
            (else (scan (cdr pairs)))))
    (scan (frame-pairs frame))))

(define-variable! 'key4 'val4 test-environment)
(lookup-variable-value 'key4 test-environment)
;; -> val4

(define-variable! 'key1 'new-key1 test-environment)
(lookup-variable-value 'key1 test-environment)
;; -> new-key1
