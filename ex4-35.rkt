(define (an-integer-between i j)
  (require (<= i j))
  (amb i (an-integer-between (+ i 1) j)))
