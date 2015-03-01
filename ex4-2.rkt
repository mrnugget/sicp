;; a) Louis' plan doesn't work since the order is important.
;; When evaluating `(define x 3)` Louis' new order would try to apply `define`,
;; which doesn't work

;; b) Change the syntax from `(procedure operand1 operand2)` to
;; `(call procedure operand1 operand2)`

(define (application? exp)
  (tagged-list? exp 'call))

(define (operator exp)
  (cadr exp))

(define (operands exp)
  (cddr exp))
