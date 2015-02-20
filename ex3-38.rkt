;; balance before: 100

;; peter: (set! balance (+ balance 10))
;; paul:  (set! balance (- balance 20))
;; mary:  (set! balance (- balance (/ balance 2)))


;; list all the possible values for balance after the three operations
;; executed sequentially

;; 1.) peter, paul, mary -> 45
;; 2.) peter, mary, paul -> 35
;; 3.) paul, mary, peter -> 50
;; 4.) paul, peter, mary -> 45
;; 5.) mary, peter, paul -> 40
;; 6.) mary, paul, peter -> 40
