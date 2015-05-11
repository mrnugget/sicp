;; Exercise 5.12.  The simulator can be used to help determine the data paths required for implementing a machine with a given controller. Extend the assembler to store the following information in the machine model:
;; 
;; a list of all instructions, with duplicates removed, sorted by instruction type (assign, goto, and so on);
;; a list (without duplicates) of the registers used to hold entry points (these are the registers referenced by goto instructions);
;; a list (without duplicates) of the registers that are saved or restored;
;; for each register, a list (without duplicates) of the sources from which it is assigned (for example, the sources for register val in the factorial machine of figure 5.11 are (const 1) and ((op *) (reg n) (reg val))).


;; solution:
;; I'm changing `make-execution-procedure`, since this is the point where
;; we already do different things depending on the instruction type.
;; I'm not doing every task of the exercise. In this solution I only save
;; the assignment operations. But it should be easy to extend this to the
;; other instructions and the register operations and information.

;; the machine
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (assign-instructions '())                  ;; new
        (the-instruction-sequence '()))
    (let ((the-ops
            (list (list 'initialize-stack
                        (lambda () (stack 'initialize)))))
          (register-table
            (list (list 'pc pc) (list 'flag flag))))
      (define (save-assign-inst inst)           ;; new
        (if (not (assoc inst assign-instructions))
          (begin
            (display "here!")
          (set! assign-instructions (cons (cons inst nil) assign-instructions)))))
      (define (allocate-register name)
        (if (assoc name register-table)
          (error "Multiple defined registers: " name)
          (set! register-table
            (cons (list name (make-register name))
                  register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
            (cadr val)
            (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
            'done
            (begin
              ((instruction-execution-proc (car insts)))
              (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ((eq? message 'save-assign-inst) save-assign-inst) ;; new
              ((eq? message 'get-assign-insts) assign-instructions) ;; new
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (make-execution-procedure inst labels machine pc flag stack ops)
  (cond ((eq? (car inst) 'assign)
         (begin
           ((machine 'save-assign-inst) inst)            ;; new
           (make-assign inst machine labels ops pc)))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'save)
         (begin
           (display (stack-inst-reg-name inst))
           (make-save inst machine stack pc)))
        ((eq? (car inst) 'restore)
         (make-restore inst machine stack pc))
        ((eq? (car inst) 'perform)
         (make-perform inst machine labels ops pc))
        (else (error "Unknown instruction tyupe -- ASSEMBLE"
                     inst))))


;; tests

(define test-machine
  (make-machine
    '(a b c d)
    '()
    '((assign a (const 1))
      (assign b (const 2))
      (assign c (const 3))
      (assign d (const 4)))))
(start test-machine)
(test-machine 'get-assign-insts)
