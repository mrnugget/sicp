;; Original list-of-values
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
          (list-of-values (rest-operands exps) env))))

;; Write a version of list-of-values that evaluates operands from left to right
;; regardless of the order of evaluation in the underlying Lisp.

(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((first-value (eval (first-operand exps) env)))
      (cons first-value (list-of-values (rest-operands exps) env)))))

;; Also write a version of list-of-values that evaluates operands from right
;; to left.

(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((rest-value (list-of-values (rest-operands exps) env)))
      (cons (eval (first-operand exps) env) rest-value))))
