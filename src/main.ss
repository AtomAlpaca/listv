(load "memory.ss")
(load "bus.ss")
(load "cpu.ss")

(define default_CPU (Create-CPU))

(Print-CPU default_CPU)

(CPU-Store default_CPU #x0102 4 #xffffffff)
(display "\n")
(display (CPU-Load default_CPU #x0102 2))