(define (let? exp)
  (tagged-list? exp 'let))

(define (let-head exp)
  (cadr exp))

(define (let-head-with-name exp)
  (caddr exp))

(define (let-body exp)
  (cddr exp))

(define (let-body-with-name exp)
  (cdddr exp))

(define (let-name exp)
  (cadr exp))

(define (let-variables headers)
  (map car headers))

(define (let-expressions headers)
  (map cadr headers))

(define (let->combination exp)
  (if (symbol? (cadr exp))
    (list 'begin
      (list 'define (let-name exp) 'lambda (let-variables (let-head-with-name exp)) (let-body-with-name exp))
      (cons (let-name exp) (let-expressions (let-head-with-name exp))))
    (cons
      (list 'lambda (let-variables (let-head exp)) (let-body exp))
      (let-expressions (let-head exp)))))

;; testing:

(define let-without-name (list 'let (list (list 'var1 'exp1) (list 'var2 'exp2)) 'body))

(define let-with-name (list 'let 'proc-name (list (list 'var1 'exp1) (list 'var2 'exp2)) 'body))


(write (let->combination let-without-name))

;; -> ((lambda (var1 var2) (body)) exp1 exp2)

(write (let->combination let-with-name))

;; -> (begin (define proc-name lambda (var1 var2) (body)) (proc-name exp1 exp2))
