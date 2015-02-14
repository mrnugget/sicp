(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (if (eq? p password)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'check-pass) check-pass)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m)))
      (lambda (x) (error "Incorrect password" p x))))
  dispatch)

(define (make-joint acc pass new-pass)
  (define (dispatch p m)
    (if (eq? p new-pass)
      (acc pass m)
      (lambda (x) (error "Incorrect password"))))
  dispatch)

(define acc (make-account 100 'secret-password))

(define another-acc (make-joint acc 'secret-password 'rosebud))

((another-acc 'rosebud 'withdraw) 10)

((another-acc 'wrong-pw 'withdraw) 10)

((acc 'secret-password 'withdraw) 10)
