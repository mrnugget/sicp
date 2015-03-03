;; It's easy to change the syntax for most of the expressions,
;; since we only have to change the hooks in `eval`

;; Change `define` to `def`
(define (definition? exp)
    (tagged-list? exp 'def))

;; Change `lambda` to `fn`
(define (lambda? exp)
  (tagged-list? exp 'fn))

(define (lambda-parameters exp)
  (cadr exp))

(define (lambda-body exp)
  (cddr exp))

(define (make-lambda parameters body)
  (cons 'fn (cons parameters body)))
