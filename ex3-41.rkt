;; It doesn't make sense to serialize the access to `balance`, since it's a
;; simple read-operation that could occurr between `withdraw` and `deposit`.
