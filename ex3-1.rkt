(define (make-accumulator amount)
  (lambda (a)
    (begin (set! amount (+ amount a))
           amount)))

(define A (make-accumulator 5))
