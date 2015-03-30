;; It does not work, because the system version of `map` has references
;; to the system versions of `if` and `cons` and so on. They would not use
;; the metacircular evaluator.
;; Also, the way we defined primitives (as a list) does not work with the system
;; version of map.
