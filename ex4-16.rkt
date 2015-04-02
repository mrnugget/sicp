;; Change lookup-variable-value to throw an error if the variable has
;; the special value '*unassigned*

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? (car vals) '*unassigned*)
               (error "variable is unassigned")
               (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

;; Write scan-out-defines that takes a procedure body and returns an
;; equivalent one that has no internal definitions

;; Taken from http://community.schemewiki.org/?sicp-ex-4.16 and refactored
(define (scan-out-defines body)
  (define (unassigned-variables definitions)
    (map (lambda (x) (list (definition-variable x) '*unassigned*)) definitions))
  (define (set-values definitions)
    (map (lambda (x) (list 'set! (definition-variable x) (definition-value x)))
         definitions))
  (define (definitions->let exprs definitions non-definitions)
    (cond ((null? exprs)
           (if (null? definitions)
             body
             (list (list 'let (unassigned-variables definitions)
                         (make-begin (append (set-values definitions)
                                             (reverse non-definitions)))))))
          ((definition? (car exprs))
           (definitions->let (cdr exprs) (cons (car exprs) definitions) non-definitions))
          (else (definitions->let (cdr exprs) definitions (cons (car exprs) non-definitions)))))
  (definitions->let body '() '()))

(define test-body (quote ((define blerg 1) (define blub 2) (+ blerg blub))))

(write (scan-out-defines test-body))
