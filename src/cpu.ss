(import (scheme))
(import (chezscheme))

(load "memory.ss")
(load "bus.ss")

(define-record CPU (
    bus
    x-registers
    pc
))

(define Create-CPU ( 
    case-lambda
    (()            (make-CPU (Create-Bus) (make-vector 32 0) 0))
    ((bus)         (make-CPU bus          (make-vector 32 0) 0))
    ((bus regs)    (make-CPU bus          regs               0))
    ((bus regs pc) (make-CPU bus          regs               pc))))

(define (CPU-Load cpu address bytes . endianness)
    (let ((bus (CPU-bus cpu)))
        (if (null? endianness)
            (Bus-Load bus address bytes)
            (Bus-Load bus address bytes endianness)
        ) 
    ))

(define (CPU-Store cpu address bytes content . endianness)
    (let ((bus (CPU-bus cpu)))
        (if (null? endianness)
            (Bus-Store bus address bytes content)
            (Bus-Store bus address bytes content endianness)
        ) 
    ))

(define x-register-abi-names
    '#("zero" "ra" "sp" "gp" "tp" "t0" "t1" "t2" 
       "s0" "fp" "s1" "a0" "a1" "a2" "a3" "a4"
       "a5" "a6" "a7" "s2" "s3" "s4" "s5" "s6" 
       "s7" "s8" "s9" "s10" "s11" "t3" "t4" "t5" "t6")
)

(define x-register-num->x-register-abi-name
    (lambda (x) (vector-ref x-register-abi-names x)))

(define x-register-abi-name->x-register-num
    (lambda (x) 
        (case x
            ["zero" 0]
            ["ra"   1]
            ["sp"   2]
            ["gp"   3]
            ["tp"   4]
            ["t0"   5]
            ["t1"   6]
            ["t2"   7]
            ["s0"   8]
            ["fp"   8]
            ["s1"   9]
            ["a0"   10]
            ["a1"   11]
            ["a2"   12]
            ["a3"   13]
            ["a4"   14]
            ["a5"   15]
            ["a6"   16]
            ["a7"   17]
            ["s2"   18]
            ["s3"   19]
            ["s4"   20]
            ["s5"   21]
            ["s6"   22]
            ["s7"   23]
            ["s8"   24]
            ["s9"   25]
            ["s10"  26]
            ["s11"  27]
            ["t3"   28]
            ["t4"   29]
            ["t5"   30]
            ["t6"   31]
        )))

(define Print-Registers
    (lambda (regs) (let loop ((x 0))
        (when (< x (vector-length regs))
            (display (x-register-num->x-register-abi-name x))
            (display ": ")
            (display (vector-ref regs x))
            (newline)
            (loop (+ x 1))
        ))
    )
)

(define (Print-CPU cpu)
    (display "x-registers:")
    (newline)
    (Print-Registers (CPU-x-registers cpu))
    (display "pc: ")
    (display (CPU-pc cpu))
)