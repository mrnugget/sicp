(load "./ch5-2.rkt")

(define (make-factorial-machine)
  (make-machine
    (list (list '= =) (list '- -) (list '* *))
    '((assign continue (label fact-done))
      fact-loop
      (test (op =) (reg n) (const 1))
      (branch (label base-case))
      (save continue)
      (save n)
      (assign n (op -) (reg n) (const 1))
      (assign continue (label after-fact))
      (goto (label fact-loop))
      after-fact
      (restore n)
      (restore continue)
      (assign val (op *) (reg n) (reg val))
      (goto (reg continue))
      base-case
      (assign val (const 1))
      (goto (reg continue))
      fact-done)))

(define (run-factorial-machine n)
  (let ((machine (make-factorial-machine)))
    (set-register-contents! machine 'n n)
    (start machine)
    (get-register-contents machine 'val)
    ((machine 'stack) 'print-statistics)))

(define (test-machine from to)
  (if (not (> from to))
    (begin
      (newline)
      (display (list 'n '= from))
      (run-factorial-machine from)
      (test-machine (+ from 1) to))))

(test-machine 1 8)

; (n = 1)
; (total-pushes = 0 maximum-depth = 0)
; (n = 2)
; (total-pushes = 2 maximum-depth = 2)
; (n = 3)
; (total-pushes = 4 maximum-depth = 4)
; (n = 4)
; (total-pushes = 6 maximum-depth = 6)
; (n = 5)
; (total-pushes = 8 maximum-depth = 8)
; (n = 6)
; (total-pushes = 10 maximum-depth = 10)
; (n = 7)
; (total-pushes = 12 maximum-depth = 12)
; (n = 8)
; (total-pushes = 14 maximum-depth = 14)