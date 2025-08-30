(load "cpu.ss")

(define default_CPU (make-CPU 
    (make-vector 32 0)
    0
))

(Print-CPU default_CPU)