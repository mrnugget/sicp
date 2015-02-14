(define (call-the-cops)
  (display "Calling the cops now"))

(define (make-account balance password)
  (let ((wrong-password 0))
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
              (else (error "Unknown request -- MAKE-ACCOUNT"
                          m)))
        (begin (set! wrong-password (+ wrong-password 1))
               (if (> wrong-password 6)
                 (call-the-cops)
                 (lambda (x) (error "Incorrect password" p x))))))
    dispatch))

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

((acc 'wrong-password 'withdraw) 40)