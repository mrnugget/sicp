; Use `car`s and `cdr`s to get 7 from these

; 1.
'(1 3 (5 7) 9)
(define l 
  (cons
    1
    (cons
      3
      (cons
        (cons 5 (cons 7 nil))
        (cons 9 nil)))))

(car (cdr (car (cdr (cdr l)))))
; 7

; 2.

'((7))
(define twolists (cons (cons 7 nil) nil))
(car (car twolists))
; 7

; 3.

'(1 (2 (3 (4 (5 (6 7))))))

(define nested
  (cons 1 (cons (cons 2 (cons (cons 3 (cons (cons 4 (cons (cons 5 (cons (cons 6 (cons 7 nil)) nil)) nil)) nil)) nil)) nil)))

; (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr nested))))))))))))
