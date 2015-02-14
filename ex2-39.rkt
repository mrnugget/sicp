(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

(define l (list 1 2 3 4 5))

(define (dbg x y)
  (display "x: ")
  (write x)
  (newline)
  (display "y: ")
  (write y)
  (newline)
  (+ x y))

(define (reverse list)
  (if (null? (cdr list))
      list
      (append
       (reverse (cdr list))      ; rest at beginning
       (cons (car list) nil))))  ; first element at the end

(define (reverse-foldr sequence)
  (fold-right (lambda (x y) (append y (cons x nil))) nil sequence))

(define (reverse-foldl sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))
