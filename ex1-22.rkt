#lang planet neil/sicp

(define (square n)
  (* n n))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; given by ex1.22

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; find three smallest primes larger than 1000

(define (find-primes start max)
  (define (finished)
    (newline)
    (display "done"))
  
  (define (iter start max found)
    (cond ((= max found) (finished))
          ((timed-prime-test start) (iter (+ start 1) max (+ found 1)))
          (else (iter (+ start 1) max found))))
  (iter start max 0))
