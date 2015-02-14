(define (hello name)
  (display "Hello ")
  (display name)
  (display "!")
  (newline))


(define (make-monitored proc)
  (let ((called 0))
    (lambda (x)
      (if (eq? x 'how-many-calls?)
        called
        (begin
          (set! called (+ called 1))
          (proc x))))))

;; -> (define monitored-hello (make-monitored hello))
;; -> (monitored-hello "bob")
;; Hello bob!
;; -> (monitored-hello "bob")
;; Hello bob!
;; -> (monitored-hello 'how-many-calls?)
;; 2
;; -> (monitored-hello "bob")
;; Hello bob!
;; -> (monitored-hello 'how-many-calls?)
;; 3
