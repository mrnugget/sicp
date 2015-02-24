(define (stream-limit s tolerance)
  (let ((head (stream-car s)) (rest (stream-cdr s)))
    (if (> tolerance (abs (- (stream-car rest) head)))
          second
          (stream-limit rest tolerance))))
