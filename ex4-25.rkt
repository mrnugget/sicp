;; It will not work in a strict/applicative-order Scheme variant, since
;; the recursive call to factorial will never stop.
;; In a non-strict/lazy/normal-order Scheme variant, it works, since the
;; recursive call is only made when needed.
