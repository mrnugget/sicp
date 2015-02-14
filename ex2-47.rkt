;; with `list` constructor

(define (make-frame origin edge1 edge2) (list origin edge1 edge2))
(define (frame-origin frame) (car frame))
(define (frame-edge1 frame) (car (cdr frame)))
(define (frame-edge2 frame) (car (cdr (cdr frame))))

;; with `cons` constructor
(define (make-frame origin edge1 edge2) (cons origin (cons edge1 edge2)))
(define (frame-origin frame) (car frame))
(define (frame-edge1 frame) (car (cdr frame)))
(define (frame-edge2 frame) (cdr (cdr frame)))
