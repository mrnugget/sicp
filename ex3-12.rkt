(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define x (list 'a 'b))

(define y (list 'c 'd))

(define z (append x y))

(cdr x) ;; -> not modified, returns ('b nil)

(define w (append! x y))

;; now x is modified

(cdr x) ;; -> should return ('b 'c 'd)
