#lang planet neil/sicp

; louis' first solution

(define (square x) (* x x))
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items nil))

; this doesn't work because it is not a recursive process. that means, `(car
; things)` gets called first, which means the first element will be the last
; element in the list
; the list will grow like this
;
;    (cons first-element nil)
;    (cons second-element (cons first-element nil))
;    (cons third-element (cons second-element (cons first-element nil)))
;    (cons fourth-element (cons third-element (cons second-element (cons first-element nil))))
;
; which is wrong

; louis' second solution

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square (car things))))))
  (iter items nil))

; the problem here is that there is never a "proper" list created, since `answer`
; initialized to `nil`. the `answer` will look like this:

; (cons nil (cons first-element))
; (cons (cons nil (cons first-element)) second-element)

; the repl proves this:
;
;   -> (square-list (list 1 2 3 4))
;   (mcons (mcons (mcons (mcons '() 1) 4) 9) 16)
