(define (run-forever) (run-forever))

(define (try p)
  (if (halts? p p)
    (run-forever)
    'halted))

;; If (try try) halts it will run forever. If it does not halt it returns 'halted
;; even though it runs forever.
