(list 1 (list 2 (list 3 4)))
(mcons 1 (mcons (mcons 2 (mcons (mcons 3 (mcons 4 '())) '())) '()))
; (1 (2 (3 4)

; in contrast to this:
(cons 1 (cons 2 (cons 3 (cons 4 nil))))

; box and pointer
;
;   |1, *|
;       |
;     |*, nil|
;      |
;     |2, *|
;         |
;        |*, nil|
;         |
;       |3, 4|
; or so...


; tree
;

;       .
;      / \
;     1   .
;        / \
;           .
;          / \
;         2   .
;            / \
;               .
;              / \
;             3   4
