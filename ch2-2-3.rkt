;; my version. an iterative version is on page 116

(define (enumerate-interval start end)
  (define (iter n results)
    (if (> n end) results
      (iter (+ n 1) (append results (list n)))))
  (iter start nil))

;; Nested Mappings

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define n 4)

(define withoutflatmap (map (lambda (i)
                              (map (lambda (j) (list i j))
                                   (enumerate-interval 1 (- i 1))))
                            (enumerate-interval 1 n)))
(accumulate append
            nil
            withoutflatmap)

(define (flatmap proc sequence)
  (accumulate append nil (map proc sequence)))

(define withflatmap (flatmap (lambda (i)
                               (map (lambda (j) (list i j))
                                    (enumerate-interval 1 (- i 1))))
                             (enumerate-interval 1 n)))

