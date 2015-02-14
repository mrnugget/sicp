#lang planet neil/sicp
;
;  Pascal's triangle
;
;              1
;             1 1
;            1 2 1
;           1 3 3 1
;          1 4 6 4 1
;             ...


(define (pas row col)
  (if (or (= col 1) (= row col)) 1
      (+
       (pas (- row 1) (- col 1))
       (pas (- row 1) col))))
