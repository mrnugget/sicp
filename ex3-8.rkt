;; solution 1
(define (g n)
  (define (f x)
    (let ((z n))
      (set! n x)
      z))
  f)

(define f (g 0))

(+ (f 0) (f 1))

;; solution 2
(define (make-f)
  (let ((val 'nothing))
    (define (f x)
      (if (eq? val 'nothing)
        (begin
          (set! val x)
          val)
        val))
    f))

(define newf (make-f))
(+ (newf 0) (newf 1))
