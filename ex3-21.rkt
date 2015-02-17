;; Ben Bitdiddle doesn't understand that the 'queue' data structure is only
;; two pointers: one to the front item and one to the rear item.
;; As soon as this is understood, the output of the interpreter becomes clear.
;; Even the case of the "empty" queue still pointing (rear-ptr) to a pair.
;; This was explained earlier: "empty-queue?" only checks the front-ptr of the
;; queue, not the rear, so we don't care about the rear.

;; define a procedure `print-queue`

(define (print-queue queue)
  (define (print-pair p)
    (display (car p))
    (display " "))
  (define (print-null)
    (display "()"))
  (define (print-iter l)
    (if (null? l) (print-null)
      (begin
        (print-pair l)
        (print-iter (cdr l)))))
  (if (empty-queue? queue)
         (begin
           (display "empty")
           (newline))
         (print-iter (front-ptr queue))))

